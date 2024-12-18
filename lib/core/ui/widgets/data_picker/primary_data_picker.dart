import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/utils/data_picker_options.dart';

class PrimaryDataPicker<T extends DataPickerOptions> extends StatelessWidget {
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
          leading: item.icon(context),
          title: Text(
            context.tr(item.toString()),
            style: context.themeData.textTheme.bodyMedium?.copyWith(
              color: item.color(context),
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
