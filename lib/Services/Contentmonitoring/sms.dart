import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:cms/services/contentmonitoring/storeapi.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms/sms.dart';
import 'package:intl/intl.dart';

class sms {
  //FirestoreApi f = new FirestoreApi();
  // print('sms Uploaded');

  String formatDate(DateTime dt) {
    return DateFormat('d-MMM-y H:m:s').format(dt);
  }

  //get device Sms

  Future Uplaodsms() async {
    print('sms Uploaded');

    try {
      dynamic data;

      SmsQuery s = new SmsQuery();
//get sms
      List<SmsMessage> msg = await s.querySms();

      //map sms list
      // dynamic smsJson = msg.map((m) => m.toMap).toList();

      dynamic smsJson = msg.map((m) {
        Map<String, dynamic> smsData = {
          'address': m.address,
          'date': formatDate(
            m.date,
          ),

          //m.date.toString(),
          'body': m.body,

          // 'appIcon': apps.icon,
        };

        return smsData;
      }).toList();
      //get user id
      dynamic userID = FirebaseAuth.instance.currentUser.uid;
      //get current user email
      dynamic useremail = FirebaseAuth.instance.currentUser.email;
      //store doc of curent user in data variable
      data = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .get();
      print(data['parentID']);
//from current user id get its parent id and with respect to current user email update new data
      FirebaseFirestore.instance
          .collection("Users")
          .doc(data['parentID'])
          .collection('Children')
          .doc(useremail)
          .update({
        "SMS": {
          'sms': smsJson,
        }
      });
      print('sms Uploaded');

      // m = res;

      // await FirestoreApi.uploadSms(msg);
    } catch (e) {
      print(e);
      //if (e.code == 'PERMISSION_DENIED') {
      // debugPrint("Permission Denied");
    }
  }
}
