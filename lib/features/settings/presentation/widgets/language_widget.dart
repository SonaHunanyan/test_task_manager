import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_task_manager/core/constants/app_strings.dart';
import 'package:test_task_manager/core/extenstions/string_extension.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/data_picker/primary_data_picker.dart';
import 'package:test_task_manager/features/home/presentation/model/languages.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            useRootNavigator: true,
            builder: (context) {
              return PrimaryDataPicker<Languages>(
                onPick: (item) {
                  context.setLocale(item.locale);
                },
                items: Languages.values,
              );
            });
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width - 60.w,
        padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 10.w),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: context.themeData.colorScheme.tertiary,
          borderRadius: BorderRadius.circular(7.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.tr(AppStrings.flag).toFlagEmojy(),
              style: context.themeData.textTheme.headlineSmall,
            ),
            Text(
              context.tr(AppStrings.language),
              style: context.themeData.textTheme.headlineSmall
                  ?.copyWith(color: context.themeData.colorScheme.primary),
            ),
            Icon(
              Icons.keyboard_arrow_down,
              color: context.themeData.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
