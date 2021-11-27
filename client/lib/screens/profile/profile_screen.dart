import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/profile/components/body.dart';
import 'package:untitled/screens/profile/models/User.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StateProfile();
  }
}

Future<User> fetchUser() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/get/profile?token=${sharedPrefs.getString('token')}'),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class StateProfile extends State<ProfileScreen> {
  late Future<User> _futureUser;

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(_futureUser, true),
    );
  }
}
