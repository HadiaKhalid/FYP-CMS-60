import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/UI/Dashboard/ChildDashboard/ChildDashBoard.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/ParentDashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../OnBoardingScreens/SelectRole.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /*with TickerProviderStateMixin {
  AnimationController _controller;*/

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () {
      print("Time End");
      checkUserStatus();
    });
    /*_controller = AnimationController(vsync: this);*/
  }

  checkUserStatus() async {
    User user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SelectRole()));
    } else {
      DocumentSnapshot snap = await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .get();

      if (snap["Role"] == "PARENT") {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ParentDashboard()),
            (route) => false);
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ChildDashBoard()),
            (route) => false);
      }
    }
  }

  @override
  /* void dispose() {
    _controller.dispose();
    super.dispose();
  }
  */

  @override
  Widget build(BuildContext context) {
    return
        /* Stack(
      children:<Widget>[

Image.asset("assets/images/background.jpg",
height: MediaQuery.of(context).size.height,
width: MediaQuery.of(context).size.width,
fit: BoxFit.cover,

),*/

        Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Container()),
          Hero(
            tag: "splash",
            child:

                /* new Tab(icon: new Image.asset("assets/images/logo.png",height: 100)),*/
                Image.asset(
              "assets/images/logo.png",
              height: 120,
            ),

            /*Lottie.asset(
                    'assets/animations/splashAnimation.json',
                    controller: _controller,
                    onLoaded: (composition) {
                      // Configure the AnimationController with the duration of the
                      // Lottie file and start the animation.
                      print(composition.duration);
                      _controller
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),*/
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Child Monitoring System",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "CMS",
                  ),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 1,
                    endIndent: 40,
                    indent: 40,
                  ),
                  Text(
                    "@copyrights reserved Hadia & Afshan",
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
