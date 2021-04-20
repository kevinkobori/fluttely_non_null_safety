import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttely/app/router/app_state.dart';
import 'package:fluttely/app/app_shell.dart';
import 'package:fluttely/app/router/routes.dart';

class FluttelyRouterDelegate extends RouterDelegate<FluttelyRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FluttelyRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  FluttelyAppState appState = FluttelyAppState();

  FluttelyRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    appState.addListener(notifyListeners);
  }
//tested
  FluttelyRoutePath get currentConfiguration {
    if (appState.selectedIndex == 0)
      return FluttelyRoutePath(appState.getSelectedProjectById());
    else if (appState.selectedIndex == 1)
      return FluttelyRoutePath(appState.getSelectedComponentById());
    else
      return FluttelyRoutePath(appState.getSelectedArticleById());
  }

  Widget build(BuildContext context) => Scaffold(
        body: Navigator(
          key: navigatorKey,
          pages: [
            MaterialPage(
              child: AppShell(appState: appState),
            ),
          ],
          onPopPage: (route, result) => null,
        ),
      );

  @override
  Future<void> setNewRoutePath(FluttelyRoutePath path) async {
    if (path.id.contains('project')) {
      appState.selectedIndex = 0;
      appState.setSelectedProjectById(path.id);
    }
    if (path.id.contains('component')) {
      appState.selectedIndex = 1;
      appState.setSelectedComponentById(path.id);
    }
    if (path.id.contains('article')) {
      appState.selectedIndex = 2;
      appState.setSelectedArticleById(path.id);
    }
  }
}
