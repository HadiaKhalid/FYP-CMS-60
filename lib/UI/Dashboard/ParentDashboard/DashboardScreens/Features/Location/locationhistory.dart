/*
import 'package:flutter/material.dart';
class Locationhistory extends StatefulWidget {
  @override
  _LocationhistoryState createState() => _LocationhistoryState();

}

class _LocationhistoryState extends State<Locationhistory> {
 @override
      Widget build(BuildContext context){
            return Scaffold(
            );
}
}
*/
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/FeatureDashboard/features.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calendar_strip/calendar_strip.dart';

class Locationhistory extends StatefulWidget {
  dynamic email, name;
  Locationhistory({this.email, this.name});
  @override
  _LocationhistoryState createState() => _LocationhistoryState();
}

class _LocationhistoryState extends State<Locationhistory> {
  DateTime startDate = DateTime.now().subtract(Duration(days: 7));
  DateTime endDate = DateTime.now();
  DateTime selectedDate = DateTime.now();
  List<DateTime> markedDates = [];
//to show the selected date

  bool nodata = false;
  dynamic myselecteddate;
  onSelect(data) async {
    print("Selected Date ->$dates ${data.toString().split(" ")[0]}");
    setState(() {
      myselecteddate = "${data.toString().split(" ")[0]}";
    });
    if (dates.contains(myselecteddate)) {
      setState(() {
        nodata = false;
      });
      print("yes history $dates");
      getlocbydate();
    } else {
      print("yes history no $dates");
      setState(() {
        nodata = true;
        // locations = [];
      });
    }
  }

  onWeekSelect(data) {
    print("Selected week starting at -> $data");
  }

  _monthNameWidget(monthName) {
    return Container(
      child: Text(monthName,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              fontStyle: FontStyle.italic)),
      padding: EdgeInsets.only(top: 18, bottom: 14),
    );
  }

  getMarkedIndicatorWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Container(
        margin: EdgeInsets.only(left: 1, right: 1),
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
      Container(
        width: 7,
        height: 7,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
      )
    ]);
  }

  dateTileBuilder(
      date, selectedDate, rowIndex, dayName, isDateMarked, isDateOutOfRange) {
    bool isSelectedDate = date.compareTo(selectedDate) == 0;
    Color fontColor = isDateOutOfRange ? Colors.black26 : Colors.black87;
    TextStyle normalStyle =
        TextStyle(fontSize: 15, fontWeight: FontWeight.w800, color: fontColor);
    TextStyle selectedStyle = TextStyle(
        fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87);
    TextStyle dayNameStyle = TextStyle(fontSize: 12, color: fontColor);
    List<Widget> _children = [
      Text(dayName, style: dayNameStyle),
      Text(date.day.toString(),
          style: !isSelectedDate ? normalStyle : selectedStyle),
    ];

    if (isDateMarked == true) {
      _children.add(getMarkedIndicatorWidget());
    }

    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      alignment: Alignment.center,
      padding: EdgeInsets.only(top: 8, left: 5, right: 5, bottom: 5),
      decoration: BoxDecoration(
        color: !isSelectedDate ? Colors.transparent : Colors.transparent,
        borderRadius: BorderRadius.all(Radius.circular(80)),
      ),
      child: Column(
        children: _children,
      ),
    );
  }

  List locations = [];
  List filteredlist = [];
  String action;
  List dates = [];
  getlocbydate() {
    print("my selecteddate is $myselecteddate");
    //print("yes ${locations[0][0]['date']}");
    filteredlist = [];
    //  dates = [];

    for (int i = 0; i <= locations[0].length; i++) {
      if (locations[0][i]['date'] == myselecteddate) {
        filteredlist.add(locations[0][i]);
        // dates.add(locations[0][i]['date']);
        print("my is $filteredlist");
      } else {
        print("im here");

        print("no match");
      }
      //locations = [];
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      myselecteddate = DateTime.now().toString().split(" ")[0];
      print("my selected is $myselecteddate");
    });
    //  getlocbydate();
  }

  var firsttime = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.email);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      /* appBar: AppBar(
        backgroundColor: Colors.blue,
        //Color(0xff453658),//
        automaticallyImplyLeading: false,
        title: Text("Location History"),
        centerTitle: true,

                    leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => features(email:widget.email)));
                        }),
      ),

      */
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
              height: MediaQuery.of(context).size.height * 0.20,
              child: CalendarStrip(
                selectedDate: DateTime.now(),
                startDate: startDate,
                endDate: endDate,
                onDateSelected: onSelect,
                onWeekSelected: onWeekSelect,
                dateTileBuilder: dateTileBuilder,
                iconColor: Colors.black87,
                monthNameWidget: _monthNameWidget,
                markedDates: markedDates,
                containerDecoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Colors.blueGrey,
                        Colors.indigo,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(3.0, 3.0),
                        blurRadius: 4.0,
                        spreadRadius: 1.0,
                      ),
                    ]),
              )),
          SizedBox(height: size.height * 0.02),
          Divider(
              /* color: Colors.grey[400],
                                      thickness: 2,
                                      endIndent: 5,
                                      indent: 5,
                  */
              ),
          FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("History")
                .doc(widget.email)
                .get(),
            builder: (context, snapshot) {
              print(snapshot);

              // print(snapshot.data['address'].length);
              if (snapshot.hasData && snapshot.data.exists) {
                //  locations = [];

                locations.add(snapshot.data['address']);

                print(locations);
                print(filteredlist);
                return nodata
                    ? Center(
                        child: Text('No History'),
                      )
                    : ListView.builder(
                        physics: ScrollPhysics(),
                        itemCount: filteredlist.isEmpty
                            ? locations[0].length
                            : filteredlist.length,
                        itemBuilder: (context, i) {
                          if (firsttime == 0) {
                            for (int i = 0; i < locations[0].length; i++) {
                              dates.add(locations[0][i]['date']);
                            }
                            if (dates.contains(myselecteddate)) {
                            } else {
                              nodata = true;

                              print("the location is $nodata");
                            }
                            firsttime++;
                          }

                          return nodata
                              ? Center(child: Text(''))
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 14),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.blueGrey,
                                      child: Icon(Icons.location_pin, size: 30),
                                    ),
                                    title: Text(
                                        "${filteredlist.isEmpty ? locations[0][i]['date'] : filteredlist[i]['date']}",
                                        style: TextStyle(fontSize: 20)),
                                    subtitle: Text(
                                        "${filteredlist.isEmpty ? locations[0][i]['address'] : filteredlist[i]['address']}",
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                );
                        },
                        shrinkWrap: true,
                      );
              } else {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Text("No history yet!");
                }
              }
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
