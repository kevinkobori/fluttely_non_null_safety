import 'package:flutter/material.dart';
import 'package:fluttely/global/layouts/blog_layout.dart';
import 'package:fluttely/models/article_model.dart';
import 'package:fluttely/app/router/app_state.dart';

class BlogPage extends StatelessWidget {
  BlogPage({this.articles, this.article, this.onTapped, this.appState});

  final List<Article> articles;

  final Article article;

  final Function(Article) onTapped;

  final FluttelyAppState appState;
  
  @override
  Widget build(BuildContext context) {
    return BlogLayout(
      articles: articles,
      article: article,
      onTapped: onTapped,
      appState: appState,
    );
  }
}
