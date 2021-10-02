import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cms/components/editrounded_input_field.dart';
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

import '../../Login/login_screen.dart';

class EditBody extends StatefulWidget {
  @override
  _EditBodyState createState() => _EditBodyState();
}

class _EditBodyState extends State<EditBody> {
  TextEditingController emails, names, phones;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprofile();
  }

  dynamic data;
  bool isLoading = false;
  getprofile() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then((value) => {
              data = value,
              print(data),
              emails = new TextEditingController(text: data['email']),
              names = new TextEditingController(text: data['name']),
              phones = new TextEditingController(text: data['phone']),
            });
    setState(() {
      isLoading = false;
    });
  }

 @override
  void dispose() {
    // TODO: implement dispose
    //do it for others
    names.dispose();
    emails.dispose();
    phones.dispose();
    super.dispose();
}
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: size.height * 0.05),
                  Text(
                    "Edit Profile ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        color: Colors.blue),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Image.asset(
                    "assets/images/parentlogin.jpg",
                    height: 120,
                  ),

                  /*SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.2,
            ),*/

                  EditRoundedInputField(
                    hintText: "Name",
                    controller: names,
                  ),
                  EditRoundedInputField(
                    hintText: "Your Email",
                    icon: Icons.email_rounded,
                    controller: emails,
                  ),
                  EditRoundedInputField(
                    hintText: "Your Phone",
                    icon: Icons.email_rounded,
                    controller: phones,
                  ),
                  SizedBox(height: 10),
                  RoundedLoadingButton(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text('    Update    ',
                        style: TextStyle(color: Colors.white)),
                    controller: _btnController,
                    onPressed: updateUser,
                  ),
                  SizedBox(height: size.height * 0.03),
                  SizedBox(height: size.height * 0.06),
                ],
              ),
      ),
    );
  }

  updateUser() async {
    String name = names.text.trim();
    String email = emails.text.trim();
    String phone = phones.text.trim();
    if (name.isEmpty || email.isEmpty || phone.isEmpty) {
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
    String userID = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance.collection("Users").doc(userID).update({
      "name": name,
      "email": email,
      "phone": phone,
      "Role": "PARENT"
    }).onError((error, stackTrace) {
      Fluttertoast.showToast(msg: error.message);
      _btnController.error();
      Timer(Duration(seconds: 2), () {
        _btnController.reset();
      });
    }).whenComplete(() async {
      Fluttertoast.showToast(msg: "Successfully Updated");
      _btnController.reset();
    });
  }
}
