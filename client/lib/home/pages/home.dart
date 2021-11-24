// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'direct.dart';
//import 'package:instagram/home/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  

  final storyProfile = Expanded(
    child: ListView.builder(
      scrollDirection: Axis.horizontal,

      itemBuilder: (context, index) =>
          Stack(
            alignment: Alignment.topLeft,
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: NetworkImage(
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1200px-Circle-icons-profile.svg.jpg'),
                    fit: BoxFit.fill,
                  ),

                ),
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
              index == 0 ? const Positioned(
                right: 10.0,
                child: CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  radius: 10.0,
                  child: Icon(Icons.add, size: 14.0,
                    color: Colors.white,),
                ),
              ) : Container()
            ],
          ),
    ),
  );

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1.0,
        centerTitle: true,
        leading: Icon(Icons.camera_alt),
        title: const Text("Instagram"),
        actions:[
          // action button
          IconButton(
          icon: Icon( Icons.send ),
            onPressed: () {
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => direct() ),); },
      ),
      ],
          ),



      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            storyProfile,
            Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 16.0, 8.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0, width: 40.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1200px-Circle-icons-profile.svg.jpg')
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text("Temporary", style: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                  const IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: null,
                  )
                ],
              ),
            ),
          ],
        ),
      ),);
  }
}
