import 'package:cms/constants.dart';
import 'package:flutter/material.dart';

class IndicatorsWidget extends StatefulWidget {
  final List appList;
  IndicatorsWidget({this.appList});

  _IndicatorsWidgetState createState() => _IndicatorsWidgetState();
}

class _IndicatorsWidgetState extends State<IndicatorsWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.appList.length,
        itemBuilder: (context, index) {
          return Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: buildIndicator(
                  color: colors[index],

                  // myFinalList['percent'],

                  //text: data.name,

                  text: widget.appList[index]['package']

                  // isSquare: true,

                  ));
        });
  }

  Widget buildIndicator(
          {@required Color color,
          @required String text,
          bool isSquare = false,
          double size = 16,
          Color textColor = Colors.indigo

          //const Color(0xff505050),
          }) =>
      Row(
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          )
        ],
      );
}
