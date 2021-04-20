import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttely/app/router/app_state.dart';
import 'package:fluttely/global/style/page_transition.dart';
import 'package:fluttely/app/router/routes.dart';
import 'package:fluttely/pages/projects/project_page.dart';
import 'package:fluttely/pages/components/component_page.dart';
import 'package:fluttely/pages/blog/blog_page.dart';

class InnerRouterDelegate extends RouterDelegate<FluttelyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FluttelyRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  FluttelyAppState get appState => _appState;

  FluttelyAppState _appState;

  set appState(FluttelyAppState value) {
    if (value == _appState) {
      return;
    }
    _appState = value;
    notifyListeners();
  }

  InnerRouterDelegate(this._appState);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        if (appState.selectedIndex == 0)
          PageTransition(
            key: ValueKey(appState.selectedProject),
            child: ProjectPage(
              projects: appState.listProjectsProvider,
              project: appState.selectedProject,
              onTapped: handleProjectTapped,
              appState: appState,
            ),
          ),
        if (appState.selectedIndex == 1)
          PageTransition(
            key: ValueKey(appState.selectedComponent),
            child: ComponentPage(
              components: appState.listComponentsProvider,
              component: appState.selectedComponent,
              onTapped: handleComponentTapped,
              appState: appState,
            ),
          ),
        if (appState.selectedIndex == 2)
          PageTransition(
            key: ValueKey(appState.selectedArticle),
            child: BlogPage(
              articles: appState.listArticlesProvider,
              article: appState.selectedArticle,
              onTapped: handleArticleTapped,
              appState: appState,
            ),
          ),
      ],
      onPopPage: (route, result) => null,
    );
  }

  @override
  Future<void> setNewRoutePath(FluttelyRoutePath path) async {
    assert(false);
  }

  void handleProjectTapped(dynamic project) {
    appState.selectedProject = project;
    notifyListeners();
  }

  void handleComponentTapped(dynamic component) {
    appState.selectedComponent = component;
    notifyListeners();
  }

  void handleArticleTapped(dynamic article) {
    appState.selectedArticle = article;
    notifyListeners();
  }
}
