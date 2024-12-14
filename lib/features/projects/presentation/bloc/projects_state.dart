import 'package:equatable/equatable.dart';
import 'package:test_task_manager/features/projects/domain/entities/project.dart';

class ProjectsState extends Equatable {
  const ProjectsState({this.projects = const []});
  final List<Project> projects;

  @override
  List<Object?> get props => projects;
}

class ProjectsState$FailToGet extends ProjectsState {
  const ProjectsState$FailToGet();
}

class ProjectsState$FailToCreate extends ProjectsState {
  const ProjectsState$FailToCreate({required super.projects});
}
