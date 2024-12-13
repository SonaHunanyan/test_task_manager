import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class ItemCreationWidget extends StatelessWidget {
  const ItemCreationWidget({
    required this.title,
    required this.children,
    super.key,
  });
  final String title;
  final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      color: context.themeData.colorScheme.onSurface,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Column(
        children: [
          SizedBox(height: 30.h),
          Text(
            title,
            style: context.themeData.textTheme.titleLarge?.copyWith(
              color: context.themeData.colorScheme.primary,
            ),
          ),
          SizedBox(height: 20.h),
          ...children
        ],
      ),
    );
  }
}
