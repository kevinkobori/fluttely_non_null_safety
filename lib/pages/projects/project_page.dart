import 'package:flutter/material.dart';
import 'package:fluttely/global/layouts/projects_layout.dart';
import 'package:fluttely/models/project_model.dart';
import 'package:fluttely/app/router/app_state.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({this.projects, this.project, this.onTapped, this.appState});

  final List<Project> projects;

  final Project project;

  final Function(Project) onTapped;

  final FluttelyAppState appState;
  
  @override
  Widget build(BuildContext context) {
    return ProjectsLayout(
      projects: projects,
      project: project,
      onTapped: onTapped,
      appState: appState,
    );
  }
}
