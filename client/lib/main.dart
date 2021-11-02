import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home/homeElements.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool isAuthenticate = false;

  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
  if (sharedPrefs.getString('token') != null) {
    Response response = await post(Uri.parse(
        'http://localhost:5000/api/auth/check/token?token=${sharedPrefs.getString('token')}'));

    if (response.statusCode == 200) {
      Map<String, dynamic> responseJson = json.decode(response.body);
      if (responseJson['isValid']) {
        isAuthenticate = true;
      }
    }
  }

  if (isAuthenticate) {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0)),
      home: HomeElements(),
    ));
  } else {
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0)),
      home: Auth(),
    ));
  }
}