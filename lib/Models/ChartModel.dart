import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PieData {
  //const ({ Key? key }) : super(key: key);

  dynamic email;
  PieData({this.email});
  var name;
  List<dynamic> weekly = [];
  //List sortlist = [];
  List<dynamic> myFinalList = [];
  List newlist = [];

  getUsageStats() async {
    try {
      //print("my app list function");()

      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      try {
        var widget;
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
          myFinalList = weekly.take(6).toList();
          print(myFinalList[0]['percent']);
          for (var i = 0; i <= 6; i++) {
            myFinalList[i] = newlist;
          }
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

  static List<Data> data = [
    // // myFinalList[0];
    //Data(name: 'Blue', percent: 40, color: const Color(0xff0293ee)),
    // Data(name : myFinalList[0]['perecent'], percent: 40, color: const Color(0xff0293ee)),
    Data(name: 'blue', percent: 30, color: const Color(0xfff8b250)),
    Data(name: 'Black', percent: 15, color: Colors.black),
    Data(name: 'Green', percent: 15, color: const Color(0xff13d38e)),
  ];
}

class Data {
  final dynamic name;

  final double percent;

  final Color color;

  Data({this.name, this.percent, this.color});
}
