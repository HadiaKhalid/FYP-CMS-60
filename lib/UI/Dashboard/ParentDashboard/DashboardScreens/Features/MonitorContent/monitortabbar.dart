import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/MonitorContent/applist.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/MonitorContent/call_log_view.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/MonitorContent/contact.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/MonitorContent/sms.dart';
import 'package:flutter/material.dart';

class monitorbar extends StatefulWidget {
  dynamic email, name;
  monitorbar({this.email, this.name});
  //const monitorbar({ Key? key }) : super(key: key);

  @override
  _monitorbarState createState() => _monitorbarState();
}

class _monitorbarState extends State<monitorbar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 4, vsync: this);
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
                  icon: Icon(Icons.call),
                  text: 'Call History',
                ),
                Tab(
                  icon: Icon(Icons.sms),
                  text: 'Sms History',
                ),
                Tab(
                  icon: Icon(Icons.person),
                  text: 'Contact List',
                ),
                Tab(icon: Icon(Icons.app_registration), text: 'Install App'),
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  callloglist(email: widget.email),
                  SMS(email: widget.email),
                  contactlist(email: widget.email),

                  applist(email: widget.email)
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

  
   
   
   /* return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          // title: Text("Monitor Content"),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            )),
          ),
          bottom: TabBar(
            isScrollable: true,

            //automaticIndicatorColorAdjustment:
            tabs: [
              Tab(
                icon: Icon(Icons.call),
                text: 'Call History',
              ),
              Tab(
                icon: Icon(Icons.sms),
                text: 'Sms History',
              ),
              Tab(icon: Icon(Icons.app_registration), text: 'Install App'),
              Tab(
                icon: Icon(Icons.person),
                text: 'Contact List',
              )
            ],
          ),
        ),
        //appbar
        //resizeToAvoidBottomInset: false

        //debugShowCheckedModeBanner: false,

        body: TabBarView(
          children: [
            callloglist(email: widget.email),
            SMS(
              email: widget.email,
            ),
            applist(email: widget.email),
            contactlist(email: widget.email)

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
      ),
    );

  }
}
*/
