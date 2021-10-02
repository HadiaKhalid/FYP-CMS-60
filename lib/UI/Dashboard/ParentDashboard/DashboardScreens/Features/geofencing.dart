import 'package:cms/components/text_field_container.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../constants.dart';

class Geofence extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String hint;
  const Geofence({
    Key key,
    this.onChanged,
    this.hint,
  });
  @override
  _GeofenceState createState() => _GeofenceState();
}

class _GeofenceState extends State<Geofence> {
  /*bool visibility = false;
    


  RangeValues values = RangeValues(1,100);
  RangeLabels labels = RangeLabels('1','100');
  GoogleMapController mycontroller;// declarevmap contrller variable
  //Set <Marker> _marker = {};// map controller variable */

/*_handleTap(LatLng tappedPoint){

    setState(() {
        //  myMarker = [];

          myMarker.add(
Marker(
        markerId:MarkerId(tappedPoint.toString()),
        position:tappedPoint,
      ),
      );
    });
  }*/
  @override
  Widget build(BuildContext context) {
// when  loaded zoom to desfine lat and logn location this is also map controllers ariable
    // CameraPosition initialCameraPosition =  CameraPosition(
    //target: LatLng(33.6844,73.0479 ),
    //zoom:20.0,
    //);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
//resizeToAvoidBottomInset: true;
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Geofence")),

        /*appBar:AppBar(

     
           actions:<Widget>
           [
             Padding(padding:EdgeInsets.all(15.0),
             child:
Text("Save",
style: TextStyle(
  color:Colors.white,
  fontSize: 20.0,
  fontWeight: FontWeight.bold,
  
),
)
             ),
           ],
    ),*/

        /* body: 
  
 // SingleChildScrollView(
   // child:
   ListView(children: [
     Expanded(
       child:
    Column(children: [
     
SizedBox(height:20),


TextField(
style:TextStyle(
  color:Colors.black,
  fontSize: 20,
),
decoration:InputDecoration(
      
  
                            /*focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),*/
  hintText: "Geofence Title:",
    hintStyle: TextStyle(
    color:Colors.blue,

) ,




    ),
    
     ),
SizedBox(height:10),


TextField(
style:TextStyle(
  color:Colors.black,
  fontSize: 20,
),
decoration:InputDecoration(
      

 

  
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
  hintText: "Address:",
    hintStyle: TextStyle(
    color:Colors.blue,

) ,




    ),
    
     ),
     SizedBox(height:7),
     SingleChildScrollView(
       child:
       Column(children: [

Text("Geofence Radius",
style:TextStyle(color:Colors.blue),
),
RangeSlider( min: 1,
max: 100,
values: values,
divisions: 5,
labels: labels,
onChanged: (value){

setState(() {
  values= value;
  labels = RangeLabels(value.start.toString(),value.end.toString());
});

},




),

SizedBox(height:10),


Container

(
  height: 400,
  width: double.infinity,
  child:GoogleMap(
onMapCreated:(controller) {// when map initialized
  setState(() {
    mycontroller = controller; // control map component

    /*_marker.add(// add marker


Marker// map component 

(
markerId: MarkerId("id 1"),
position: LatLng(33.6844,73.0479 ),
infoWindow: InfoWindow(// add marker description

  title:"Islamabd",
  snippet:"User Current Location",

),




),

    
*/
    //);

    
  },);

},

initialCameraPosition:initialCameraPosition,
/*markers: Set.from( myMarker),
onTap: _handleTap,
*/


),




  ),






    ],
    ),
     )
    ],
    ),
     ),
   ],
     ),
     */
      ),
    );
  }
}
