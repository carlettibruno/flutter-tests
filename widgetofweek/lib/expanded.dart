import 'package:flutter/material.dart';
import 'safearea.dart';

class WowExpanded extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Container(
            //color: Colors.blue,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topRight: Radius.circular(5), bottomRight: Radius.circular(40)),
              boxShadow: [
                BoxShadow(
                  color: Colors.yellow[900],
                  offset: Offset(0, 2)
                )
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.yellow[400],
                  Colors.yellow[500],
                  Colors.yellow[600],
                  Colors.yellow[800]
                ]
              )
            ),
            child: WowSafeArea(),

          ),
          flex: 10,
        ),
        WowSafeArea(),
        Expanded(
          child: Container(
            color: Colors.yellow,
            child: WowSafeArea()
          ),
          flex: 2,
        ),
        WowSafeArea(),        
      ],
    );
  }
}