sealed class ProjectsEvent {
  const ProjectsEvent();
}

class ProjectsEvent$Get extends ProjectsEvent {
  const ProjectsEvent$Get();
}

class ProjectsEvent$CreateProject extends ProjectsEvent {
  const ProjectsEvent$CreateProject({
    required this.name,
  });
  final String name;
}
