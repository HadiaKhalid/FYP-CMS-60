import 'package:flutter/material.dart';
import '../constants.dart';
// rounded button styling 
class RoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const RoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = kPrimaryColor,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;//responsive to parent 
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,//parent size 8 %
      child: ClipRRect(//for styling container oustsode 
        borderRadius: BorderRadius.circular(29),
        child: MaterialButton(
       // FlatButton(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),//inside padding 
          color: color,
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor),
          ),
        ),
      ),
    );
  }
}
