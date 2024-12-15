import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_state.dart';
import 'package:test_task_manager/features/tasks/presentation/model/task_status.dart';
import 'package:test_task_manager/features/tasks/presentation/widgets/tasks_column_widget.dart';

class KanbanWidget extends StatefulWidget {
  const KanbanWidget({
    super.key,
  });

  @override
  State<KanbanWidget> createState() => _KanbanWidgetState();
}

class _KanbanWidgetState extends State<KanbanWidget> {
  final _pageController = PageController(viewportFraction: 0.7);

  (int, TaskStatus, Task)? _targetItem;

  void _clearIndexes() {
    setState(() {
      _targetItem = null;
    });
  }

  void _updateTarget((int, TaskStatus, Task) target) {
    _targetItem = target;
    const pages = TaskStatus.values;
    final targetPage = pages.indexOf(target.$2);
    if (_pageController.page?.round() != targetPage) {
      _pageController.animateToPage(
        targetPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }

  void _updateTask() {
    final item = _targetItem;
    if (item == null) {
      return;
    }
    context.read<TasksBloc>().add(
        TasksEvent$Update(taskId: item.$3.id, priority: item.$2.index + 1));
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksBloc, TasksState>(builder: (context, state) {
      return PageView(
        controller: _pageController,
        children: [
          for (final taskStatus in TaskStatus.values)
            Padding(
              padding: taskStatus.padding,
              child: TasksColumnWidget(
                onWillAccept: (index, data) {
                  _updateTarget(
                    (index, taskStatus, data),
                  );
                },
                columnType: taskStatus,
                tasks: state.tasks
                    .where((e) => e.priority == taskStatus.index + 1)
                    .toList(),
                index: _targetItem?.$2 == taskStatus ? _targetItem?.$1 : null,
                onAccept: (task) {
                  _updateTask();
                  _clearIndexes();
                },
                onDraggableCanceled: _clearIndexes,
              ),
            ),
        ],
      );
    });
  }
}

extension on TaskStatus {
  EdgeInsets get padding => switch (this) {
        TaskStatus.queue => EdgeInsets.only(right: 8.w),
        TaskStatus.inProgress => EdgeInsets.only(left: 8.w, right: 8.w),
        TaskStatus.done => EdgeInsets.only(left: 8.w),
      };
}
