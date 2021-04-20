import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter/services.dart';
import 'package:fluttely/app/router/route_information_parser.dart';
import 'package:fluttely/app/router/router_delegate.dart';
import 'package:fluttely/global/style/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FluttelyRouterDelegate _routerDelegate = FluttelyRouterDelegate();
    FluttelyRouteInformationParser _routeInformationParser =
        FluttelyRouteInformationParser();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: color1,
      statusBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Fluttely',
      theme: theme(),
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget),
        defaultScale: true,
        minWidth: 450,
        defaultName: MOBILE,
        breakpoints: [
          ResponsiveBreakpoint.resize(450, name: MOBILE),
          ResponsiveBreakpoint.resize(740, name: TABLET),
          ResponsiveBreakpoint.resize(960, name: DESKTOP),
        ],
      ),
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
    );
  }
}
