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
            color: Colors.blue,
            child: WowSafeArea()
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