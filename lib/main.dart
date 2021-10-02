import 'package:cms/UI/Splash/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
    WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of our application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CMS - Child Monitoring System',
      theme: ThemeData(// use same theme throughout app 
        fontFamily: GoogleFonts.nunito().fontFamily,
        primarySwatch: Colors.blue,// use color shade 
      ),
      home: SplashScreen(),
    );
  }
}

