import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/rounded_input_field.dart';
import 'package:cms/components/rounded_password_field.dart';
import 'package:cms/components/text_field_container.dart';
import 'package:cms/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddChildForm extends StatelessWidget {
  String age = '';
  String name = '';
  String email = '';
  String password = "";
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Child"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AvatarGlow(
                  glowColor: Colors.red,
                  endRadius: 90.0,
                  duration: Duration(milliseconds: 2000),
                  repeat: true,
                  showTwoGlows: true,
                  repeatPauseDuration: Duration(milliseconds: 100),
                  child: Image.asset(
                    "assets/images/childlogin.jpg",
                    //color: Colors.purple
                  )),

              /*Material(
                  // Replace this child with your own
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.blue[200],
                    child: Lottie.network(
                        "https://assets7.lottiefiles.com/packages/lf20_SgQLT9.json"),
                    radius: 55.0,
                  ),
                ),
              ),*/

              RoundedInputField(
                hintText: "Child Name",
                icon: Icons.person,
                onChanged: (value) {
                  name = value;
                },
              ),
              TextFieldContainer(
                child: TextField(
                  onChanged: (value) {
                    age = value;
                  },
                  keyboardType: TextInputType.phone,
                  cursorColor: kPrimaryColor,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.assignment_ind_rounded,
                      color: kPrimaryColor,
                    ),
                    hintText: "Age",
                    border: InputBorder.none,
                  ),
                ),
              ),
              RoundedInputField(
                hintText: "Child Email",
                icon: Icons.email,
                onChanged: (value) {
                  email = value;
                },
              ),
              RoundedPasswordField(
                hint: "Password",
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 10),
              RoundedLoadingButton(
                  width: MediaQuery.of(context).size.width * 0.8,
                  controller: _btnController,
                  onPressed: () {
                    _addChild(context);
                  },
                  child: Text("Add"))
            ],
          ),
        ),
      ),
    );
  }

  void _addChild(context) async {
    print("$name $email $age $password");
    if (name.isEmpty || email.isEmpty || password.isEmpty || age.isEmpty) {
      Fluttertoast.showToast(
          msg: "Please fill the credentials properly!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      _btnController.reset();
      return;
    }
    if (!email.contains("@") || !email.contains(".com")) {
      Fluttertoast.showToast(
          msg: "Enter a valid Email Address",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      _btnController.reset();
      return;
    }

    if (password.length < 8) {
      Fluttertoast.showToast(
          msg: "Password is too short",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      _btnController.reset();
      return;
    }
    String userID = FirebaseAuth.instance.currentUser.uid;
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(email.trim())
          .set({
        "name": name,
        "email": email,
        "age": age,
        "Role": "CHILD",
        "parentID": userID,
        'Status': "PENDING",
        'password': password,
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
            msg: "Something went wrong! Please try again later!",
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);
        _btnController.error();
        Timer(Duration(seconds: 2), () {
          _btnController.reset();
        });
      }).whenComplete(() async {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(userID)
            .collection("Children")
            .doc(email.trim())
            .set({
          "name": name,
          "email": email,
          "age": age,
          "Role": "CHILD",
          "parentID": userID,
          'Status': "PENDING",
          'password': password,
        }).whenComplete(() {
          _btnController.success();
          Timer(Duration(seconds: 2), () {
            _btnController.reset();
            Navigator.pop(context);
          });
        });
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.message,
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      _btnController.error();
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
      });
    }
  }
}
