import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';

class PrimaryLoader extends StatelessWidget {
  const PrimaryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.progressiveDots(
      color: context.themeData.colorScheme.secondary,
      size: 100.w,
    );
  }
}
