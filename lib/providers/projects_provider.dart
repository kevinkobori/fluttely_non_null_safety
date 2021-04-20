import 'dart:core';
import 'package:fluttely/models/project_model.dart';
import 'package:fluttely/app/data/projects_data.dart';

class ProjectsState {
  final Project project1 = Project.fromMap(projectsJson[0]);
  final Project project2 = Project.fromMap(projectsJson[1]);

  List<Project> get category1 => [project1, project2];

  final Project project3 = Project.fromMap(projectsJson[2]);
  final Project project4 = Project.fromMap(projectsJson[3]);

  List<Project> get category2 => [project3, project4];

  List<Project> get allItems => [project1, project2, project3, project4];
}

class CategoryProjects {
  String title;
  List<Project> items;
  CategoryProjects({this.title, this.items});
}

final categoriesProjects = [
  CategoryProjects(
    title: 'Category 1',
    items: ProjectsState().category1,
  ),
  CategoryProjects(
    title: 'Category 2',
    items: ProjectsState().category2,
  ),
];