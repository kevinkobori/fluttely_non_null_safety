import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fluttely/app/router/app_state.dart';
import 'package:fluttely/global/style/text_style.dart';
import 'package:fluttely/models/article_model.dart';
import 'package:fluttely/providers/articles_provider.dart';
import 'package:fluttely/global/widgets/layout_footer.dart';

class BlogLayout extends StatefulWidget {
  BlogLayout({this.articles, this.article, this.onTapped, this.appState});
  final List<Article> articles;
  final Article article;
  final Function(Article) onTapped;

  final FluttelyAppState appState;
  _BlogLayoutState createState() => _BlogLayoutState();
}

class _BlogLayoutState extends State<BlogLayout> with TickerProviderStateMixin {
  String showPercent = "Progresso: 0%";
  AutoScrollController _autoScrollController;
  final scrollDirection = Axis.vertical;
  var valueListTitle;
  var valueDrawer;

  @override
  void initState() {
    _autoScrollController = AutoScrollController(
      viewportBoundaryGetter: () =>
          Rect.fromLTRB(0, 0, 0, MediaQuery.of(context).padding.bottom),
      axis: scrollDirection,
    );
    valueDrawer = widget.article.id;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _autoScrollController.dispose();
  }

  Future _scrollToIndex(int index) async {
    await _autoScrollController.scrollToIndex(index,
        preferPosition: AutoScrollPosition.begin);
    _autoScrollController.highlight(index);
  }

  Widget _wrapScrollTag({int index, Widget child}) {
    return AutoScrollTag(
      key: ValueKey(index),
      controller: _autoScrollController,
      index: index,
      child: child,
      highlightColor: Colors.white.withOpacity(0.1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1100),
              child: Row(
                children: [
                  ResponsiveVisibility(
                    visible: false,
                    visibleWhen: [
                      Condition.equals(name: DESKTOP),
                    ],
                    child: Container(
                      width: 200,
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding:
                                const EdgeInsets.fromLTRB(10.0, 0, 6.0, 0),
                            title: Text(
                              'Blog',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: categoriesArticles.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ExpansionTile(
                                  initiallyExpanded: (categoriesArticles[index]
                                          .items
                                          .singleWhere(
                                              (it) => it.id == valueDrawer,
                                              orElse: () => null)) !=
                                      null,
                                  // trailing: Container(
                                  //   width: 0,
                                  // ),
                                  tilePadding: const EdgeInsets.fromLTRB(
                                      10.0, 0, 6.0, 0),
                                  backgroundColor: Colors.transparent,
                                  childrenPadding:
                                      EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                  title: Text(
                                    categoriesArticles[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  children: <Widget>[
                                    Column(
                                      children: categoriesArticles[index]
                                          .items
                                          .map((element) {
                                        return ListTile(
                                          dense: true,
                                          title: Text(
                                            element.title.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight:
                                                  valueDrawer == element.id
                                                      ? FontWeight.w500
                                                      : FontWeight.w100,
                                            ),
                                          ),
                                          selected: valueDrawer == element.id,
                                          onTap: () {
                                            var getIndexElementList =
                                                widget.articles.indexWhere((e) {
                                              return e.id == element.id;
                                            });
                                            widget.onTapped(widget
                                                .articles[getIndexElementList]);
                                            setState(() {
                                              valueDrawer = element.id;
                                            });
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: NotificationListener(
                      onNotification: (ScrollNotification scrollInfo) {
                        var info = ((scrollInfo.metrics.pixels /
                                    scrollInfo.metrics.maxScrollExtent) *
                                100)
                            .toStringAsFixed(0);
                        setState(() {
                          if (info == "100")
                            showPercent = "Leitura finalizada!";
                          else
                            showPercent = "Progresso: $info%";
                        });
                        return;
                      },
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        controller: _autoScrollController,
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.article.title,
                                    style: articleTitleTextStyle,
                                  ),
                                  SizedBox(height: 16),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(32),
                                        child: Image.asset(
                                          widget.article.authorImage,
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      RichText(
                                        text: TextSpan(
                                          text: 'por ',
                                          style: topicValueTextStyle,
                                          children: [
                                            TextSpan(
                                              text: widget.article.author,
                                              style: articleSubtitleTextStyle,
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 32),
                                  Image.asset(
                                    widget.article.image,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(height: 32),
                                  Text(
                                    widget.article.subtitle,
                                    style: topicValueTextStyle,
                                  ),
                                  SizedBox(height: 32),
                                ],
                              ),
                            ),
                          ),
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return _wrapScrollTag(
                                  index: index,
                                  child: Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.article.first[index].title,
                                          style: topicTitleTextStyle,
                                        ),
                                        SizedBox(height: 16),
                                        // widget.article.topics[index].type == 'text'
                                        //     ?
                                        Column(
                                          children: widget
                                              .article.first[index].second
                                              .map<Widget>((if1) {
                                            return if1.type == 'text'
                                                ? Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 32.0),
                                                    child: RichText(
                                                      text: TextSpan(
                                                        style:
                                                            topicValueTextStyle,
                                                        children: if1.third
                                                            .map<TextSpan>(
                                                                (if2) {
                                                          return if2.type ==
                                                                  'normal'
                                                              ? TextSpan(
                                                                  text: if2
                                                                      .fourth,
                                                                )
                                                              : if2.type ==
                                                                      'bold'
                                                                  ? TextSpan(
                                                                      text: if2
                                                                          .fourth,
                                                                      style:
                                                                          topicTextStyleBold,
                                                                    )
                                                                  : if2.type ==
                                                                          'underline'
                                                                      ? TextSpan(
                                                                          text:
                                                                              if2.fourth,
                                                                          style:
                                                                              topicTextStyleUnderline,
                                                                        )
                                                                      : TextSpan(
                                                                          text:
                                                                              if2.fourth,
                                                                          style:
                                                                              topicTextStyleLink,
                                                                          recognizer: TapGestureRecognizer()
                                                                            ..onTap = () async {
                                                                              await canLaunch(if2.type) ? await launch(if2.type) : throw 'Could not launch ${if2.type}';
                                                                            },
                                                                        );
                                                        }).toList(),
                                                      ),
                                                    ),
                                                  )
                                                : Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 32.0),
                                                    child: Image.asset(
                                                      if1.third[0].fourth,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              childCount: widget.article.first.length,
                            ),
                          ),
                          SliverToBoxAdapter(
                            child: Divider(),
                          ),
                          SliverToBoxAdapter(
                            child: LayoutFooter(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ResponsiveVisibility(
                    visible: false,
                    visibleWhen: [
                      Condition.largerThan(name: MOBILE),
                    ],
                    child: Center(
                      child: Container(
                        height: (widget.article.first.length * 52.0) + 52.0,
                        width: 200,
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: widget.article.first.length,
                          itemBuilder: (BuildContext context, int index) {
                            return index == 0
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                        Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Text(
                                            '$showPercent',
                                            style: percentTextStyle,
                                          ),
                                        ),
                                        ListTile(
                                          dense: true,
                                          title: Text(
                                            widget.article.first[index].title
                                                .toString(),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: indicatorsTextStyle,
                                          ),
                                          selected: valueListTitle == index,
                                          onTap: () {
                                            _scrollToIndex(index);
                                            setState(() {
                                              valueListTitle = index;
                                            });
                                          },
                                        )
                                      ])
                                : ListTile(
                                    dense: true,
                                    title: Text(
                                      widget.article.first[index].title
                                          .toString(),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: indicatorsTextStyle,
                                    ),
                                    selected: valueListTitle == index,
                                    onTap: () {
                                      _scrollToIndex(index);
                                      setState(() {
                                        valueListTitle = index;
                                      });
                                    },
                                  );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
