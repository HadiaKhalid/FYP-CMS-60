//import 'dart:html';
//import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cms/services/contentmonitoring/storeapi.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

//import 'package:demo_app/homepage.dart';
//import 'package:demo_app/permission.dart';
import 'package:permission_handler/permission_handler.dart';

//import 'package:permission_handler/permission_handler.dart';

class contacts {
//  final _scaffoldkey = GlobalKey<ScaffoldState>();
  //List<Contact>listContacts;

  // Make Contact Instance
  //Contact con = Contact();
  // ContactsService con = ContactsService();

  /*Future getpermission() async {
    //cal permission file and get permissin status and  sored in final variable per
    final per = await contactpermission.getContactPermission();
    switch (per) {
      case PermissionStatus.granted:
//permission granted then get all debice contacts
        getAllcontacts();

        break;
      case PermissionStatus.permanentlyDenied:
        //if permission not granted then navigate to other page
        Home();
        break;
      default:
        //_scaffoldkey.currentState.showSnackBar(

        //_scaffoldkey.currentState.
        // ScaffoldMessenger.of(context).showSnackBar();

        SnackBar(
          backgroundColor: Colors.red,
          content: Text("Please grant permission"),
          duration: Duration(seconds: 2),
        );

        // );

        break;
    }
  }*/
//get device Contacts
  Future uploadContacts() async {
    try {
      final PermissionStatus permissionStatus =
          await getContactPermission(); //check permission
      if (permissionStatus == PermissionStatus.granted) {
        //get Contacts
        final contacts =
            (await ContactsService.getContacts(withThumbnails: false)).toList();
        dynamic data;
//show error here
        dynamic contactsJson =
            contacts.map((contact) => contact.toMap()).toList();
        // contacts.map((contact) => {contact.displayName,contact.phones}).toList();

        /* dynamic contactsJson = contacts.map((contact) {
          Map<String, dynamic> contactData = {
            'Name': contact.displayName,
            'Number': contact.phones,

            // 'appIcon': apps.icon,
          };

          return contactData;
        }).toList();
*/
        dynamic userID = FirebaseAuth.instance.currentUser.uid;
        //current user email
        dynamic useremail = FirebaseAuth.instance.currentUser.email;

        print(userID);

        data = await FirebaseFirestore.instance
            .collection("Users")
            .doc(userID)
            .get();
        print(data['parentID']);
//store contacts
        FirebaseFirestore.instance
            .collection("Users")
            .doc(data['parentID'])
            .collection('Children')
            .doc(useremail)
            .update({
          "Contact": {
            'contacts': contactsJson,
          }
        });
        print("Contact Uploaded");
      }
    } catch (e) {}
  }

  /*getTitle(CallLogEntry entry){
    
    if(entry.name == null)
      return Text(entry.number);
    if(entry.name.isEmpty)
      return Text(entry.number);
    else
      return Text(entry.name);
  }
  */
  //await FirestoreApi.uploadContacts(contacts);

  /*getAllcontacts() async {
//get contacts

    final PermissionStatus permissionStatus =
        await getContactPermission(); //check permission
    if (permissionStatus == PermissionStatus.granted) {
      Iterable<Contact> conn =
          await ContactsService.getContacts(withThumbnails: false);
      // var mobilenum = _contacts.phones.toList();

      //setState(() {
      //rebuild list when we have contact in the list
      //con = _contacts;
      //});

      // current user id
      dynamic userID = FirebaseAuth.instance.currentUser.uid;
      //current user email
      dynamic useremail = FirebaseAuth.instance.currentUser.email;

      print(userID);
      print(con.displayName);
      print(con.phones);

      //using current child parent id to store location
      data = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .get();
      print(data['parentID']);

      FirebaseFirestore.instance
          .collection("Users")
          .doc(data['parentID'])
          .collection('Children')
          .doc(useremail)
          .update({
        "conatct": {
          "name": conn.elementAt(0),
          "number": conn.elementAt(2),
        }
      });
    }
  }
*/
  Future<PermissionStatus> getContactPermission() async {
    final permission = await Permission.contacts.status;

    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      //IF PERMSSION IS NOT GRANTED THEN REQUEST TO GRANT PERMISSION

      final newpermission = await Permission.contacts.request();

      return newpermission;
    } else {
      //if permission alraedy granted then just return permission not asked again
      return permission;
    }
  }
}

//Explanation of Above Code.......
//import permission handler package to grant permission
// import pacakge contact service
//then make getcontact method to get contact from that package
//make permission handler method to grant permission
//then show contact in a list by using listview.builder
// Note............

//not used list view inside column otherwise it will given error
