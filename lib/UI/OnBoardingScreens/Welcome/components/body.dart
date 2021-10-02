import 'package:flutter/material.dart';
import 'background.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../components/rounded_button.dart';
import '../../../../constants.dart';
import '../../../Authentication/Login/login_screen.dart';
import '../../../Authentication/SignUp/signup_screen.dart';
class Body extends StatelessWidget {

  final String role;
  Body(this.role);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "WELCOME TO $role",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20.0,color:Colors.blue),
            ),
            SizedBox(height: size.height * 0.05),
            /*SvgPicture.asset(
              "assets/images/logo.png",
              height: size.height * 0.45,
            ),
            */
            Image.asset("assets/images/logo.png" ,height: 120,),
            SizedBox(height: size.height * 0.05),
            RoundedButton(
              text: "LOGIN",
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen(role);
                    },
                  ),
                );
              },
            ),
            Visibility(
              visible: role=="PARENT",
                          child: RoundedButton(
                text: "SIGN UP",
                color: kPrimaryLightColor,
                textColor: Colors.black,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
