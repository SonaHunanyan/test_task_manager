import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.title,
    this.onTap,
    this.isLoading = false,
    this.enabled = true,
    this.horizontalPadding = 15,
    this.height = 32,
    this.backgroundColor,
    super.key,
  });
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool enabled;
  final double horizontalPadding;
  final double height;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading || !enabled,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding.w),
          height: height.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: backgroundColor ??
                context.themeData.colorScheme.secondary
                    .withOpacity(enabled ? 1 : 0.3),
            borderRadius: BorderRadius.circular(6),
          ),
          child: isLoading
              ? SizedBox(
                  width: height - 12,
                  height: height - 12,
                  child: CircularProgressIndicator(
                    color: context.themeData.colorScheme.primaryContainer,
                    strokeWidth: 2,
                  ),
                )
              : Text(
                  title,
                  style: context.themeData.textTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.primaryContainer,
                  ),
                ),
        ),
      ),
    );
  }
}
