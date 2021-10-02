import 'dart:math';

import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/dailystatistic.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/piechart.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/Location/location.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/Location/locationhistory.dart';
import 'package:flutter/material.dart';

class stattab extends StatefulWidget {
  dynamic email, name;
  stattab({this.email, this.name});
  // const loctab({ Key? key }) : super(key: key);

  @override
  _stattabState createState() => _stattabState();
}

class _stattabState extends State<stattab> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              isScrollable: true,
              indicatorWeight: 3.0,
              unselectedLabelColor: Colors.indigo,
              labelColor: Colors.blue,
              tabs: [
                Tab(
                  icon: Icon(Icons.lock_clock),
                  text: 'Daily Usage',
                ),
                Tab(
                  icon: Icon(Icons.view_week),
                  text: 'Weekly Usage',
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //Location(email: widget.email),
                  daily(
                    email: widget.email,
                  ),
                  Pie(email: widget.email),

                  // Locationhistory(
                  // email: widget.email,
                  //),
                  //Container(child: Center(child: Text('people'))),
                  //Text('Person')
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
