import 'package:rest_api/rest_api.dart';
import 'package:test_task_manager/features/tasks/domain/entities/due.dart';

class DueMapper {
  static Due toDue(DueDto dto) {
    return Due(
      date: dto.date,
      isRecurring: dto.isRecurring,
      datetime: dto.datetime,
      string: dto.string,
      timezone: dto.timezone,
    );
  }
}
