import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class PrimaryDataPicker<T> extends StatelessWidget {
  const PrimaryDataPicker(
      {required this.onPick, required this.items, super.key});

  final ValueSetter<T> onPick;
  final List<T> items;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      children: items.map((item) {
        return ListTile(
          leading: Icon(
            Icons.check_circle_outline,
            color: context.themeData.colorScheme.primary,
          ),
          title: Text(
            '$item',
            style: context.themeData.textTheme.bodyMedium?.copyWith(
              color: context.themeData.colorScheme.primary,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
            onPick.call(item);
          },
        );
      }).toList(),
    );
  }
}
