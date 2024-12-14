import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class PrimaryPopup<T> extends StatelessWidget {
  const PrimaryPopup({
    required this.items,
    required this.onSelected,
    this.selectedItem,
    super.key,
  });

  final List<T> items;
  final ValueSetter<T> onSelected;
  final T? selectedItem;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<T>(
      style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(context
              .themeData.textTheme.bodyMedium
              ?.copyWith(color: context.themeData.colorScheme.primary))),
      initialValue: selectedItem,
      constraints: BoxConstraints(maxHeight: 100.h, minWidth: 100.w),
      onSelected: onSelected,
      icon: _SelectedButtonWidget('${selectedItem ?? ''}'),
      itemBuilder: (BuildContext context) {
        return items.map((T item) {
          return PopupMenuItem<T>(
            value: item,
            child: _TextWidget('$item'),
          );
        }).toList();
      },
    );
  }
}

class _SelectedButtonWidget extends StatelessWidget {
  const _SelectedButtonWidget(this.title);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          color: context.themeData.colorScheme.secondary.withOpacity(0.2)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: _TextWidget(title),
          ),
          SizedBox(width: 2.w),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: context.themeData.textTheme.bodyMedium
          ?.copyWith(color: context.themeData.colorScheme.primary),
    );
  }
}
