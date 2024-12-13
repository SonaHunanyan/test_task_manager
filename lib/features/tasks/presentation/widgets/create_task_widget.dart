import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class CreateTaskWidget extends StatelessWidget {
  const CreateTaskWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: context.themeData.colorScheme.onSurface,
      child: Column(
        children: [
          SizedBox(height: 50.h),
          Text(
            AppStrings.createTask,
            style: context.themeData.textTheme.titleLarge?.copyWith(
              color: context.themeData.colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
