import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1.0,
        centerTitle: true,
        leading: Icon(Icons.camera_alt),
        title: const Text("Instagram"),
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.send),
          )
        ],
    ),);
  }
}
