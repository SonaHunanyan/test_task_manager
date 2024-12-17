import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_back_button.dart';
import 'package:test_task_manager/core/ui/widgets/loader/primary_loader.dart';
import 'package:test_task_manager/features/comments/domain/repositories/comment_repository.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_bloc.dart';
import 'package:test_task_manager/features/comments/presentation/bloc/comments_state.dart';
import 'package:test_task_manager/features/comments/presentation/widgets/comment_item_widget.dart';
import 'package:test_task_manager/features/comments/presentation/widgets/comments_text_field.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_bloc.dart';
import 'package:test_task_manager/features/tasks/presentation/bloc/tasks_event.dart';

@RoutePage()
class CommentsScreen extends StatelessWidget {
  const CommentsScreen({
    required this.taskId,
    required this.taskContent,
    super.key,
  });

  final String taskId;
  final String taskContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.themeData.colorScheme.onSurface,
      appBar: AppBar(
        leading: const PrimaryBackButton(),
        leadingWidth: 100.w,
        title: Text(
          taskContent,
          style: context.themeData.textTheme.bodyLarge?.copyWith(
            color: context.themeData.colorScheme.primary,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: BlocProvider<CommentsBloc>(
            create: (context) => CommentsBloc(
                taskId: taskId,
                commentRepository: GetIt.I.get<ICommentRepository>()),
            child: BlocConsumer<CommentsBloc, CommentsState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is CommentsState$Loading) {
                    return const PrimaryLoader();
                  }
                  if (state is CommentsState$Created) {
                    context
                        .read<TasksBloc>()
                        .add(TasksEvent$IncreaseCommentsCount(taskId: taskId));
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: state.comments.isEmpty
                            ? Align(
                                child: Text(
                                  AppStrings.notFound,
                                  textAlign: TextAlign.center,
                                  style: context.themeData.textTheme.bodyMedium
                                      ?.copyWith(
                                    color: context
                                        .themeData.colorScheme.outlineVariant,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                reverse: true,
                                itemCount: state.comments.length,
                                itemBuilder: (context, index) {
                                  final comments =
                                      state.comments.reversed.toList();
                                  final comment = comments[index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: CommentItemWidget(
                                      comment: comment,
                                      prevCommentDate:
                                          index == comments.length - 1
                                              ? null
                                              : comments[index + 1].postedAt,
                                    ),
                                  );
                                },
                              ),
                      ),
                      SizedBox(height: 10.h),
                      const CommentsTextField(),
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom + 20.h,
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
