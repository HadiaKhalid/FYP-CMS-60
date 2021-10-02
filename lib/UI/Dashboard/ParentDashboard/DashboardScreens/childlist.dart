import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/AddChild.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/FeatureDashboard/features.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Childlist extends StatefulWidget {
  @override
  _ChildlistState createState() => _ChildlistState();
}

class _ChildlistState extends State<Childlist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      //),

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
                    Text(
                      "Keep your child secure!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 10,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue[200],
                          child: Icon(Icons.person),
                        ),
                        title: Text(
                          "Children",
                          style: TextStyle(fontSize: 20.0),
                        ),
                        subtitle: Text("Add child"),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddChildForm()));
                            }),
                      ),
                    ),
                  ),
                  Divider(),
                  Expanded(
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Users")
                          .doc(FirebaseAuth.instance.currentUser.uid)
                          .collection('Children')
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return ListView(
                            children: snapshot.data.docs.map((doc) {
                              return ListTile(
                                onLongPress: () {
                                  showPlatformDialog(
                                    context: context,
                                    builder: (_) => BasicDialogAlert(
                                      title: Text("Are you Sure?"),
                                      content:
                                          Text("You are deleting your child?"),
                                      actions: <Widget>[
                                        BasicDialogAction(
                                          title: Text("OK"),
                                          onPressed: () {
                                            _deleteChild(context, doc["email"]);
                                          },
                                        ),
                                        BasicDialogAction(
                                            title: Text("Discard"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    ),
                                  );
                                },
                                leading: CircleAvatar(
                                  backgroundColor: Colors.blue[200],
                                  child: Icon(Icons.person),
                                ),
                                title: Text(
                                  doc["name"],
                                  style: TextStyle(fontSize: 20.0),
                                ),
                                subtitle: Text(doc["email"]),
                                trailing: IconButton(
                                    icon: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => features(
                                                  email: doc["email"],
                                                  name: doc['name'])));
                                    }),
                              );
                            }).toList(),
                          );
                        } else {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child:
                                  CircularProgressIndicator(color: Colors.blue),
                            );
                          } else {
                            return Text("No Child added yet!");
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteChild(context, email) async {
    String userID = FirebaseAuth.instance.currentUser.uid;
    try {
      FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('Children')
          .doc(email)
          .delete()
          .whenComplete(() {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "Child has been successfully deleted",
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.message,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      // _btnController.error();
      Timer(Duration(seconds: 2), () {
        //_btnController.reset();
      });
    }
  }
}
