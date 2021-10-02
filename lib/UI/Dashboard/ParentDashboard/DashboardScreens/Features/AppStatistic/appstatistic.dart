import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:app_usage/app_usage.dart';
//import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class week extends StatefulWidget {
  dynamic email, name;
  week({this.email, this.name});
  @override
  _weekState createState() => _weekState();
}

class _weekState extends State<week> {
  //int currentstate = 0;

  List<dynamic> weekly = [];
  //List sortlist = [];
  static List myFinalList = [];

  @override
  void initState() {
    super.initState();
    //getUsageStats();
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
    String time = dateTime[0] + "hr";
    time = time + " ${dateTime[1]}min";
    time += " ${dateTime[2].toString().split(".")[0]}sec";

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
        print(data);
        try {
          weekly = data['WeeklyStats']['weekly'];
          // sortlist = weekly.take(5).toList();
          // print(weekly);

          weekly.sort((a, b) => int.parse(b["Minutes"].split("m")[0])
              .compareTo(int.parse(a["Minutes"].split("m")[0])));
          myFinalList = weekly.take(5).toList();
          // print(myFinalList[0]['percent']);
          //for (var i = 0; i <= 6; i++) {
          //  myFinalList[i] = newlist;
          //}
        } catch (e) {
          print(e);
        }
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
      appBar: AppBar(
        title: Text('Detail Weekly Statistic'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            }),

        /* actions: [
          InkWell(
            child: Text('Graph View'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => pie(email: widget.email)));
            },
          )
        ],
        */
      ),
      body: FutureBuilder(
        future: getUsageStats(),
        builder: (context, snapshot) {
          return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(height: 15.0),
            Text(
              ' Most Weekly Used App Statistic',
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
                    itemCount:
                        //sortlist.length,
                        // weekly.length,
                        //  myfinallist.
                        myFinalList.length,
                    //weekly.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Column(
                          children: [
                            Text(myFinalList[index]['package'],
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
                                  "Hour Spent:",
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                // SizedBox(
                                // height: 30,
                                //),
                                SizedBox(
                                  //  height: 15,
                                  width: 72,
                                ),
                                Text(
                                  myFinalList[index]['hours'],
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.blue),
                                ),

                                //SizedBox(height: 15,),
                              ],
                            ),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  //  height: 15,
                                  width: 10,
                                ),
                                Text(
                                  "Minutes Spent:",
                                  style: TextStyle(
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                // SizedBox(
                                // height: 15,
                                //),

                                SizedBox(
                                  //  height: 15,
                                  width: 51,
                                ),
                                Text(
                                  myFinalList[index]['Minutes'],
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.blue),
                                ),
                              ],
                            ),
                            Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  //  height: 15,
                                  width: 10,
                                ),
                                Text(
                                  'Seconds Spent:',
                                  style: TextStyle(
                                      //color: Colors.blue,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  //  height: 15,
                                  width: 50,
                                ),
                                Text(
                                  myFinalList[index]['second'],
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.blue),
                                ),
                              ],
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  //  height: 15,
                                  width: 10,
                                ),
                                Text(
                                  "Total Time Duration",
                                  style: TextStyle(
                                      // color: Colors.blue,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold),
                                ),
                                // SizedBox(
                                //  height: 15,
                                // ),
                                SizedBox(
                                  //  height: 15,
                                  width: 27,
                                ),
                                Text(
                                  formatDate(myFinalList[index]['Totalusage']),
                                  style: TextStyle(
                                      fontSize: 20.0, color: Colors.blue),
                                ),

                                //Text(myFinalList[index]['Totalusage']),
                              ],
                            ),
                            Row(
                              //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  //  height: 15,
                                  width: 10,
                                ),
                                /*Text(
                                  "Usage Percent",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                                // SizedBox(
                                //  height: 15,
                                // ),

                                SizedBox(
                                  //  height: 15,
                                  width: 59,
                                ),
                                Text(myFinalList[index]['percent']),
                              ],
                            ),
                            */
                                SizedBox(
                                  height: 15,
                                ),
                              ],

                              /* return ListTile(
                      leading: Icon(
                        Icons.apps_outlined,
                        color: Colors.blue,
                      ),
                      title: Text(weekly[index]['appName']),
                      subtitle: Text(
                        ' Time Spent :${weekly[index]['appUsage']}',
                        style: TextStyle(color: Colors.blue),
                      ),
                     

                  //show all time usage with respect to start and end time
                });
                */

                              //floatingActionButton: FloatingActionButton(
                            ),
                          ],
                        ), //  onPressed: getUsageStats, child: Icon(Icons.refresh)),
                      );
                    })),
          ]);
        },
        // )};
      ),
    );
  }
}
