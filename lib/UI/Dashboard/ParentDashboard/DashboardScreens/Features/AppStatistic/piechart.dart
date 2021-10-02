import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/appstatistic.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/dailystatistic.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/AppStatistic/indicator.dart';
//import 'package:cms/Models/pimodel.dart';
//import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/pichart/widget/indicator.dart';
import 'package:cms/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Pie extends StatefulWidget {
  dynamic email, name;
  Pie({this.email, this.name});
  //const pie({ Key? key }) : super(key: key);

  @override
  _PieState createState() => _PieState();
}

class _PieState extends State<Pie> {
  int touchedIndex;

  List<dynamic> weekly = [];
  //List sortlist = [];
  List myFinalList = [];

  //get async => null;

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

          return myFinalList;
        } catch (e) {
          print(e);
        }
      } catch (e) {
        print(e);
      }
    } catch (e) {}
  }

  List<PieChartSectionData> getSections(int touchedIndex) {
    List<PieChartSectionData> sections = [];
    for (int i = 0; i < 5; i++) {
      final value = PieChartSectionData(
        showTitle: true,

        color: colors[i],
        value: double.parse(myFinalList[i]['percent'].toString().split("%")[0]),
        title:
            '${double.parse(myFinalList[i]['percent'].toString().split("%")[0]).toStringAsFixed(0)}% \n ${myFinalList[i]['hours']}',

        radius: 80,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: const Color(0xffffffff),
        ),
        //print();
      );

      sections.add(value);
    }

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        // title: Text("Graph View"),
        backgroundColor: Colors.indigo,
        leading: Icon(Icons.arrow_back, color: Colors.indigo),

        actions: [
          PopupMenuButton<int>(
            color: Colors.indigo,
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
                      "Weekly Usage List",
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
                      "Daily Usage List",
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
      ),

      // =>
      */
      body: Container(
          child: FutureBuilder(
              future: getUsageStats(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      Expanded(
                        child: PieChart(
                          PieChartData(
                            pieTouchData: PieTouchData(),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0,
                            centerSpaceRadius: 40,
                            sections: getSections(touchedIndex),
                          ),
                          swapAnimationDuration: Duration(milliseconds: 150),
                          swapAnimationCurve: Curves.linear,
                        ),
                      ),

                      Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 4),
                          child: Center(
                              child: IndicatorsWidget(appList: myFinalList))),

                      //SizedBox(width: 30),
                      Row(
                        children: [
                          SizedBox(width: 80),
                          Text(
                            "View Detail Usage",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(width: 30),
                          IconButton(
                              icon: Icon(Icons.arrow_forward_ios_rounded,
                                  color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            week(email: widget.email)));
                                // Navigator.pop(context);
                              }),
                        ],
                      )

                      //Text("hdjjhjd"),
                      //Text("hdjjhjd"),
                      // Text("hdjjhjd"),
                      //Text("hdjjhjd"),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.purple),
                  );
                }
              })),
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
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>

                // Pie(email: widget.email)
                daily(email: widget.email)));
        break;
    }
  }
}
