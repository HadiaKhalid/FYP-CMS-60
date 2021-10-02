import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/Models/Location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/FeatureDashboard/features.dart';

class Location extends StatefulWidget {
  dynamic email, name;
  Location({this.email, this.name});
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  GoogleMapController mycontroller;
  Marker marker;
  //Set<Marker> _marker = HashSet<Marker>();
  // map controller variable  declare martker

  Timer timer;

  bool nothingtoshow = false;
  void updateMarker({dynamic newLocalData}) async {
    LatLng latlng = LatLng(newLocalData.lat, newLocalData.lng);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(newLocalData.lat, newLocalData.lng);
    print(placemarks[0].name);

    this.setState(() {
      var address = "${placemarks[0].name} ${placemarks[0].subLocality} ";
      marker = Marker(
          markerId: MarkerId("id 1"),
          position: latlng,
          // rotation: newLocalData.heading,
          draggable: false,
          zIndex: 19,
          infoWindow: InfoWindow(
              title: address,
              snippet: placemarks[0].locality + "," + placemarks[0].country),
          flat: true,
          icon: BitmapDescriptor
              .defaultMarker); //BitmapDescriptor.fromBytes(imageData))
    });
  }

  LocationModel mylocation = new LocationModel();

  getCurrentLocation() async {
    try {
      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      var data = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .collection('Children')
          .doc(widget.email)
          .get();

      mylocation = LocationModel.fromJson(data['location']);
      print("my lat lng is ${mylocation.lat}");
      print("my lat lng is ${mylocation.lng}");

      // print(data['location']['lat']);
      mycontroller.animateCamera(CameraUpdate.newCameraPosition(
          new CameraPosition(
              target: LatLng(mylocation.lat, mylocation.lng),
              tilt: 0,
              zoom: 17.00)));
      updateMarker(
        newLocalData: mylocation,
      );
    } catch (e) {
      setState(() {
        nothingtoshow = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  void initState() {
// to initialize marker on the map
    super.initState();

    try {
      timer = Timer.periodic(
          Duration(seconds: 3), (Timer t) => getCurrentLocation());
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(33.6361088, 73.069864),
      zoom: 20.0,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        /*appBar: AppBar(
          backgroundColor: Colors.blue,
          //Color(0xff453658),//
          automaticallyImplyLeading: false,
          title: Text("Location"),
          centerTitle: true,

          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => features(email: widget.email)));
              }),
        ),

        */
        body: nothingtoshow
            ? Center(
                child: Text(
                    "Nothing to Show! Make sure you have set up app on child device!",
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Colors.grey),
                    textAlign: TextAlign.center),
              )
            : GoogleMap(
                zoomGesturesEnabled: true,
                onMapCreated: (controller) {
                  setState(() {
                    mycontroller = controller;
                  });
                },
                initialCameraPosition: initialCameraPosition,
                markers: Set.of((marker != null) ? [marker] : []),
              ),
      ),
    );
  }
}
