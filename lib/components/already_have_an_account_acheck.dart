import 'package:flutter/material.dart';
import '../constants.dart';
//to store static ui
class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;// initialize variable use in other class
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //to align multiple widgets in one row children property is used.
    //for row and column we use children 
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        //text property is style and style will have textstyle widget

        Text(        
          login ? "Don’t have an Account ? " : "Already have an Account ? ",//if login true then 
          style: TextStyle(color: kPrimaryColor),
        ),
        GestureDetector(// handling tap action
          onTap: press,
        
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: kPrimaryColor,
              fontWeight: FontWeight.bold,

            ),
          ),
        )
      ],
    );
  }
}
