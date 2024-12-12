import 'package:test_task_manager/core/extenstions/theme_extenstion.dart';
import 'package:test_task_manager/core/ui/widgets/snackbars/primary_snackbar.dart';

class ErrorSnackBar extends PrimarySnackbar {
  ErrorSnackBar(
    super.context, {
    required super.text,
    super.key,
  }) : super(backgroundColor: context.themeData.colorScheme.error);
}
