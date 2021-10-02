import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> opt = [
      "Location",
      "Calls",
      "SMS",
      "Contact",
      "Installed Apps"
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.blue,
        
        //Color(0xff453658),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: List.generate(5, (i) => MySwitchListTile(opt[i])),
      ),
    );
  }
}

class MySwitchListTile extends StatefulWidget {
  final String title;
  MySwitchListTile(this.title);
  @override
  _MySwitchListTileState createState() => new _MySwitchListTileState();
}

class _MySwitchListTileState extends State<MySwitchListTile> {
  bool _v = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SwitchListTile(
        title: Text(widget.title),
        activeColor: Colors.blue,
        inactiveTrackColor: Colors.grey[400],
        value: _v,
        onChanged: (value) => setState(() {
          _v = value;
        }),
      ),
      Divider(),
    ]);
  }
}
