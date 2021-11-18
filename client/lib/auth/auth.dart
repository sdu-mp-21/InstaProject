import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './login.dart';
import '../home/homeElements.dart';
import './registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth extends StatelessWidget {
  String TOKEN = '';

  SharedPreferences? sharedPrefs = null;

  Future<void> getPrefs() async {
    sharedPrefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    if (TOKEN == '') {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Registration(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      right: 20,
                      left: 20,
                    ),
                    child: Text(
                      'Создать аккаунт',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  minWidth: double.infinity - 30,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Login(),
                      ),
                    );
                  },
                  child: const Padding(
                      padding: EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                      ),
                      child: Text(
                        'Войти',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                )
              ],
            ),
          ],
        ),
      );
    } else {
      return HomeElements();
    }
  }
}
