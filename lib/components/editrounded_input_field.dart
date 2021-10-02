import 'package:flutter/material.dart';
import 'text_field_container.dart';
import '../constants.dart';

class EditRoundedInputField extends StatelessWidget {
//final variables 
//A variable with the final keyword will be 
//initialized at runtime and can only be assigned for a single time.
  final String hintText;//display label tex 
  final IconData icon;
  final ValueChanged<String> onChanged;
  final controller;
  const EditRoundedInputField(// constructor call
      {Key key,
      this.hintText,
      this.icon = Icons.person,
      this.onChanged,
      this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
