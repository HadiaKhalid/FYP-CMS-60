import 'package:flutter/material.dart';
import 'components/body.dart';

class LoginScreen extends StatelessWidget {
  final String role;
  LoginScreen(this.role);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(role: role),
    );
  }
}
