import 'dart:core';
import 'package:fluttely/models/article_model.dart';
import 'package:fluttely/app/data/articles_data.dart';

class ArticlesState {
  final Article article1 = Article.fromMap(articlesJson[0]);
  final Article article2 = Article.fromMap(articlesJson[1]);

  List<Article> get category1 => [article1, article2];

  final Article article3 = Article.fromMap(articlesJson[2]);
  final Article article4 = Article.fromMap(articlesJson[3]);

  List<Article> get category2 => [article3, article4];

  List<Article> get allItems => [article1, article2, article3, article4];
}

class CategoryArticles {
  String title;
  List<Article> items;
  CategoryArticles({this.title, this.items});
}

final categoriesArticles = [
  CategoryArticles(
    title: 'Category 1',
    items: ArticlesState().category1,
  ),
  CategoryArticles(
    title: 'Category 2',
    items: ArticlesState().category2,
  ),
];