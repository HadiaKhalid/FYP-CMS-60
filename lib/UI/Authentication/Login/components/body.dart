import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/UI/Dashboard/ChildDashboard/ChildDashBoard.dart';
import 'package:cms/UI/Dashboard/ParentDashboard/ParentDashboard.dart';
import 'package:cms/UI/OnBoardingScreens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../Login/components/background.dart';
import '../../Signup/signup_screen.dart';
import '../../../../components/already_have_an_account_acheck.dart';
import '../../../../components/rounded_input_field.dart';
import '../../../../components/rounded_password_field.dart';
import 'package:flutter_svg/svg.dart';
import '../../ForgotPassword/ForgotPasswordScreen.dart';

class Body extends StatelessWidget {
  dynamic name;

  final String role;
  Body({
    Key key,
    this.role,
    this.name,
  }) : super(key: key);
  String email = '';
  String password = '';
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    print(role);
    // dynamic userID = FirebaseAuth.instance.currentUser.uid;
    // print(userID);

    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 20.0),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/parentlogin.jpg",
              height: 120,
            ),

            /*SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),*/
            SizedBox(height: size.height * 0.03),
            RoundedInputField(
              hintText: "Your Email",
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
              child:
                  Text('    LOGIN    ', style: TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed: () {
                loginUser(context);
              },
            ),
            SizedBox(height: size.height * 0.03),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ForgotPasswordScreen()));
              },
              child: Text(
                "Forgot Password?",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Divider(
              color: Colors.blue,
              endIndent: 50,
              indent: 50,
            ),
            role == "PARENT"
                ? AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpScreen(role);
                          },
                        ),
                      );
                    },
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon(Icons.info_outline_rounded),
                      SizedBox(width: 5),
                      // Text(
                      //"Sign in Credentials Can be found in Parrent's Dashboard")
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  bool error = false;
  loginUser(context) async {
    FocusScope.of(context).unfocus();
    if (email.isEmpty || !email.contains("@") || !email.contains(".com")) {
      Fluttertoast.showToast(
          msg: "Please enter a valid Email",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      _btnController.reset();
      return;
    }
    if (password.isEmpty || password.length < 8) {
      Fluttertoast.showToast(
          msg: "Password is too short!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      _btnController.reset();
      return;
    }
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password)
          .then((value) {
        _btnController.success();
        Timer(Duration(seconds: 2), () {
          if (role == "PARENT") {
            User user = FirebaseAuth.instance.currentUser; //get current user
            if (user.emailVerified) {
              //check user is verified or not if yes then navigate to parent dashboard
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ParentDashboard()),
                  (route) => false);
            } else {
              //if not then ask them to verify first
              _btnController.error();
              Fluttertoast.showToast(
                  msg: "Please Verify your Email first",
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen(role)),
                  (route) => false);
            }

            /*Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ParentDashboard()),
                (route) => false);



                */
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ChildDashBoard()),
                (route) => false);
          }
        });
      });
    } on FirebaseAuthException catch (e) {
      if (role != "PARENT" &&
          e.message ==
              'There is no user record corresponding to this identifier. The user may have been deleted.') {
        DocumentSnapshot doc = await FirebaseFirestore.instance
            .collection("Users")
            .doc(email.trim())
            .get();
        if (doc.exists && doc["Status"] == "PENDING") {
          if (password == doc["password"]) {
            await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: email, password: password)
                .onError((error, stackTrace) {
              _btnController.error();
              Fluttertoast.showToast(
                  msg: "Password is incorrect",
                  backgroundColor: Colors.redAccent,
                  textColor: Colors.white);

              Timer(Duration(seconds: 3), () {
                _btnController.reset();
              });
            });
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(FirebaseAuth.instance.currentUser.uid)
                .set({
              "name": doc["name"],
              "email": email,
              "age": doc["age"],
              "Role": "CHILD",
              "parentID": doc["parentID"],
              'Status': "CREATED",
              'password': password,
            });
            await FirebaseFirestore.instance
                .collection("Users")
                .doc(email.trim())
                .delete();
            _btnController.success();

            Timer(
                Duration(
                  seconds: 2,
                ), () {
              _btnController.reset();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ChildDashBoard()),
                  (route) => false);
            });
          } else {
            _btnController.error();
            Fluttertoast.showToast(
                msg: "Password is incorrect",
                backgroundColor: Colors.redAccent,
                textColor: Colors.white);

            Timer(Duration(seconds: 3), () {
              _btnController.reset();
            });
          }
        } else {
          _btnController.error();
          Fluttertoast.showToast(
              msg: e.message,
              backgroundColor: Colors.redAccent,
              textColor: Colors.white);

          Timer(Duration(seconds: 3), () {
            _btnController.reset();
          });
        }
      } else {
        _btnController.error();
        Fluttertoast.showToast(
            msg: e.message,
            backgroundColor: Colors.redAccent,
            textColor: Colors.white);

        Timer(Duration(seconds: 3), () {
          _btnController.reset();
        });
      }
    }
  }
}
