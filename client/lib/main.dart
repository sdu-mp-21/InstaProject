import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/home/home_screen.dart';
import 'package:untitled/screens/logInOrSignUp/login_or_sign_up_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print('trying');
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e);
    print('error in connected to firebase');
  }
  print('initialized');

  bool isAuthenticate = false;
  try {
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
  } catch (_) {}

  if (isAuthenticate) {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
        ),
        home: const HomeScreen(),
      ),
    );
  } else {
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
        ),
        home: const LogInOrSignUpScreen(),
      ),
    );
  }
}
