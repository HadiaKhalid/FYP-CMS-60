import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/appstatistic.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/piechart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_usage/app_usage.dart';
import 'package:intl/intl.dart';

class daily extends StatefulWidget {
  dynamic email, name;
  daily({this.email, this.name});

  @override
  _dailyState createState() => _dailyState();
}

class _dailyState extends State<daily> {
  //int currentstate = 0;

  List daily = [];
  List myFinalList = [];

  @override
  void initState() {
    super.initState();
    getUsageStats();
    //currentstate = 0;
  }

  /*String formatDate(DateTime dt) {
    return DateFormat('d-MMM-y H:m:s').format(dt);
  }
  */

  /* final _pageOption = [
   // Childlist(),
   // Notices(),
  ];
  */

  /* void changeScreen(int index) {
    setState(() {
      currentstate = index;
    });
  }
*/

  String formatDate(String dt) {
    List<dynamic> dateTime = dt.split(":");
    String time = dateTime[0] + "h";
    time = time + " ${dateTime[1]}m";
    time += " ${dateTime[2].toString().split(".")[0]}s";

    return time;
  }

  getUsageStats() async {
    try {
      //print("my app list function");()

      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      try {
        var data = await FirebaseFirestore.instance
            .collection("Users")
            .doc(userID)
            .collection('Children')
            .doc(widget.email)
            .get();
        print("print my data");

        daily = data['DailyStats']['daily'];

//Sorting

        daily.sort((a, b) => int.parse(b["Minutes"].split("m")[0])
            .compareTo(int.parse(a["Minutes"].split("m")[0])));
        myFinalList = daily.take(5).toList();
        //  print(daily[0]);

//print(mydata[0]);
//print(my);//

//print("my data $data['App']['app']");
        // myap = Application.fromJson(data['App']['app']);

        // print("my app name "+myap.appName);
        //print(myap.appVersion);
        //print(myap.)
        //for (int i = 0; i <= 10; i++) {
        //print(myap.appName);
        // }

        // print(myap.appName);
        //  print(myap.appVersion);
      } catch (e) {
        print(e);
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
        title: Text('Daily Statistic'),
        /* actions: [
          // Text('Detail View')

          PopupMenuButton<int>(
            color: Colors.blue,
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,

                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      //child: Image.asset("assets/stats.png")
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "Weekly Statistics",
                      style: TextStyle(color: Colors.white, fontFamily: 'bold'),
                    )
                  ],
                ),

                //child: Text("Detail View")
              ),
              PopupMenuDivider(
                height: 10.0,
              ),
              PopupMenuItem<int>(
                value: 1,

                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      // child: Image.asset("assets/graph.png")
                    ),
                    const SizedBox(
                      width: 7,
                    ),
                    Text(
                      "Graph View",
                      style: TextStyle(color: Colors.white, fontFamily: 'bold'),
                    )
                  ],
                ),

                //child: Text("Graph View")
              ),
            ],
            onSelected: (item) => SelectedItem(context, item),
          ),
        ],

        */
      ),

*/
      body: FutureBuilder(
          future: getUsageStats(),
          builder: (context, snapshot) {
            // return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            //children: [
            /* Text(
                  'Top Five Most App Used Statistics',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15.0,
                  ),
                ),

                */

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 15.0),
                Text(
                  '  Most Daily Used App Statistic',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.0,
                  width: 10.0,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: myFinalList.length,
                      //_infos.length,
                      itemBuilder: (context, index) {
                        return Card(
                          // SizedBox(height: ,)
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 30),
                              Text(myFinalList[index]['Package'],
                                  style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 20.0,
                                  )),
                              SizedBox(
                                height: 15,
                                // width: 15,
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    //  height: 15,
                                    width: 10,
                                  ),
                                  Text(
                                    "Time Spent:",
                                    style: TextStyle(
                                        color: Colors.indigo,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    //  height: 15,
                                    width: 27,
                                  ),
                                  Text(
                                    formatDate(myFinalList[index]['appUsage']),
                                    style: TextStyle(
                                        fontSize: 20.0, color: Colors.blue),
                                  ),

                                  //Text(myFinalList[index]['appUsage']),
                                ],
                              ),
                            ],
                          ),
                        );

                        /* return ListTile(
                    leading: Icon(
                      Icons.apps_sharp,
                      color: Colors.blue,
                    ),
                    title: Text(daily[index]['appName']),
                    subtitle: Text(
                      'Time Spent :${daily[index]['appUsage']}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ); 
                  
                */

                        //show all time usage with respect to start and end time
                      }),
                ),
              ],
            );
          }),

      floatingActionButton: FloatingActionButton(
          onPressed: getUsageStats, child: Icon(Icons.refresh)),

      //  floatingActionButton: FloatingActionButton(
      //onPressed: getUsageStats, child: Icon(Icons.refresh)),
    );
  }

  void SelectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => week(email: widget.email)));
        break;
      case 1:
        //print("Privacy Clicked");
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Pie(email: widget.email)));
        break;
    }
  }
}
