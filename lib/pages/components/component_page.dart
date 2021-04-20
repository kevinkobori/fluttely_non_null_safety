import 'package:flutter/material.dart';
import 'package:fluttely/global/layouts/components_layout.dart';
import 'package:fluttely/models/component_model.dart';
import 'package:fluttely/app/router/app_state.dart';

class ComponentPage extends StatelessWidget {
  ComponentPage({this.components, this.component, this.onTapped, this.appState});

  final List<Component> components;

  final Component component;

  final Function(Component) onTapped;

  final FluttelyAppState appState;
  
  @override
  Widget build(BuildContext context) {
    return ComponentsLayout(
      components: components,
      component: component,
      onTapped: onTapped,
      appState: appState,
    );
  }
}
