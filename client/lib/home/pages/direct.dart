import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'home.dart';


  class direct extends Home {
    String name="rakhat02";
    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home:Scaffold(
        appBar: AppBar(

          title:Text(name,),
          backgroundColor: Colors.black,
            actions: [
        // action button
        IconButton(
        icon: Icon( Icons.menu_open),
          onPressed: () { },
        ),
              IconButton(
                icon: Icon( Icons.edit),
                onPressed: () { },
              ),
          ],
          

        ),
          body: Container(
            child:
              const TextField(


                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Search',
                ),
              )
          ),
      ),
      );
    }
  }
