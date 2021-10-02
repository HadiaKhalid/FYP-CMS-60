import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/FeatureDashboard/tabbar.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/ParentDashboard.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'GridFeatures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class features extends StatefulWidget {
  dynamic email, name;
  features({this.email, this.name});

  @override
  _FeaturesState createState() => _FeaturesState();
}

class _FeaturesState extends State<features> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: Colors.blue,
        //Color(0xff453658),//
        automaticallyImplyLeading: false,
        // title: Text("Features Dashboard"),
        centerTitle: true,

        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ParentDashboard()));
            }),
      ),
      */
      body: Column(
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
                //backgroundColor: Colors.blue[200],
                child:
                //     // Image.asset("assets/images/logo.png" ,height: 120,),
                 Lottie.network(
                    "https://assets7.lottiefiles.com/packages/lf20_SgQLT9.json"),
                radius: 55.0,
              ),
              
            ),
          ),*/

          Expanded(
              child:

                  // GridFeatures(email: widget.email)
                  tabbar(
            email: widget.email,
            name: widget.name,
          ))
        ],
      ),
    );
  }
}
