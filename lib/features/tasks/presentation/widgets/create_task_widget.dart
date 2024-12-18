import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_button.dart';
import 'package:test_task_manager/core/ui/widgets/item_creation_widget.dart';
import 'package:test_task_manager/core/ui/widgets/popup/primary_popup.dart';
import 'package:test_task_manager/core/ui/widgets/snackbars/error_snack_bar.dart';
import 'package:test_task_manager/core/ui/widgets/text_field/primary_text_field.dart';
import 'package:test_task_manager/core/utils/validators.dart';
import 'package:test_task_manager/features/projects/domain/entities/project.dart';
import 'package:test_task_manager/features/projects/presentation/bloc/projects_bloc.dart';

class CreateTaskWidget extends StatefulWidget {
  const CreateTaskWidget({required this.onCreate, super.key});
  final void Function(String projectId, String content) onCreate;
  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  Project? _selectedProject;

  void _onCreate() {
    final isValid = _formKey.currentState?.validate() ?? false;
    final project = _selectedProject;
    if (!isValid) {
      return;
    }
    if (project == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        ErrorSnackBar(
          context,
          text: context.tr(AppStrings.projectIsRequired),
        ),
      );
      return;
    }
    widget.onCreate(project.id, _contentController.text);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.h + MediaQuery.of(context).viewInsets.bottom,
      child: Scaffold(
        backgroundColor: context.themeData.colorScheme.onSurface,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: ItemCreationWidget(
              title: context.tr(AppStrings.createTask),
              children: [
                PrimaryTextField(
                  placeholder: context.tr(AppStrings.content),
                  validator: (v) => Validator.required(context, v),
                  controller: _contentController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.tr(AppStrings.selectProject),
                      style: context.themeData.textTheme.bodyLarge?.copyWith(
                          color: context.themeData.colorScheme.primary),
                    ),
                    SizedBox(width: 10.w),
                    PrimaryPopup<Project>(
                      selectedItem: _selectedProject,
                      items: context.read<ProjectsBloc>().state.projects,
                      onSelected: (value) {
                        setState(() {
                          _selectedProject = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50.h),
                PrimaryButton(
                  title: context.tr(AppStrings.create),
                  onTap: _onCreate,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
