import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/Models/Location.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AllLocation extends StatefulWidget {
  @override
  _AllLocationState createState() => _AllLocationState();
}

class _AllLocationState extends State<AllLocation> {
  GoogleMapController mapController; //contrller for Google map
  final Set<Marker> markers = new Set();

  //markers for google map
  List<Placemark> placemarks;
  List<double> lat = [];
  List<double> lng = [];
  LocationModel locmodel = new LocationModel();
  var intdata = 0;
  bool isloading = false;
  List mylocations = [];
  List childname = [];
  getdata() async {
    setState(() {
      isloading = true;
    });
    try {
      // print("yes null");
      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      var data = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userID)
          .collection('Children')
          .get();

      print(data);
      lat = [];
      lng = [];
      mylocations = [];
      childname = [];
      setState(() {
        intdata = data.docs.length;
      });
      for (int i = 0; i < data.docs.length; i++) {
        if (data.docs[i].data()['location'] == null) {
          print("yes null");
        } else {
          locmodel = LocationModel.fromJson(data.docs[i].data()['location']);

          // print("the length is ${data.docs[i].data()['location'].length}");
//  print("yes null");
          print("the markers ids are ${markersid.length}");
          if (lat.contains(locmodel.lat)) {
          } else {
            markersid.add(lat.length.toString());

            lat.add(locmodel.lat);
          }
          if (lng.contains(locmodel.lng)) {
          } else {
            lng.add(locmodel.lng);
          }

          placemarks = await placemarkFromCoordinates(lat[i], lng[i]);

          mylocations.add("${placemarks[0].name} ${placemarks[0].subLocality}");
          childname.add(data.docs[i].data()['name']);
          print('my childnames are $childname');
          print('the place markers are $mylocations');
          print("the lat is $lat");
          print("the lat lng is $lng");
          if (lat.length != intdata) {
            //   getdata();
          }
          // setState(() {
          //   myint++;
          // });
          // getmarkers();
        }
      }
      setState(() {
        isloading = false;
      });
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    print('the int data is ${lat.length}');
    print('the int data is2 ${intdata}');
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    /*  IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ParentDashboard()));
                        }),*/
                    Text(
                      "Track Kids Locations",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        // fontFamily: 'italic',
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.white,
              ),
              child: GoogleMap(
                //Map widget from google_maps_flutter package
                zoomGesturesEnabled: true,
                //enable Zoom in, out on map
                initialCameraPosition: CameraPosition(
                  //innital position in map
                  target: LatLng(33.6623, 73.0832), //initial position
                  zoom: 15.0, //initial zoom level
                ),
                markers: getmarkers(), //markers to show on map
                mapType: MapType.normal, //map type
                onMapCreated: (controller) {
                  //method called when map is created
                  setState(() {
                    mapController = controller;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List markersid = [];
  Set<Marker> getmarkers() {
    print("im here");

    //markers to place on map
    setState(() {
      try {
        for (int i = 0; i < lat.length; i++) {
          // var address = "${placemarks[i].name} ${placemarks[i].subLocality} ";
          mapController.animateCamera(CameraUpdate.newCameraPosition(
              new CameraPosition(
                  target: LatLng(lat[i], lng[i]), tilt: 0, zoom: 10.00)));
          markers.add(Marker(
            //add first marker
            markerId: MarkerId(markersid[i]),
            position: LatLng(lat[i], lng[i]), //position of marker
            infoWindow: InfoWindow(
              //popup info
              title: mylocations[i],
              snippet: childname[i] == null ? '' : childname[i],
            ),
            icon: BitmapDescriptor.defaultMarker, //Icon for Marker
          ));
        }
      } catch (e) {
        print(e);
      }
    });

    return markers;
  }
}
