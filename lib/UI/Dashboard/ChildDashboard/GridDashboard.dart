import 'package:cms/UI/OnBoardingScreens/SelectRole.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatelessWidget {
  Items item1 = new Items(
      title: "SOS", subtitle: "", color: Colors.red[900], img: "assets/sos (1).png");

  Items item2 = new Items(
    title: "Voice Command SOS",
    subtitle: "",
    color:Colors.red[900],
    img: "assets/microphone (1).png",
  );
  Items item3 = new Items(
    title: "Set Alert Message",
    subtitle: "",
    color: Colors.blue,
    img: "assets/notification.png",
  );
  Items item4 = new Items(
    title: "Logout",
    subtitle: "",
    color: Colors.blueGrey,
    img: "assets/log-out.png",
  );

  @override
  Widget build(BuildContext context) {
    List<Items> myList = [item1, item2, item3, item4];
    var color = Colors.blue;
    //0xff453658;//
    return GridView.count(
        childAspectRatio: 1.0,
        padding: EdgeInsets.only(left: 16, right: 16, top: 30),
        crossAxisCount: 2,
        crossAxisSpacing: 18,
        mainAxisSpacing: 18,
        children: myList.map((data) {
          return InkWell(
            onTap: () {
              String title = data.title;
              switch (title) {
                case "Logout":
                  FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SelectRole()),
                      (route) => false);
              }
            },
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                decoration: BoxDecoration(
                  color: data.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      data.img,
                      width: 55,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      data.title,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList());
  }
}

class Items {
  String title;
  String subtitle;
  String img;
  Color color;
  Items({this.title, this.subtitle, this.color, this.img});
}
