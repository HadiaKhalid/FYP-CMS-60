//import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// ignore: import_of_legacy_library_into_null_safe

class SMS extends StatefulWidget {
  dynamic email, name;
  SMS({this.email, this.name});
  // const SMS({Key? key}) : super(key: key);
  //final String text = '';
  //const SMS({Key? key}) : super(key: key);

  @override
  _SMSState createState() => _SMSState();
}

class _SMSState extends State<SMS> {
  // final String text;
//Make instance of SMS
  //MAKE LIST OF SMS

  List msg = [];
//initialize State

  void initState() {
    super.initState();
  }

//Make Method to get Sms from SMS Plugin

  void dispose() {
    super.dispose();
  }

  getSms() async {
    //get ALL SMS FROM sms instance and store in msg list
    try {
      //print("my app list function");()

      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      try {
        var data = await FirebaseFirestore.instance
            .collection("Users")
            .doc(userID)
            .collection('Children')
            .doc(widget.email)
            .get();
        print("print my data");

        msg = data['SMS']['sms'];
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

  /*void setStateIfMounted(f) {
      if (mounted) setState(f);
      msg = res;
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Messages")),

      // appBar: AppBar(
      //  title: Text("SMS"),
      //),
      body: FutureBuilder(
          //call get sms method
          future: getSms(),
          builder: (context, snapshot) {
            //no data sms exist then indiactae progress indicator or if there is some time to fetch data also indiacte progress indicator
            /*if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else {
              */
            return ListView.builder(
                itemCount: msg.length,
                itemBuilder: (context, int index) {
                  return Card(
                    child: ListTile(
//make sms list icon
                      leading: Icon(
                        Icons.markunread,
                        color: Colors.blue,
                      ),
                      // title: Text(msg[index].date.weekday.toString()),
                      //title: Text('${DateTime.fromMillisecondsSinceEpoch(int.parse(msg[index].date)).toIso8601String()}'),
                      // Text(msg[index].address),
                      //subtitle: Text(
                      //  '${msg[index].address} \n ${msg[index].body}',
                      // maxLines: 3,
                      //),
                      title: Text(
                        msg[index]['address'],
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 20,
                        ),
                      ),
                      subtitle: Text(
                        'DateTime:\n ${msg[index]['date']} \n Body:\n ${msg[index]['body']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      /*onTap: () async {
                      // mark the function as async
                      // print('tap');
                      // Show PopUp

                      // await the dialog
                      await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return new AlertDialog(
                              title: new Text(
                                'Message Body',
                                style: TextStyle(fontFamily: "Smash"),
                              ),
                              content: new Text(msg[index].body
                                  // style: TextStyle(fontFamily: "Smash"),
                                  ),
                              actions: [
                                FlatButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });

                      // Doesn't run
                      Navigator.of(context).pop();
                    },
*/
                      //msg[index].body,
                      //maxLines: 5}',
                      //),
                      //  onTap: () async {
                      // await AlertDialog(
                      // title: Text("Message Body:"),
                      // content: Text(msg[index].body),
                    ),
                    //}

                    // (msg[index].body);

                    //trailing: Text(msg[index].dateSent.timeZoneName),
                  );
                });
          }),
    );

    // void showcustomDialog(BuildContext,context){
  }

  /* showcustomDialog(BuildContext, context) {
    var text;
    return showDialog(
        builder: (context) => new AlertDialog(
            title: new Text(
              'Message Body',
              style: TextStyle(fontFamily: "Smash"),
            ),
            content: text,
                // style: TextStyle(fontFamily: "Smash"),
            
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ), context: context;
        });
*/
  /*createAlertDialog(BuildContext context) {
    //promise to return string
    //TextEditingController customController =
    // TextEditingController(); //new texteditingc object
    return AlertDialog(
      title: Text("Message Body:"),
      content: Text(msg.body),
    );
  }*/
}
