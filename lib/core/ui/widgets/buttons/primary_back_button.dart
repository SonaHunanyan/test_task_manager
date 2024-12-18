import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class PrimaryBackButton extends StatelessWidget {
  const PrimaryBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.router.back();
      },
      child: Row(
        children: [
          Icon(
            Icons.chevron_left,
            color: context.themeData.colorScheme.primary,
          ),
          SizedBox(width: 5.w),
          Text(
            context.tr(AppStrings.back),
            style: context.themeData.textTheme.bodyMedium?.copyWith(
              color: context.themeData.colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
