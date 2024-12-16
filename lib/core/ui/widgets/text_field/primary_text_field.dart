import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class PrimaryTextField extends FormField<String> {
  PrimaryTextField({
    this.controller,
    this.placeholder,
    this.keyboardType,
    this.suffix,
    this.readOnly = false,
    super.validator,
    super.key,
  }) : super(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (field) {
            void onChangedHandler(String value) {
              field.didChange(value);
            }

            return _TextFieldWidget(
              error: field.errorText,
              controller: controller,
              placeholder: placeholder,
              keyboardType: keyboardType,
              prefix: suffix,
              onChanged: onChangedHandler,
              readOnly: readOnly,
            );
          },
        );

  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffix;
  final bool readOnly;
}

class _TextFieldWidget extends StatelessWidget {
  const _TextFieldWidget({
    this.controller,
    this.placeholder,
    this.keyboardType,
    this.onChanged,
    this.prefix,
    this.error,
    this.readOnly = false,
  });
  final String? placeholder;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? error;
  final void Function(String)? onChanged;
  final Widget? prefix;
  final bool readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          alignment: Alignment.center,
          height: 37.h,
          decoration: BoxDecoration(
            color: context.themeData.colorScheme.secondary.withOpacity(0.2),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: readOnly,
                  onChanged: onChanged,
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  keyboardType: keyboardType,
                  controller: controller,
                  style: context.themeData.textTheme.bodyMedium?.copyWith(
                    color: context.themeData.colorScheme.primary,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    hintText: placeholder,
                    hintStyle: context.themeData.textTheme.bodyMedium?.copyWith(
                      color: context.themeData.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              if (prefix != null)
                Padding(
                  padding: EdgeInsets.only(left: 8.w),
                  child: prefix,
                ),
            ],
          ),
        ),
        if (error != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h, left: 5.w),
            child: Text(
              error!,
              style: context.themeData.textTheme.bodySmall?.copyWith(
                color: context.themeData.colorScheme.error,
              ),
            ),
          )
      ],
    );
  }
}
