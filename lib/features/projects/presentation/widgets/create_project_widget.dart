import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/ui/widgets/buttons/primary_button.dart';
import 'package:test_task_manager/core/ui/widgets/item_creation_widget.dart';
import 'package:test_task_manager/core/ui/widgets/text_field/primary_text_field.dart';
import 'package:test_task_manager/core/utils/validators.dart';
import 'package:test_task_manager/features/projects/presentation/bloc/projects_bloc.dart';
import 'package:test_task_manager/features/projects/presentation/bloc/projects_event.dart';

class CreateProjectWidget extends StatefulWidget {
  const CreateProjectWidget({super.key});

  @override
  State<CreateProjectWidget> createState() => _CreateProjectWidgetState();
}

class _CreateProjectWidgetState extends State<CreateProjectWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: IntrinsicHeight(
        child: ItemCreationWidget(
          title: context.tr(AppStrings.createProject),
          children: [
            PrimaryTextField(
              placeholder: context.tr(AppStrings.projectName),
              validator: (v) => Validator.required(context, v),
              controller: _nameController,
            ),
            SizedBox(height: 50.h),
            PrimaryButton(
              title: context.tr(AppStrings.create),
              onTap: () {
                final isValid = _formKey.currentState?.validate() ?? false;
                if (!isValid) {
                  return;
                }
                context.read<ProjectsBloc>().add(
                    ProjectsEvent$CreateProject(name: _nameController.text));
                Navigator.of(context).pop();
              },
            ),
            SizedBox(height: 30.h + MediaQuery.of(context).viewInsets.bottom),
          ],
        ),
      ),
    );
  }
}
