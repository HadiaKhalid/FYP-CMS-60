import 'package:cms/Services/Contentmonitoring/calllog.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/piechart.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/statstabbar.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/Location/Locationtabbar.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/Location/location.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/Location/locationhistory.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/MonitorContent/monitordashboard.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/MonitorContent/monitortabbar.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class tabbar extends StatefulWidget {
  dynamic email, name;
  tabbar({this.email, this.name});

  @override
  _tabbarState createState() => _tabbarState();
}

class _tabbarState extends State<tabbar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                }),
            title: Text(
              "${widget.name}",
              style: TextStyle(
                  // fontStyle: FontStyle.italic,
                  //color: Colors.cyanAccent,
                  fontSize: 25.0),
            ),
            centerTitle: true,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                colors: [Colors.purple, Colors.blue],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              )),
            ),
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.white,
              // unselectedLabelColor: Colors.indigo,
              /// labelColor: Colors.pink,
              isScrollable: true,
              indicatorColor: Colors.indigo,
              //indicatorSize:
              indicatorWeight: 5.0,

              //automaticIndicatorColorAdjustment:
              tabs: [
                Tab(
                  icon: Icon(Icons.location_history),
                  text: 'Location',
                ),
                Tab(
                  icon: Icon(Icons.monitor),
                  text: 'Monitor Content',
                ),
                Tab(icon: Icon(Icons.pie_chart), text: 'Usage Stats'),
                Tab(
                  icon: Icon(Icons.maps_home_work),
                  text: 'Geofence',
                )
              ],
            ),
          ),
          //appbar
          //resizeToAvoidBottomInset: false

          //debugShowCheckedModeBanner: false,

          body: TabBarView(
            children: [
              loctab(
                email: widget.email,
                name: widget.name,
              ),
              // Pie(email: widget.email),
              monitorbar(email: widget.email, name: widget.name),
              stattab(
                email: widget.email,
                name: widget.name,
              ),
              // Pie(email: widget.email),

              //monitordash(),

              // Pie(email: widget.email),

              // Locationhistory(email: widget.email),
              Location(email: widget.email, name: widget.name)
              //Pie(email: widget.email),
              //Pie(email: widget.email),

              // calllog(email:widget.email)
            ],
          ),

          /* body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.indigo,
              child: DefaultTabController(
                length: 7,
                child: Scaffold(
                  appBar: AppBar(
                    bottom: TabBar(
                      // indicatorWeight: 20,
                      isScrollable: true,
                      tabs: [
                        //Tab(child: Text('Location')),
                        //Tab(child: Text('Location History')),
                        Tab(icon: Icon(Icons.directions_car)),

                        Tab(
                          child:

                              //Text('Calls Log')

                              Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://googleflutter.com/sample_image.jpg'),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      //'https://googleflutter.com/sample_image.jpg'
                                      //'https://cdn-icons-png.flaticon.com/512/3208/3208977.png'),
                                      'https://www.w3schools.com/python/img_matplotlib_pie1.png'),
                                  fit: BoxFit.fill),
                            ),
                          ),

                          // child: Text('Messages ')
                        ),
                        Tab(
                          child: Column(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          'https://googleflutter.com/sample_image.jpg'),
                                      fit: BoxFit.fill),
                                ),
                              ),
                              //  const SizedBox(height: 20),
                              Text('Contacts')
                            ],
                          ),
                        ),
                        Tab(child: Text('Apps')),
                        Tab(child: Text('Daily Statistics')),
                        Tab(child: Text('Weekly Statistics')),
                        //Tab(child: Text('Geofencing')),
                      ],
                    ),
                    title: Text("Features"),
                    centerTitle: true,
                    toolbarHeight: 100,

                    /* leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  
                                   ParentDashboard()));
                        }),
                        */
                  ),
                  body: TabBarView(
                    children: [
                      //Location(email: widget.email),
                      // Locationhistory(),
                      // CallLogView(),
                      //callloglist(email: widget.email),
                      //SMS(
                      // email: widget.email,

                      // Sms(),
                      //Contact(),
                      // contactlist(email: widget.email),
                      // Installapp(),
                      //applist(email: widget.email),
                      //daily(email: widget.email,)
                      // Stats(),
                      //  bottom(
                      // email: widget.email,
                      //),
                      // daily(
                      //email: widget.email,
                      // ),
                      //TaskHomePage(email: widget.email),
                      // HomePage(),
                      // Pie(
                      //email: widget.email,
                      //),
                      // week(
                      //email: widget.email,
                      //),
                      // Geofence(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      */
        ));
  }
}
