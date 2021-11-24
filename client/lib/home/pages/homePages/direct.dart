// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

class Direct extends StatefulWidget {
  @override
  _DirectState createState() => _DirectState();
}

Future fetch() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/get/publications?token=${sharedPrefs.getString(
            'token')}'),
  );
  print(response.body);
}

class _DirectState extends State<Direct> {
  @override
  Widget build(BuildContext context) {
    fetch();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "login",
          style: TextStyle(fontSize: 24.0, fontFamily: 'Arial'),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.videocam,
              size: 26.0,),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.message,
              size: 26.0,),
          ),
        ],
      ),
      body: SingleChildScrollView(child: Column(
        children:[ Row(
          children: [
            Text("Все",style: TextStyle(color: Colors.white),),
            Text("Звонки",style: TextStyle(color: Colors.white),),
            Text("Запросы",style: TextStyle(color: Colors.white),),
          ],
        ),
      ],
    )
    ),

    );
  }
}
