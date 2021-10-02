import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:cms/Models/Application.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class applist extends StatefulWidget {
  //const applist({ Key? key }) : super(key: key);
  dynamic email, name;
  applist({this.email, this.name});

  @override
  _applistState createState() => _applistState();
}

class _applistState extends State<applist> {
  //List<Application> a = [];
  //Application myap = new Application();
  List mydata = [];
  //List app = [];

  void initstate() {
    super.initState();
    print("i am here");
    getapplist();
  }

  getapplist() async {
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

        mydata = data['App']['app'];
//print(mydata[0]);
        print(mydata);

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

      //print(myap.appName);

      //  myap =
      //return data;
      //return myap;
      return mydata;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    //ye ider call kia h to call hua
    // getapplist();
    return Scaffold(
      body: FutureBuilder(
          future: getapplist(),
          builder: (context, snapshot) {
            return ListView.builder(

                /// itemCount.length,
                itemCount: mydata.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network(
                      mydata[index]['icon'],
                      height: 36,
                    ),
                    title: Text(
                      mydata[index]['appName'],
                      style: TextStyle(fontSize: 20, color: Colors.indigo),
                    ),
                    subtitle: Text(
                      mydata[index]['versioon'],
                      style: TextStyle(color: Colors.blue),
                    ),
                  );
                });
          }),
    );

    /*child: StreamBuilder(
          stream: getapplist(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            }

           // ren ListView.builder(
              itemCount: snapshot.data.document.length,
              itemBuilder: (BuildContext context, int index) {
                Map<dynamic, dynamic> map = snapshot.data.documents[index];
                final applist = map["app"] as List<Map<String, dynamic>>;
                return ListTile(
                  title: Column(
                      children: applist.map((app) {
                    return Text(app["appName"]);
                  }).toList()),
                );
              },
            );
          }),*/
  }
}
