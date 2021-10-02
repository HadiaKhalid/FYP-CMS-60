import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:path_provider/path_provider.dart';



FirebaseStorage _storage = FirebaseStorage.instance;

class installapp {
  //get Install App

  getApp() async {
    print(
        "________________________\n\n Test #1 - GET APP FROM CHILD DASHBOARD - INSIDE GET APP METHOD\n\n_____________________________________________");
    try {
      // List<AppInfo>
      List<AppInfo> app = await InstalledApps.getInstalledApps(true, true);

      //bool isSystemApp = await InstalledApps.isSystemApp('')

      dynamic data;
       final directory = await getApplicationDocumentsDirectory();
      List<String> iconDownloadStrings = [];
      for(dynamic ap in app ){

final pathOfImage = await File('${directory.path}/${DateTime.now().microsecondsSinceEpoch}.png').create();
    await pathOfImage.writeAsBytes(ap.icon);
        print("upload started");
        String iconDownloadurl = await uploadPic(pathOfImage);
        print("Downloaded $iconDownloadurl");
        iconDownloadStrings.add(iconDownloadurl);
      }
      int index = 0;
List<Map<String, dynamic>> appsData = [];

      for(dynamic ap in app){
         Map<String, dynamic> appData = {
          'appName': ap.name,
          'versioon': ap.versionName,
          'packagenmame': ap.packageName,
           'icon': iconDownloadStrings[index],

          // 'icon': apps.icon
          // 'appVersion': apps.versionCode.toString(),
          // 'package': apps.packageName,
          // 'appicon': apps.icon,

          // 'appIcon': apps.icon,
        };
        index++;
        appsData.add(appData);
      }
      // dynamic appJson = await app.map((apps) async{
      //   // bool isSystemApp =
      //   //await InstalledApps.isSystemApp('${apps.packageName}');
      //   //if (isSystemApp == false) {
   
    
      //   Map<String, dynamic> appData = {
      //     'appName': apps.name,
      //     'versioon': apps.versionName,
      //     'packagenmame': apps.packageName,
      //     // 'icon': iconDownloadStrings[index],

      //     // 'icon': apps.icon
      //     // 'appVersion': apps.versionCode.toString(),
      //     // 'package': apps.packageName,
      //     // 'appicon': apps.icon,

      //     // 'appIcon': apps.icon,
      //   };
      // // index++;
      //   return appData;
      // }).toList();

     
      //dynamic appJson = app.map((apps) => apps.name).toList();

      //dynamic appJson = app.asMap();
      //print(appJson);

      //final icon = app.map((apps) => apps.packageName);
      // final a =  { app.map((AppInfo ap) => 'icon':ap.icon})};

      dynamic userID = FirebaseAuth.instance.currentUser.uid;

      //current user email
      dynamic useremail = FirebaseAuth.instance.currentUser.email;

     
      // print(con.phones);

      //using current child parent id to store Install App
      data = await FirebaseFirestore.instance
          .collection("Users")
          .doc(userID)
          .get();
      try {
        await FirebaseFirestore.instance
            .collection("Users")
            .doc(data['parentID'])
            .collection('Children')
            .doc(useremail)
            .update({
          "App": {
            'app': appsData,
            // 'pacakge': icon,
            // 'icon': icon,
            // { contacts.map((Contact contact){ 'name': contacs.displayName,contacts.phone})}
          }
          //print()
        });
      } catch (e) {
        print("APP UPLOADING FAILED");
        print(e);
      }
     
    } catch (e) {
       print(e);
    }
  }
}


 Future<String> uploadPic(File image) async {

    //Get the file from the image picker and store it 

    //Create a reference to the location you want to upload to in firebase  
    Reference reference = _storage.ref().child("images/${DateTime.now().microsecondsSinceEpoch}");

    //Upload the file to firebase 
    UploadTask uploadTask = reference.putFile(image);

    // Waits till the file is uploaded then stores the download url 
    String downloadString = (await uploadTask.then((TaskSnapshot v) async{
    String downloadUrl = await v.ref.getDownloadURL();

    print(downloadUrl);
     return downloadUrl;

    }));

    //returns the download url 
    return downloadString;
   }