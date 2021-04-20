import 'package:flutter/material.dart';
import 'package:fluttely/app/router/routes.dart';

class FluttelyRouteInformationParser
    extends RouteInformationParser<FluttelyRoutePath> {
  @override
  Future<FluttelyRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    return FluttelyRoutePath(uri.pathSegments[1]);
  }

  @override
  RouteInformation restoreRouteInformation(FluttelyRoutePath configuration) {
    if (configuration.id.contains('project')) {
      return RouteInformation(location: '/projects/${configuration.id}');
    }
    if (configuration.id.contains('component')) {
      return RouteInformation(location: '/components/${configuration.id}');
    }
    return RouteInformation(location: '/articles/${configuration.id}');
  }
}
