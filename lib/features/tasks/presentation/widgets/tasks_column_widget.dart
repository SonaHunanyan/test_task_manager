import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/presentation/model/task_status.dart';
import 'package:test_task_manager/features/tasks/presentation/widgets/task_card.dart';

class TasksColumnWidget extends StatefulWidget {
  const TasksColumnWidget({
    required this.tasks,
    required this.onDraggableCanceled,
    required this.columnType,
    required this.onAccept,
    required this.onWillAccept,
    this.index,
    super.key,
  });

  final List<Task> tasks;
  final int? index;
  final VoidCallback onDraggableCanceled;
  final TaskStatus columnType;
  final ValueSetter<Task> onAccept;
  final void Function(int index, Task task) onWillAccept;

  @override
  State<TasksColumnWidget> createState() => _TasksColumnWidgetState();
}

class _TasksColumnWidgetState extends State<TasksColumnWidget> {
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return DragTarget<Task>(
      onAcceptWithDetails: (data) {
        widget.onAccept(data.data);
      },
      onWillAcceptWithDetails: (data) {
        widget.onWillAccept(0, data.data);
        return true;
      },
      builder: (context, candidateData, rejectedData) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 32.h,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.columnType.columnColor(context),
              borderRadius: BorderRadius.circular(4.r),
            ),
            margin: EdgeInsets.only(
              top: 16.h,
            ),
            padding: EdgeInsets.only(
              left: 8.w,
              top: 2.h,
            ),
            child: Text(
              context.tr(widget.columnType.title),
              style: context.themeData.textTheme.bodyLarge?.copyWith(
                color: context.themeData.colorScheme.onSurface,
              ),
            ),
          ),
          if (widget.tasks.isEmpty)
            Center(
              child: Container(
                height: 160.h,
                width: 178.h,
                alignment: Alignment.center,
                child: Text(
                  context.tr(AppStrings.notFound),
                  textAlign: TextAlign.center,
                  style: context.themeData.textTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.outlineVariant,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                children: List.generate(
                  widget.tasks.length,
                  (index) {
                    final listIndex =
                        widget.index == null || index <= widget.index!
                            ? index
                            : index - 1;
                    return TaskCard(
                      onAccept: (data) {
                        widget.onAccept(data);
                      },
                      task: widget.tasks[index],
                      onWillAccept: (data) {
                        if (data == widget.tasks[listIndex]) {
                          return false;
                        }
                        widget.onWillAccept(index, data);
                        return true;
                      },
                      onDraggableCanceled: widget.onDraggableCanceled,
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
