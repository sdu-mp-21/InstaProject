// ignore_for_file: no_logic_in_create_state
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/profile/components/body.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/profile/models/User.dart';

class AnotherProfileScreen extends StatefulWidget {
  int userId = 0;

  AnotherProfileScreen(this.userId, {Key? key}) : super(key: key);

  @override
  AnotherProfileState createState() => AnotherProfileState(userId);
}

Future<User> fetchUser(int id) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/get/another/profile?token=${sharedPrefs.getString('token')}&id=$id'),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class AnotherProfileState extends State<AnotherProfileScreen> {
  late Future<User> _futureUser;
  int userId = 0;

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser(userId);
  }

  AnotherProfileState(this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(_futureUser, false),
    );
  }
}
