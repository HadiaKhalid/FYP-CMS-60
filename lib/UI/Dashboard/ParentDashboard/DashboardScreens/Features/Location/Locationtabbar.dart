import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/Location/location.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/Location/locationhistory.dart';
import 'package:flutter/material.dart';

class loctab extends StatefulWidget {
  dynamic email, name;
  loctab({this.email, this.name});
  // const loctab({ Key? key }) : super(key: key);

  @override
  _loctabState createState() => _loctabState();
}

class _loctabState extends State<loctab> with SingleTickerProviderStateMixin {
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
                  icon: Icon(Icons.location_history),
                  text: 'Live Location',
                ),
                Tab(
                  icon: Icon(Icons.history),
                  text: 'Location History',
                ),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Location(email: widget.email),
                  Locationhistory(
                    email: widget.email,
                  ),
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
