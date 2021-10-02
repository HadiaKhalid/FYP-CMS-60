import 'package:flutter/material.dart';
import 'components/body.dart';
class WelcomeScreen extends StatelessWidget {
  final String role;
  WelcomeScreen(this.role);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(role),
    );
  }
}
