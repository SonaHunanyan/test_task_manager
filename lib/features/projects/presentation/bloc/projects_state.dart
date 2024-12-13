import 'package:equatable/equatable.dart';
import 'package:test_task_manager/features/projects/domain/entities/project.dart';

class ProjectsState extends Equatable {
  const ProjectsState({this.tasks = const []});
  final List<Project> tasks;

  @override
  List<Object?> get props => tasks;
}

class ProjectsState$FailToGet extends ProjectsState {
  const ProjectsState$FailToGet();
}

class ProjectsState$FailToCreate extends ProjectsState {
  const ProjectsState$FailToCreate({required super.tasks});
}
