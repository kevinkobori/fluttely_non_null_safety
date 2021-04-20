import 'dart:core';
import 'package:fluttely/models/component_model.dart';
import 'package:fluttely/app/data/components_data.dart';

class ComponentsState {
  final Component component1 = Component.fromMap(componentsJson[0]);
  final Component component2 = Component.fromMap(componentsJson[1]);

  List<Component> get category1 => [component1, component2];

  final Component component3 = Component.fromMap(componentsJson[2]);
  final Component component4 = Component.fromMap(componentsJson[3]);

  List<Component> get category2 => [component3, component4];

  List<Component> get allItems => [component1, component2, component3, component4];
}

class CategoryComponents {
  String title;
  List<Component> items;
  CategoryComponents({this.title, this.items});
}

final categoriesComponents = [
  CategoryComponents(
    title: 'Category 1',
    items: ComponentsState().category1,
  ),
  CategoryComponents(
    title: 'Category 2',
    items: ComponentsState().category2,
  ),
];