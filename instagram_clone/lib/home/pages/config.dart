import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(onPressed: () {
        Navigator.of(context).pop(true);
      }, child: Text('Back', style: TextStyle(color: Colors.white)))
    );
  }
}