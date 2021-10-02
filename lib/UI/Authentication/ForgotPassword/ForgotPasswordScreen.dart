import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * .4,
                  child: 
                  /*Image.asset(
                    "assets/animations/forgotanimation.gif",
                    scale: 0.6,
                  )*/
            Image.asset("assets/images/foregt.jpg" ,height: 120,),

                  
                  ),
              Container(
                height: 60,
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(40)),
                child: Center(
                    child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      focusColor: kPrimaryColor,
                      border: InputBorder.none,
                      hintText: "Email",
                      prefixIcon: Icon(Icons.email)),
                )),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Enter your email and we will send you a link to reset your password",
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 50,
              ),
              RaisedButton(
                padding: EdgeInsets.all(20),
                color: kPrimaryColor,
                onPressed: () {
                  sendResetLink(context);
                },
                shape: CircleBorder(),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void sendResetLink(context) async {
    if (_emailController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter a valid email",backgroundColor: Colors.redAccent,textColor:Colors.white
      );
      return;
    }
    if (!_emailController.text.contains("@") ||
        !_emailController.text.contains(".com")) {
      Fluttertoast.showToast(
        msg: "Please enter a valid email",backgroundColor: Colors.redAccent,textColor:Colors.white
      );
      return;
    }

    FirebaseAuth.instance
        .sendPasswordResetEmail(email: _emailController.text.trim());
    Fluttertoast.showToast(msg: "Reset Link sent");
    _emailController.clear();
  }
}
