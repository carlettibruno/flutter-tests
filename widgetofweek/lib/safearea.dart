import 'package:flutter/material.dart';

class WowSafeArea extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text('Testing Safe Area'),
      right: true,
      bottom: true,
    );
  }
}