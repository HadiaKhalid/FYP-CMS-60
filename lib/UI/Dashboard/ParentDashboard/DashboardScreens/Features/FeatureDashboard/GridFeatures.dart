/*//import 'package:cms/Services/Contentmonitoring/sms.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/PieChart/piechart.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/applist.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/dailystatistic.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/geofencing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/appstatistic.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/call_log_view.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/contact.dart';
//import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/installedapp.dart';
//import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/geofencing.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/location.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/locationhistory.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/sms.dart';

import 'package:google_fonts/google_fonts.dart';

class GridFeatures extends StatefulWidget {
  dynamic email;
  GridFeatures({this.email});

  @override
  _GridFeaturesState createState() => _GridFeaturesState();
}

class _GridFeaturesState extends State<GridFeatures> {
  Items item1 = new Items(
    title: "Location",
    subtitle: "",
    color: Colors.red[900],
    img: "assets/map.png",
  );

  Items item2 = new Items(
    title: "Location History",
    subtitle: "",
    color: Colors.red[900],
    img: "assets/microphone (1).png",
  );
  Items item3 = new Items(
    title: "Text Messages",
    subtitle: "",
    color: Colors.blue,
    img: "assets/msg.png",

    // img: "assets/msg.jpg",
  );
  Items item4 = new Items(
    title: "Call Logs",
    subtitle: "",
    // color: Colors.blueGrey,
    // img: "assets/call.jpeg",
    img: "assets/call.png",
  );
  Items item5 = new Items(
    title: "Contacts",
    subtitle: "",
    color: Colors.blueGrey,
    //img: "assets/contact.png",
    img: 'assets/cc.png',
  );
  Items item6 = new Items(
    title: "Installed Apps",
    subtitle: "",
    color: Colors.blueGrey,
    // img: "assets/installapp.png",
    img: "assets/installapp.png",
  );
  Items item7 = new Items(
    title: "App Usage Stats",
    subtitle: "",
    // color: Colors.blueGrey,
    // img: "assets/appstats.jpg",
    img: 'assets/statss.png',
  );
  Items item8 = new Items(
    title: "Geofencing",
    subtitle: "",
    color: Colors.blue,
    // img: "assets/geofence.png",
    //img: "assets/geofence.png",
    img: 'assets/geofence.png',
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8
    ];
    var color = Colors.blue;
    //0xff453658;//
    return GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16, top: 30),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return InkWell(
            onTap: () {
              String title = data.title;
              switch (title) {
                case "Location":
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Location(email: widget.email)));
                  }
                  break;
                case "Location History":
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Locationhistory(email: widget.email)));
                  }

                  break;
                case "Call Logs":
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                callloglist(email: widget.email)));
                  }
                  break;
                case "Text Messages":
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SMS(email: widget.email)));
                  }
                  break;
                case "Installed Apps":
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                applist(email: widget.email)));
                  }
                  break;
                case "Contacts":
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                contactlist(email: widget.email)));
                  }
                  break;
                case "App Usage Stats":
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                //week(email: widget.email)));
                                daily(email: widget.email)));
                  }
                  break;
                case "Geofencing":
                  {
                    //just  for test puprose
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Pie(email: widget.email)));
                    // Geofence()));
                  }
                  break;
              }
            },
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 65,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList());
  }
}

class Items {
  String title;
  String subtitle;
  String img;
  Color color;
  Items({this.title, this.subtitle, this.color, this.img});
}
*/