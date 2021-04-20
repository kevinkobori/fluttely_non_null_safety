import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttely/app/router/app_state.dart';
import 'package:fluttely/app/router/inner_router_delegate.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:fluttely/global/style/sizes.dart';
import 'package:fluttely/providers/articles_provider.dart';
import 'package:fluttely/providers/components_provider.dart';
import 'package:fluttely/providers/projects_provider.dart';

class AppShell extends StatefulWidget {
  final FluttelyAppState appState;

  const AppShell({
    @required this.appState,
  });

  @override
  _AppShellState createState() => _AppShellState();
}

class _AppShellState extends State<AppShell>
    with SingleTickerProviderStateMixin {
  InnerRouterDelegate _routerDelegate;
  ChildBackButtonDispatcher _backButtonDispatcher;

  var _scaffoldKey = GlobalKey<ScaffoldState>();

  var valueDrawer;
  dynamic objects;

  TabController _tabController;

  void initState() {
    widget.appState.addListener(() {
      _tabController.animateTo(widget.appState.selectedIndex);
    });
    super.initState();
    _routerDelegate = InnerRouterDelegate(widget.appState);
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AppShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    _routerDelegate.appState = widget.appState;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _backButtonDispatcher = Router.of(context)
        .backButtonDispatcher
        .createChildBackButtonDispatcher();
  }

  FluttelyAppState getAppState() {
    var appState = widget.appState;
    return appState;
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> fluttelyTabs = <Tab>[
      Tab(
        child: Text(
          'Projects',
          style: widget.appState.selectedIndex == 0
              ? TextStyle(color: Colors.cyanAccent)
              : null,
        ),
      ),
      Tab(
        child: Text(
          'Components',
          style: widget.appState.selectedIndex == 1
              ? TextStyle(color: Colors.cyanAccent)
              : null,
        ),
      ),
      Tab(
        child: Text(
          'Blog',
          style: widget.appState.selectedIndex == 2
              ? TextStyle(color: Colors.cyanAccent)
              : null,
        ),
      )
    ];

    _backButtonDispatcher.takePriority();

    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: Container(
          width: 200,
          child: widget.appState.selectedIndex == 0
              ? Column(
                  children: [
                    SizedBox(height: 16),
                    ListTile(
                      contentPadding:
                          const EdgeInsets.fromLTRB(10.0, 0, 6.0, 0),
                      title: Text(
                        'Projects',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: ListView.builder(
                        itemCount: categoriesProjects.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ExpansionTile(
                            initiallyExpanded: (categoriesProjects[index]
                                    .items
                                    .singleWhere((it) => it.id == valueDrawer,
                                        orElse: () => null)) !=
                                null,
                            tilePadding:
                                const EdgeInsets.fromLTRB(10.0, 0, 6.0, 0),
                            backgroundColor: Colors.transparent,
                            childrenPadding:
                                EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                            title: Text(
                              categoriesProjects[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            children: <Widget>[
                              Column(
                                children: categoriesProjects[index]
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
                                        fontWeight: valueDrawer == element.id
                                            ? FontWeight.w500
                                            : FontWeight.w100,
                                      ),
                                    ),
                                    selected: valueDrawer == element.id,
                                    onTap: () {
                                      InnerRouterDelegate(widget.appState)
                                          .handleProjectTapped(element);
                                      setState(() {
                                        valueDrawer = element.id;
                                      });
                                      _scaffoldKey.currentState.openEndDrawer();
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
                )
              : widget.appState.selectedIndex == 1
                  ? Column(
                      children: [
                        SizedBox(height: 16),
                        ListTile(
                          contentPadding:
                              const EdgeInsets.fromLTRB(10.0, 0, 6.0, 0),
                          title: Text(
                            'Components',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Expanded(
                          child: ListView.builder(
                            itemCount: categoriesComponents.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ExpansionTile(
                                initiallyExpanded: (categoriesComponents[index]
                                        .items
                                        .singleWhere(
                                            (it) => it.id == valueDrawer,
                                            orElse: () => null)) !=
                                    null,
                                tilePadding:
                                    const EdgeInsets.fromLTRB(10.0, 0, 6.0, 0),
                                backgroundColor: Colors.transparent,
                                childrenPadding:
                                    EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                                title: Text(
                                  categoriesComponents[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                children: <Widget>[
                                  Column(
                                    children: categoriesComponents[index]
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
                                          InnerRouterDelegate(widget.appState)
                                              .handleComponentTapped(element);
                                          setState(() {
                                            valueDrawer = element.id;
                                          });
                                          _scaffoldKey.currentState
                                              .openEndDrawer();
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
                    )
                  : Column(
                      children: [
                        SizedBox(height: 16),
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
                        SizedBox(height: 16),
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
                                tilePadding:
                                    const EdgeInsets.fromLTRB(10.0, 0, 6.0, 0),
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
                                          InnerRouterDelegate(widget.appState)
                                              .handleArticleTapped(element);
                                          setState(() {
                                            valueDrawer = element.id;
                                          });
                                          _scaffoldKey.currentState
                                              .openEndDrawer();
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
      appBar: new AppBar(
        elevation: 0,
        titleSpacing: 0.0,
        toolbarHeight: appBarHeight,
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ResponsiveVisibility(
                visible: false,
                visibleWhen: [
                  Condition.smallerThan(name: DESKTOP),
                ],
                child: TextButton(
                  child: Icon(
                    Icons.menu,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
            ),
            ResponsiveVisibility(
              visible: false,
              visibleWhen: [
                Condition.equals(name: DESKTOP),
              ],
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6.0, 3.0, 6.0, 9.0),
                child: Image.asset(
                  'assets/logos/remottely_light_center.png',
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        title: PreferredSize(
          preferredSize: Size(double.infinity, appBarHeight),
          child: Row(
            children: [
              Text('Fluttely'),
              Spacer(),
              TabBar(
                labelPadding: const EdgeInsets.fromLTRB(6.0, 0.0, 6.0, 0.0),
                controller: _tabController,
                isScrollable: true,
                indicatorWeight: 4,
                indicatorSize: TabBarIndicatorSize.label,
                onTap: (index) {
                  widget.appState.selectedIndex = index;
                },
                tabs: fluttelyTabs,
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Router(
            routerDelegate: _routerDelegate,
            backButtonDispatcher: _backButtonDispatcher,
          ),
        ),
      ),
    );
  }
}
