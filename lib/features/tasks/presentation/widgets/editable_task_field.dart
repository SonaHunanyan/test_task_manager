import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/text_field/primary_text_field.dart';
import 'package:test_task_manager/core/utils/validators.dart';

class EditableTaskField extends StatefulWidget {
  const EditableTaskField({
    required this.title,
    required this.controller,
    required this.onCancelEditing,
    required this.onEdit,
    super.key,
  });

  final String title;
  final TextEditingController controller;
  final VoidCallback onCancelEditing;
  final VoidCallback onEdit;

  @override
  State<EditableTaskField> createState() => _EditableTaskFieldState();
}

class _EditableTaskFieldState extends State<EditableTaskField> {
  final _isEditing = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: context.themeData.textTheme.bodyLarge
                ?.copyWith(color: context.themeData.colorScheme.primary),
          ),
          SizedBox(height: 5.h),
          ValueListenableBuilder(
            valueListenable: _isEditing,
            builder: (context, value, child) => PrimaryTextField(
              controller: widget.controller,
              readOnly: !value,
              validator: Validator.required,
              suffix: value
                  ? Row(
                      children: [
                        _IconButton(
                            icon: Icons.close,
                            color: context.themeData.colorScheme.error,
                            onTap: () {
                              widget.onCancelEditing();
                              _isEditing.value = false;
                            }),
                        SizedBox(width: 5.w),
                        _IconButton(
                            icon: Icons.check,
                            color: context.themeData.primaryColorDark,
                            onTap: () {
                              final isValid =
                                  _formKey.currentState?.validate() ?? false;
                              if (!isValid) {
                                return;
                              }
                              widget.onEdit();
                              _isEditing.value = false;
                            })
                      ],
                    )
                  : _IconButton(
                      onTap: () {
                        _isEditing.value = true;
                      },
                      icon: Icons.edit,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.icon,
    required this.onTap,
    this.color,
  });
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(
        icon,
        color: color ?? context.themeData.colorScheme.secondary,
      ),
    );
  }
}
