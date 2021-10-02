import 'package:avatar_glow/avatar_glow.dart';
//import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/Features/dailystats.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class contactlist extends StatefulWidget {
  //const contactlist({ Key? key }) : super(key: key);
  dynamic email, name;
  contactlist({this.email, this.name});

  @override
  _contactlistState createState() => _contactlistState();
}

class _contactlistState extends State<contactlist> {
  //List contactsFiltered = [];
  //TextEditingController searchController = new TextEditingController();

  List mycontact = [];

  void initstate() {
    super.initState();
    print("i am here");
    //getapplist();
    //getcalllist();
  }

  getcontactlist() async {
    try {
      //print("my app list function");()

      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      try {
        var data = await FirebaseFirestore.instance
            .collection("Users")
            .doc(userID)
            .collection('Children')
            .doc(widget.email)
            .get();
        print("print my data");

        mycontact = data['Contact']['contacts'];
//print(mydata[0]);
//print(my);//

//print("my data $data['App']['app']");
        // myap = Application.fromJson(data['App']['app']);

        // print("my app name "+myap.appName);
        //print(myap.appVersion);
        //print(myap.)
        //for (int i = 0; i <= 10; i++) {
        //print(myap.appName);
        // }

        // print(myap.appName);
        //  print(myap.appVersion);
      } catch (e) {
        print(e);
      }
    } catch (e) {}
  }

  /* filterContacts() {
    List _contacts = [];
    _contacts.addAll(mycontact);
    if (searchController.text.isNotEmpty) {
      _contacts.retainWhere((mycontact) {
        String searchTerm = searchController.text.toLowerCase();
        // String searchTermFlatten = flattenPhoneNumber(searchTerm);
        String contactName = mycontact.info.displayName.toLowerCase();
        bool nameMatches = contactName.contains(searchTerm);
        if (nameMatches == true) {
          return true;
        }

        // if (searchTermFlatten.isEmpty) {
        return false;
        //}
      });

      setState(() {
        contactsFiltered = _contacts;
      });
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text("Contact")),

      // listItemsExist == true ?  // if we have contacts to show

      body: FutureBuilder(
          future: getcontactlist(),
          builder: (context, snapshot) {
            return ListView.builder(
                //listItemsExist == true ?  // if we have contacts to show

                itemCount: mycontact.length,
                itemBuilder: (context, index) {
                  return Card(
                    // listItemsExist == true ?  // if we have contacts to show

                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue[200],
                        child: Icon(Icons.person),
                      ),

                      title: Text(
                        mycontact[index]['displayName'],
                        style: TextStyle(fontSize: 20, color: Colors.indigo),
                      ),
                      subtitle: Text(mycontact[index]['phones'][0]['value']),
                      //subtitle: Text(mycontact[index]['value']),
                      // subtitle: Text(mycontact[index]['Phones']['value']),
                    ),
                  );
                });
            // contacts: isSearching == true ? contactsFiltered : contacts,
          }),
      //  mycontact: isSearching == true ? contactsFiltered : contacts,
    );
  }
}
