import 'package:flutter/material.dart';
import 'expanded.dart';
import 'safearea.dart';

class WowWrap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      alignment: WrapAlignment.spaceAround,
      children: <Widget>[
        WowExpanded(),
        WowSafeArea(),
        WowExpanded(),
        Chip(label: Text('test chip 1')),
        Chip(label: Text('test chip 2')),
        Chip(label: Text('test chip 3')),
        Chip(label: Text('test chip 4')),
        Chip(label: Text('test chip 5')),
        FlatButton(child: Text('button 1'), onPressed: (){}),
        FlatButton(child: Text('button 2'), onPressed: (){}),
        FlatButton(child: Text('button 2'), onPressed: (){}),
      ],
    );
  }
}