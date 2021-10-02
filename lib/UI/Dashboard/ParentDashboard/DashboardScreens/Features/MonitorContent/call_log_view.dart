import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class callloglist extends StatefulWidget {
  //const callloglist({ Key? key }) : super(key: key);
  dynamic email, name;
  callloglist({this.email, this.name});

  @override
  _callloglistState createState() => _callloglistState();
}

class _callloglistState extends State<callloglist> {
  List mycall = [];

  void initstate() {
    super.initState();
    print("i am here");
    //getapplist();
    getcalllist();
  }

  getcalllist() async {
    try {
      print("my app list function");

      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      try {
        var data = await FirebaseFirestore.instance
            .collection("Users")
            .doc(userID)
            .collection('Children')
            .doc(widget.email)
            .get();
        print("print my data");

        mycall = data['CALL']['calls'];
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

  /*getTitle() async {
    if (mycall[3] == null) return await mycall[4];
    //if (entry.name == null) Text(entry.number);
    if (mycall[3].isEmpty)
      return await mycall[4];
    else
      return await mycall[3];
  }

  */

  /*getTitle(){

    
    if(mycall[0]['name'] == null)
      return Text(entry.number);
    if(entry.name.isEmpty)
      return Text(entry.number);
    else
      return Text(entry.name);
  }

  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("Call Log")),
      body: FutureBuilder(
        future: getcalllist(),
        builder: (context, snapshot) {
          return ListView.builder(
              itemCount: mycall.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: Icon(
                      Icons.call,
                      color: Colors.blue,
                    ),
                    //  title: Text(mycall[index]['number']),
                    //title: Text(getTitle()),
                    title: Text(
                      //  mycall[index]['name'] > 0
                      //  ? mycall[index]['name']
                      //: mycall[index]['number'],

                      //mycall[index]['number'],

                      // mycall[index]['name'],
                      mycall[index]['number'],

                      style: TextStyle(color: Colors.indigo, fontSize: 20),
                    ),
                    // title: Text(getTitle()),
                    subtitle: Text(
                      mycall[index]['timestamp'] +
                          '\n' +
                          mycall[index]['callType'],
                      style: TextStyle(
                        fontFamily: 'bold',
                        //fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Text(
                      mycall[index]['duration'],
                      style: TextStyle(
                        fontFamily: 'bold',
                        color: Colors.blue,
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
