import 'dart:async';
import 'package:cms/UI/Dashboard/ParentDashboard/ParentDashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/UI/OnBoardingScreens/Welcome/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../../components/already_have_an_account_acheck.dart';
import '../../../../components/rounded_input_field.dart';
import '../../../../components/rounded_button.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../components/text_field_container.dart';
import '../../../../constants.dart';
import 'background.dart';
import '../../../../components/rounded_password_field.dart';
import 'package:flutter/material.dart';
import '../../Login/login_screen.dart';

class Body extends StatelessWidget {
  final String role;
  Body(this.role);
  String name = '';
  String email = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: size.height * 0.05),
            Text(
              "SIGNUP",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.blue),
            ),
            SizedBox(height: size.height * 0.03),
            Image.asset(
              "assets/images/signup.png",
              height: 120,
            ),

            /*SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.2,
            ),*/
            RoundedInputField(
              hintText: "Name", //initialize components variable
              onChanged: (value) {
                name = value;
              },
            ),
            RoundedInputField(
              hintText: "Your Email",
              icon: Icons.email_rounded,
              onChanged: (value) {
                email = value;
              },
            ),
            TextFieldContainer(
              child: TextField(
                onChanged: (value) {
                  phone = value;
                },
                keyboardType: TextInputType.phone,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone_enabled_rounded,
                    color: kPrimaryColor,
                  ),
                  hintText: "Phone",
                  border: InputBorder.none,
                ),
              ),
            ),
            RoundedPasswordField(
              hint: "Password",
              onChanged: (value) {
                password = value;
              },
            ),
            RoundedPasswordField(
              hint: "Confirm Password",
              onChanged: (value) {
                confirmPassword = value;
              },
            ),
            SizedBox(height: 10),
            //rounded loading button is built in method of that package?
            //Its a widget not method.
            //ok
            //Every UI component in flutter is a widget project runn
            RoundedLoadingButton(
              width: MediaQuery.of(context).size.width * 0.8,
              child:
                  Text('    SIGNUP    ', style: TextStyle(color: Colors.white)),
              controller: _btnController,
              onPressed: () {
                signupUser(context);

               
              },
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: size.height * 0.06),
          ],
        ),
      ),
    );
  }

  signupUser(context) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
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
    if (phone.length != 11) {
      Fluttertoast.showToast(
          msg: "Invalid phone Number (e.g : 0300XXXXXXX )",
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
    if (password != confirmPassword) {
      Fluttertoast.showToast(
          msg: "Password & Confirm Password Does not match!",
          backgroundColor: Colors.redAccent,
          textColor: Colors.white);
      _btnController.reset();
      return;
    }

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email.trim(), password: password)
        .onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.message);
      _btnController.error();
      Timer(Duration(seconds: 2), () {
        _btnController.reset(); //can u tell why did we use this
      });
    }).whenComplete(() async {
      User user = FirebaseAuth.instance.currentUser;
      user.sendEmailVerification();
      Alert(context);
      Fluttertoast.showToast(
          msg: 'Verification Link has been Send to your email address');

      String userID = FirebaseAuth.instance.currentUser.uid;
      await FirebaseFirestore.instance.collection("Users").doc(userID).set({
        "name": name,
        "email": email,
        "phone": phone,
        "Role": "PARENT",
        "userID": userID
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WelcomeScreen(role)

              //ParentDashboard()

              ),
          (route) => false);
    });
  }

  void Alert(context) {
    showDialog(
      context: context,
      //BuildContext: context {

      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text('Alert'),
          content: new Text(
              "An Email link has been sent to your Email Address Please before login"),
          actions: [
            new FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('ok'),
            ),
          ],
        );
      },
    );
  }
}
//this what u added?
//Yes just changed the navigator type
// Can not say now that it will fix the issue . But lets see the log.
//okok

// There is a dependency in pubspec.yaml
// Rounded loading button
//it has states i.e , Success, error, reset.
//
//Basically it is an annimated button
//So when clicked it will start a loading state. Through controller we have managed its state. Like when to show success
// or error stated.
// now forexample it there is an error in the process the loading button will change its
// state to error throuth _btnController.error(),

//_btnController is an controller object and is used to controll the state of its parent class
