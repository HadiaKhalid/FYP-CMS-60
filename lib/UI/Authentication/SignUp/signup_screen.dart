import 'package:flutter/material.dart';
import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  final String role;
  SignUpScreen(this.role);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(role),
    );
  }
}
