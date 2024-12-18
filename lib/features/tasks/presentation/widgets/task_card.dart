import 'package:auto_route/auto_route.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/date_time_extension.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/router/app_router.gr.dart';
import 'package:test_task_manager/features/tasks/domain/entities/task.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';
import 'package:collection/collection.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    required this.onDraggableCanceled,
    required this.task,
    required this.onWillAccept,
    required this.onAccept,
    super.key,
  });

  final VoidCallback onDraggableCanceled;
  final Task task;
  final bool Function(Task task)? onWillAccept;
  final void Function(Task task)? onAccept;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Task>(
      data: widget.task,
      maxSimultaneousDrags: 1,
      onDraggableCanceled: (value1, value2) {
        widget.onDraggableCanceled();
      },
      feedback: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: _CardView(
            task: widget.task,
          ),
        ),
      ),
      childWhenDragging: Container(
        margin: EdgeInsets.only(
          bottom: 10.h,
        ),
        height: 106.h,
        child: DottedBorder(
          strokeWidth: 2.w,
          color: context.themeData.secondaryHeaderColor,
          dashPattern: const <double>[2, 2],
          padding: const EdgeInsets.all(1),
          radius: Radius.circular(4.r),
          child: const SizedBox.expand(),
        ),
      ),
      child: DragTarget<Task>(
        onAcceptWithDetails: (data) {
          widget.onAccept?.call(data.data);
        },
        onWillAcceptWithDetails: (data) {
          return widget.onWillAccept?.call(data.data) ?? true;
        },
        builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
        ) {
          return _CardView(
            task: widget.task,
          );
        },
      ),
    );
  }
}

class _CardView extends StatelessWidget {
  const _CardView({
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final completeTimeStamp = context
        .read<TasksBloc>()
        .state
        .completeTasks
        .firstWhereOrNull((e) => e.taskId == task.id)
        ?.completeTimestamp;
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          context.router.push(TaskRoute(taskId: task.id));
        },
        child: Container(
          height: 120.h,
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: context.themeData.primaryColorLight,
            borderRadius: BorderRadius.circular(7.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                task.content,
                overflow: TextOverflow.ellipsis,
                style: context.themeData.textTheme.bodyLarge?.copyWith(
                  color: context.themeData.colorScheme.primary,
                ),
              ),
              if (task.priority < 3)
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      context.read<TasksBloc>().add(TasksEvent$Update(
                          taskId: task.id, priority: task.priority + 1));
                    },
                    child: Icon(
                      Icons.arrow_right_alt_outlined,
                      size: 50.h,
                      color: context.themeData.colorScheme.secondary
                          .withOpacity(0.2),
                    ),
                  ),
                ),
              if (completeTimeStamp != null && task.priority == 3)
                Text(
                  '${context.tr(AppStrings.completedAt)} ${completeTimeStamp.toHistoryFormat()}',
                  style: context.themeData.textTheme.bodySmall?.copyWith(
                    color: context.themeData.colorScheme.error,
                  ),
                ),
              Row(
                children: [
                  _CommentsButton(
                    taskId: task.id,
                    taskContent: task.content,
                    commentsCount: task.commentCount,
                  ),
                  const Spacer(),
                  Text(
                    '${context.tr(AppStrings.createdAt)}: ${task.createdAt.toLocal().toPrimaryFormat()}',
                    style: context.themeData.textTheme.bodySmall?.copyWith(
                      color: context.themeData.colorScheme.primary,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CommentsButton extends StatelessWidget {
  const _CommentsButton({
    required this.taskId,
    required this.taskContent,
    required this.commentsCount,
  });
  final String taskId;
  final String taskContent;
  final int commentsCount;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.push(
          CommentsRoute(taskId: taskId, taskContent: taskContent),
        );
      },
      child: Row(
        children: [
          Icon(
            Icons.message,
            color: context.themeData.colorScheme.secondary.withOpacity(0.2),
          ),
          SizedBox(width: 5.w),
          Text(
            '$commentsCount',
            style: context.themeData.textTheme.bodyMedium?.copyWith(
              color: context.themeData.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
