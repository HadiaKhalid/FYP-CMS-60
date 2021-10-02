import 'dart:collection';

import 'package:app_usage/app_usage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cms/services/contentmonitoring/installedappservice.dart';
//import 'package:cms/services/contentmonitoring/installedappservice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class appstatistics {
  //Future getweeklystats() async {}

  //weekly stats
  /* Future appname(name) async {
    List<AppInfo> app = await InstalledApps.getInstalledApps(true, true);

    dynamic appjson = app.map((apps) async {
      if (name == apps.packageName)
        // return appJson;
        return name;
    }).toList();
  }
  */
  // installapp a = new installapp();
  //String getname() {
  // dynamic name = a.getApp();
  //name.toString();
  //if()

  //}

  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);

    //  Duration d1 = Duration();
    String formatedDuration = "";
    if (d1.inHours > 0) {
      formatedDuration += d1.inHours.toString() + "h ";
    }
    if (d1.inMinutes > 0) {
      formatedDuration += d1.inMinutes.toString() + "m ";
    }
    if (d1.inSeconds > 0) {
      formatedDuration += d1.inSeconds.toString() + "s";
    }
    if (formatedDuration.isEmpty) return "0s";
    return formatedDuration;
  }

  getpercent(int hr) {
    //dynamic total = 1440;
    //  dynamic percent;
    // percent = min / 1440 * 100;
    // percent = double.infinity()

//return min / 1440 * 100;
    var r = hr / 168;
    // var num1 = double.parse((r).toStringAsFixed(2));

    return r * 100;
  }

  Future getname(dynamic nameee) async {
    DateTime endtime = new DateTime.now(); //end time measure
    DateTime starttime = endtime.subtract(Duration(hours: 80));

    List<AppInfo> app = await InstalledApps.getInstalledApps(true, true);

    List<AppUsageInfo> infoList =
        await AppUsage.getAppUsage(starttime, endtime);
    //for (int i = 0; i > infoList.length; i++) {
    // print();
    // }\

    //Logic of get appname from insatlled app list
    //dynamic namee;
    dynamic usagename;
    dynamic newname = '';
    for (var info in app) {
      // print(info.appName);
      nameee = info.packageName;
      for (var i in infoList) {
        usagename = i.packageName;
      }
      if (usagename == nameee) return newname += nameee;
    }
  }

  Future getdailyStats() async {
    try {
      //var endtime = formatDate( DateTime.now());
      DateTime endtime = new DateTime.now(); //end time measure
      DateTime starttime = endtime.subtract(Duration(hours: 24));

      ///start meauring time usage by subtracting hours duraton of current time
      ///
      // List<AppInfo> app = await InstalledApps.getInstalledApps(true, true);

      List<AppUsageInfo> infoList =
          await AppUsage.getAppUsage(starttime, endtime);
      //for (int i = 0; i > infoList.length; i++) {
      // print();
      // }\

      //Logic of get appname from insatlled app list

      /*dynamic namee;
      dynamic usagename;
      dynamic newname = '';
      for (var info in app) {
        // print(info.appName);
        namee = info.name;
        for (var i in infoList) {
          usagename = i.appName;
        }
        if (usagename == namee) return newname += namee;
      }
      */
      dynamic data;

      dynamic statJson = infoList.map((info) {
        Map<String, dynamic> statData = {
          //'appName':
          //appname(info.appName),
          // info.appName.indexOf(pattern)
          //namee,
          // getname(info.appName),
          // info.appName,
          //  info.packageName.endsWith
          'Package': info.packageName,
          // getname(info.packageName),

          'appUsage':
              // getTime(info.usage),
              info.usage.toString(),
          'percent': getpercent(info.usage.inHours),
          'Minutes': '${info.usage.inMinutes}m',

          // '${getpercent(int.parse(info.usage.inMinutes))}m',

          // 'end': info.endDate.minute,
          //  'end':info.endDate
          //info.usage.toString(),

          // 'appIcon': apps.icon,
          // 'percent': getpercent(info.usage.inMinutes),
        };

        return statData;
      }).toList();

      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      //current user email
      dynamic useremail = FirebaseAuth.instance.currentUser.email;

      print(userID);
      print(useremail);
      // print(con.phones);

      //using current child parent id to store Install App
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
        "DailyStats": {
          'daily': statJson
          // 'pacakge': icon,
          // 'icon': icon,
          // { contacts.map((Contact contact){ 'name': contacs.displayName,contacts.phone})}
        }
      });
      print('daily Stats Uploaded');
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }

  Future getWeeklyStats() async {
    try {
      //var endtime = formatDate( DateTime.now());
      DateTime endtime = new DateTime.now(); //end time measure
      DateTime starttime = endtime.subtract(Duration(hours: 168));

      ///start meauring time usage by subtracting hours duraton of current time
      List<AppUsageInfo> weekList =
          await AppUsage.getAppUsage(starttime, endtime);

      // for (var info in infoList) {
      //  print(info.toString());
      //}
      dynamic data;

      dynamic weekstatJson = weekList.map((info) {
        Map<dynamic, dynamic> weekstatData = {
          'package': info.packageName,
          'appName': info.appName,
          'hours': '${info.usage.inHours}h',
          'Minutes': '${info.usage.inMinutes}m',
          // minutes:info.usage.inMinutes,
          'second': '${info.usage.inSeconds}sec',
          // 'hours': info.usage.
          'Totalusage': info.usage.toString(),
          'percent': '${getpercent(info.usage.inHours)}%',
          //'startdate':info.startDate

          // 'appIcon': apps.icon,
        };
//sorting list

        //final sorted = new SplayTreeMap.from(weekstatData, (a, b) {
        //print(we)
        /// // print(weekstatData[a]);
        //return int.parse(weekstatData[a]['Minutes'].split("m")[0])
        // .toString()
        // .compareTo(int.parse(weekstatData[b]['Minutes'].split("m")[0])
        //  .toString());
        // });

        return weekstatData;
        //return sorted;
      }).toList();

      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      //current user email
      dynamic useremail = FirebaseAuth.instance.currentUser.email;

      print(userID);
      print(useremail);
      // print(con.phones);

      //using current child parent id to store Install App
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
        "WeeklyStats": {
          'weekly': weekstatJson
          // 'pacakge': icon,
          // 'icon': icon,
          // { contacts.map((Contact contact){ 'name': contacs.displayName,contacts.phone})}
        }
        //print()
      });
      print('weekly stats uploaded');
    } on AppUsageException catch (exception) {
      print(exception);
    }
  }
}
