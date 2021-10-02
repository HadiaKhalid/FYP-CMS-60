import 'dart:async';
import 'dart:typed_data';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/Services/Contentmonitoring/calllog.dart';
import 'package:cms/Services/Contentmonitoring/contactservice.dart';
import 'package:cms/Services/Contentmonitoring/installapp.dart';
import 'package:cms/Services/Contentmonitoring/sms.dart';
import 'package:cms/Services/appstatistic.dart';
import 'package:cms/UI/Dashboard/ChildDashboard/GridDashboard.dart';
import 'package:cms/UI/Dashboard/ChildDashboard/Settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:permission_handler/permission_handler.dart' as ph;

class ChildDashBoard extends StatefulWidget {
  dynamic email, name;
  ChildDashBoard({this.email, this.name});
  @override
  _ChildDashBoardState createState() => _ChildDashBoardState();
}

class _ChildDashBoardState extends State<ChildDashBoard> {
  //make instance of contact class
  appstatistics a = new appstatistics();
  contacts c1 = new contacts();
  //make instance of installedap class
  installapp a1 = new installapp();
  //make instance of sms  class
  sms s = new sms();
  calllog c = new calllog();
  //usage u = new usage();
  //uasage u = new uasage();
  //appstatistics ap = new appstatistics();
  dynamic data;
  dynamic userID;
  allowbackgroundlocationaccess() async {
    try {
      // You can request multiple permissions at once.
      Map<ph.Permission, ph.PermissionStatus> statuses =
          await [ph.Permission.location].request();
      print(statuses[ph.Permission.location]);
      bg.BackgroundGeolocation.onLocation((bg.Location location) {
        print('[location] - $location');
        print(location.coords.latitude);
        if (location.coords.latitude != null) {
          getCurrentLocation(
              location.coords.latitude, location.coords.longitude);
          // sendlocationtoserverforbackground(
          //     location.coords.latitude, location.coords.longitude);
        }
      });

      // Fired whenever the state of location-services changes.  Always fired at boot
      bg.BackgroundGeolocation.onProviderChange((bg.ProviderChangeEvent event) {
        print('[providerchange] - $event');
      });

      ////
      // 2.  Configure the plugin
      //
      bg.BackgroundGeolocation.ready(bg.Config(
              desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
              distanceFilter: 20,
              //stopOnTerminate: true,
              //startOnBoot: true,
              debug: true,
              logLevel: bg.Config.LOG_LEVEL_VERBOSE))
          .then((bg.State state) {
        if (!state.enabled) {
          ////
          // 3.  Start the plugin.
          //
          bg.BackgroundGeolocation.start();
        }
      });
    } catch (e) {
      print(e);
    }
  }

  List loc = [];
  void getCurrentLocation(latitude, longitude) async {
    try {
      // var location = await _locationTracker.getLocation();
      print(latitude);
      print(longitude);
      userID = FirebaseAuth.instance.currentUser.uid;
      dynamic useremail = FirebaseAuth.instance.currentUser.email;

      print(userID);
      data = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .get();
      print(data['parentID']);

      FirebaseFirestore.instance
          .collection("Users")
          .doc(data['parentID'])
          .collection('Children')
          .doc(useremail)
          .update({
        "location": {"lat": latitude, "lng": longitude}
      });
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      print(placemarks[0].name);
      var address;

      address = "${placemarks[0].name} ${placemarks[0].subLocality} ";

      print("the location is $loc");
      if (loc.contains(address)) {
        //  loc = [];
        print("im hre");
      } else {
        loc.add(address);
        final snapshot =
            await FirebaseFirestore.instance.collection('History').get();
        if (snapshot.docs.length == 0) {
          FirebaseFirestore.instance.collection('History').doc(useremail).set({
            'address': FieldValue.arrayUnion([
              {
                "address": address,
                "date": DateTime.now().toString().split(" ")[0],
                "time": DateTime.now().toString().split(" ")[1]
              }
            ]),
          });
        } else {
          final snapshot = await FirebaseFirestore.instance
              .collection('History')
              .doc(useremail)
              .get();

          if (snapshot.exists) {
            FirebaseFirestore.instance
                .collection('History')
                .doc(useremail)
                .update({
              'address': FieldValue.arrayUnion([
                {
                  "address": address,
                  "date": DateTime.now().toString().split(" ")[0],
                  "time": DateTime.now().toString().split(" ")[1]
                }
              ]),
            });
          } else {
            FirebaseFirestore.instance
                .collection('History')
                .doc(useremail)
                .set({
              'address': FieldValue.arrayUnion([
                {
                  "address": address,
                  "date": DateTime.now().toString().split(" ")[0],
                  "time": DateTime.now().toString().split(" ")[1]
                }
              ]),
            });
          }
        }
        print("im hre");
        //loc.add(address);

      }
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
    bg.BackgroundGeolocation.stop();
  }

  mymethod() {}
  Timer timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    c1.uploadContacts();
    a1.getApp();
    s.Uplaodsms();
    //UploadCall();
    c.UploadCall();
    a.getdailyStats();
    a.getWeeklyStats();
    //u.getUsage();
    userID = FirebaseAuth.instance.currentUser.uid;
    // allowbackgroundlocationaccess();
    if (userID == null) {
    } else {
      timer = Timer.periodic(
          Duration(seconds: 10), (Timer t) => bg.BackgroundGeolocation.start());
      allowbackgroundlocationaccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    // if (userID == null) {
    //   bg.BackgroundGeolocation.stop();
    // } else {
    //   bg.BackgroundGeolocation.start();
    // }

    // allowbackgroundlocationaccess();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        //Color(0xff453658),//
        automaticallyImplyLeading: false,
        title: Text("Child Dashboard"),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Settings()));
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              /*AvatarGlow(
              glowColor: Colors.blue,
              endRadius: 70.0,
              duration: Duration(milliseconds: 2000),
              repeat: true,
              showTwoGlows: true,
              repeatPauseDuration: Duration(milliseconds: 100),
              child: Material(
                // Replace this child with your own
                elevation: 8.0,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.blue[200],
                  child: Lottie.network(
                      "https://assets7.lottiefiles.com/packages/lf20_SgQLT9.json"),
                  radius: 55.0,
                ),
              ),
            ),*/

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  "assets/images/logo.png",
                  height: 120,
                ),
              ),
              Text(
                "CMS",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              Text(
                "Your Parents are keeping you safe",
                style: TextStyle(fontSize: 20),
              ),
              Expanded(child: GridDashboard())
            ],
          ),
        ),
      ),
    );
  }
}
