import 'package:flutter/material.dart';
import 'components/body.dart';
import 'components/editbody.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditBody(),
    );
  }
}
