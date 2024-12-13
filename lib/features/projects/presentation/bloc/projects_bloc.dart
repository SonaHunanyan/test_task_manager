import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_manager/features/projects/domain/entities/project.dart';
import 'package:test_task_manager/features/projects/domain/entities/project_result.dart';
import 'package:test_task_manager/features/projects/domain/repositories/project_repository.dart';
import 'package:test_task_manager/features/projects/presentation/bloc/projects_event.dart';
import 'package:test_task_manager/features/projects/presentation/bloc/projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc({required this.taskRepository}) : super(const ProjectsState()) {
    on<ProjectsEvent>((event, emit) => switch (event) {
          ProjectsEvent$Get() => _get(event, emit),
          ProjectsEvent$CreateProject() => _create(event, emit),
        });

    add(const ProjectsEvent$Get());
  }

  final IProjectRepository taskRepository;

  Future<void> _get(
      ProjectsEvent$Get event, Emitter<ProjectsState> emit) async {
    final tasksResult = await taskRepository.getProjects();
    switch (tasksResult) {
      case ProjectResult$Success<List<Project>>():
        emit(ProjectsState(tasks: tasksResult.data));
      case ProjectResult$Failure<List<Project>>():
        emit(const ProjectsState$FailToGet());
    }
  }

  Future<void> _create(
      ProjectsEvent$CreateProject event, Emitter<ProjectsState> emit) async {
    final taskResult = await taskRepository.createProject(
      name: event.name,
    );
    switch (taskResult) {
      case ProjectResult$Success<Project>():
        final tasks = state.tasks..add(taskResult.data);
        emit(ProjectsState(tasks: tasks));
      case ProjectResult$Failure<Project>():
        emit(const ProjectsState$FailToGet());
    }
  }
}
