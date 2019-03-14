// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:appfb/const.dart';

class TabsPage extends StatefulWidget {
  TabsPage(this.observer);

  final FirebaseAnalyticsObserver observer;

  static const String routeName = '/tab';

  @override
  State<StatefulWidget> createState() => _TabsPageState(observer);
}

class _TabsPageState extends State<TabsPage>
    with SingleTickerProviderStateMixin, RouteAware {
  _TabsPageState(this.observer);

  final FirebaseAnalyticsObserver observer;
  TabController _controller;
  int selectedIndex = 0;

  final List<Tab> tabs = <Tab>[
    const Tab(text: 'LEFT'),
    const Tab(text: 'RIGHT'),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    observer.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    observer.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      vsync: this,
      length: tabs.length,
      initialIndex: selectedIndex,
    );
    _controller.addListener(() {
      setState(() {
        if (selectedIndex != _controller.index) {
          selectedIndex = _controller.index;
          _sendCurrentTabToAnalytics();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _controller,
          tabs: tabs,
        ),
      ),
      body: TabBarView(
        controller: _controller,
        children: tabs.map((Tab tab) {
          return Center(
              child: StreamBuilder(
            stream: Firestore.instance.collection('chargers').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(themeColor),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) =>
                      _buildItem(context, snapshot.data.documents[index]),
                  itemCount: snapshot.data.documents.length,
                );
              }
            },
          ));
        }).toList(),
      ),
    );
  }

  Widget _buildItem(BuildContext context, DocumentSnapshot document) {
    GeoPoint geoPoint = document['location'];
    return Card(
        child: ListTile(
      leading: Image.network(
        document['image'],
        width: 50,
      ),
      title: Text(document['name']),
      subtitle: Text(
          geoPoint.latitude.toString() + ' - ' + geoPoint.longitude.toString()),
    ));
  }

  @override
  void didPush() {
    _sendCurrentTabToAnalytics();
  }

  @override
  void didPopNext() {
    _sendCurrentTabToAnalytics();
  }

  void _sendCurrentTabToAnalytics() {
    observer.analytics.setCurrentScreen(
      screenName: '${TabsPage.routeName}/tab$selectedIndex',
    );
  }
}
