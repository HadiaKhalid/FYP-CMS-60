import 'package:flutter/material.dart';
import 'Welcome/welcome_screen.dart';

class SelectRole extends StatelessWidget {
  dynamic email, name;
  SelectRole({this.email, this.name});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(),
          Hero(
            tag: "splash",
            child: Image.asset(
              "assets/images/logo.png",
              height: 120,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "CMS",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(" A child monitoring system to keep your child secure!",
              textAlign: TextAlign.center),
          SizedBox(
            height: 20,
          ),
          Divider(
            indent: 60,
            endIndent: 60,
            thickness: 1,
            color: Colors.grey[400],
          ),
          Text("Please select your role"),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue[100], blurRadius: 15, spreadRadius: 8)
                ]),
            height: 70,
            width: MediaQuery.of(context).size.width * 0.7,
            child: InkWell(
              onTap: () {
                print("Parent Clicked");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => WelcomeScreen("PARENT")));
              },
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/images/parentrolee.jpg")),
                  SizedBox(width: 55),
                  Center(
                      child: Text(
                    "Parent",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.blue[100], blurRadius: 15, spreadRadius: 8)
                ]),
            height: 70,
            width: MediaQuery.of(context).size.width * 0.7,
            child: InkWell(
              onTap: () {
                print("Child Clicked");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => WelcomeScreen("CHILD")));
              },
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/child.jpg",
                      )),
                  SizedBox(width: 50),
                  Center(
                      child: Text(
                    "Child",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
