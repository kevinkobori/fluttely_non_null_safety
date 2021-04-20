import 'dart:core';
import 'package:flutter/material.dart';
import 'package:fluttely/models/project_model.dart';
import 'package:fluttely/providers/projects_provider.dart';
import 'package:fluttely/models/component_model.dart';
import 'package:fluttely/providers/components_provider.dart';
import 'package:fluttely/models/article_model.dart';
import 'package:fluttely/providers/articles_provider.dart';

class FluttelyAppState extends ChangeNotifier {
  /////////////////////////////// APP STATE

  int _selectedIndex;

  FluttelyAppState() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int idx) {
    _selectedIndex = idx;
    // if (_selectedIndex != 0) {
    //   selectedProject = null;//ProjectsState().allItems[0];
    // }
    // if (_selectedIndex != 1) {
    //   selectedComponent = null;//ComponentsState().allItems[0];
    // }
    // if (_selectedIndex != 2) {
    //   selectedArticle = null;//ArticlesState().allItems[0];
    // }
    notifyListeners();
  }

  /////////////////////////////// Project State

  Project _selectedProject = ProjectsState().allItems[0];

  List<Project> _projectsProvider = ProjectsState().allItems;

  Project get selectedProject => _selectedProject;

  List<Project> get listProjectsProvider => _projectsProvider;

  set selectedProject(Project project) {
    _selectedProject = project;
    notifyListeners();
  }

  String getSelectedProjectById() {
    return _selectedProject.id;
  }

  void setSelectedProjectById(String id) {
    var projectIndex = _projectsProvider.indexWhere((element) {
      return element.id == id;
    });
    if (projectIndex != null) {
      _selectedProject = _projectsProvider[projectIndex];
      notifyListeners();
    } else {
      return;
    }
  }

  /////////////////////////////// Components State

  Component _selectedComponent = ComponentsState().allItems[0];

  List<Component> _componentsProvider = ComponentsState().allItems;

  Component get selectedComponent => _selectedComponent;

  List<Component> get listComponentsProvider => _componentsProvider;

  set selectedComponent(Component component) {
    _selectedComponent = component;
    notifyListeners();
  }

  String getSelectedComponentById() {
    return _selectedComponent.id;
  }

  void setSelectedComponentById(String id) {
    var componentIndex = _componentsProvider.indexWhere((element) {
      return element.id == id;
    });
    if (componentIndex != null) {
      _selectedComponent = _componentsProvider[componentIndex];
      notifyListeners();
    } else {
      return;
    }
  }

  /////////////////////////////// Articles State

  Article _selectedArticle = ArticlesState().allItems[0];

  List<Article> _articlesProvider = ArticlesState().allItems;

  Article get selectedArticle => _selectedArticle;

  List<Article> get listArticlesProvider => _articlesProvider;

  set selectedArticle(Article article) {
    _selectedArticle = article;
    notifyListeners();
  }

  String getSelectedArticleById() {
    return _selectedArticle.id;
  }

  void setSelectedArticleById(String id) {
    var articleIndex = _articlesProvider.indexWhere((element) {
      return element.id == id;
    });
    if (articleIndex != null) {
      _selectedArticle = _articlesProvider[articleIndex];
      notifyListeners();
    } else {
      return;
    }
  }
}
