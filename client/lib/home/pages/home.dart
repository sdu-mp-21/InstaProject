// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:instagram/home/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Result {
  // final int userId;
  // final String avatar;
  // final String name;
  // final String surname;
  // final String login;
  final List<dynamic> result;

  Result({required this.result});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      // userId: json['userId'],
      // name: json['name'],
      // surname: json['surname'],
      // avatar: json['avatar'],
      // login: json['login'],
        result: json['result']);
  }
}
class Home extends StatelessWidget {
  Future<Result> fetchResult(String query) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    final response = await http.get(
      Uri.parse(
          'http://localhost:5000/search?token=${sharedPrefs.getString('token')}&q=$query'),
    );

    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }
  final storyProfile = Expanded(
    child: ListView.builder(
      scrollDirection: Axis.horizontal,

      itemBuilder: (context,index)=>Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration:  const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image:NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1200px-Circle-icons-profile.svg.jpg'),
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
              child: Icon(Icons.add,size: 14.0,
                color: Colors.white,),
            ),
          ): Container()
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
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 12.0),
            child: Icon(Icons.send),
          )
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
              padding: const EdgeInsets.fromLTRB(16.0,16.0,8.0, 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40.0,width: 40.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1200px-Circle-icons-profile.svg.jpg')
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Text("Temporary",style: const TextStyle(fontWeight: FontWeight.bold,color:Colors.white),),
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
