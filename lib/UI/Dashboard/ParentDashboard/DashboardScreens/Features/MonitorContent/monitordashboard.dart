import 'package:cms/UI/Dashboard/ParentDashboard/DashboardScreens/AddChild.dart';
import 'package:flutter/material.dart';

class monitordash extends StatefulWidget {
  //const monitordash({ Key? key }) : super(key: key);

  @override
  _monitordashState createState() => _monitordashState();
}

class _monitordashState extends State<monitordash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(

        //),

        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(90),
                      topRight: Radius.circular(40)),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 50,
                          height: 100,
                        ),
                        Card(
                            elevation: 100,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  /* Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 50,
                                    
                                  
                                  ),
                                  */
                                  IconButton(
                                      onPressed: () {}, icon: Icon(Icons.call)),

                                  // Text("Call History"),
                                  // Text(
                                  // 'Call History',
                                  //style: TextStyle(color: Colors.white),
                                  //)
                                ],
                              ),
                            )),
                        SizedBox(
                          width: 50,
                        ),
                        Card(
                            elevation: 30,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.call,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                  Text('Call History')
                                ],
                              ),
                            ))

                        /*ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(Icons.person),
                          ),
                          title: Text("Children"),
                          subtitle: Text("Add child"),
                          trailing: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddChildForm()));
                              }),
                        ),

                        */
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
