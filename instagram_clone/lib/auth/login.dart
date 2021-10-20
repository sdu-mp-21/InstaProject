import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:instagram_clone/auth/registration.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/home/homeElements.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Login extends StatelessWidget {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var database;

  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 30),
                            child: Text(
                              'Авторизация',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                              ),
                            )),
                        Container(
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(59, 59, 59, 1.0),
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(5.0)),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: TextField(
                                  controller: loginController,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                  decoration: const InputDecoration(
                                    hintText: 'Логин',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                  )),
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(59, 59, 59, 1.0),
                                  border: Border.all(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: TextField(
                                    controller: passwordController,
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                    decoration: const InputDecoration(
                                      hintText: 'Пароль',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      border: InputBorder.none,
                                    )),
                              )),
                        ),
                        Container(
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(5.0)),
                            width: double.infinity,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: FlatButton(
                                    onPressed: () async {
                                      showDialog<String>(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return showDialogLoading();
                                          });

                                      Response response = await post(
                                        Uri.parse(
                                            'http://localhost:5000/api/auth/login?login=${loginController.text}&password=${passwordController.text}'),
                                        body: jsonEncode(<String, String>{
                                          'title': 'title',
                                        }),
                                      );
                                      Navigator.pop(context);

                                      String toastMessage = '';
                                      bool isSuccess = false;
                                      try {
                                        Map<String, dynamic> responseJson = json.decode(response.body);

                                        if (responseJson['token'] != null) {
                                          toastMessage = 'Вы успешно авторизовались!';
                                          isSuccess = true;
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          await prefs.setString('token', responseJson['token']);
                                        } else {
                                          toastMessage = responseJson['message'];
                                        }
                                      } catch(e) {
                                        toastMessage = response.body;
                                      }

                                      Fluttertoast.showToast(
                                          msg: toastMessage,
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM_LEFT,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.grey,
                                          textColor: Colors.white,
                                          fontSize: 16.0);

                                      if (isSuccess) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => HomeElements()),
                                        );
                                      }
                                    },
                                    child: const Text('Далее',
                                        style:
                                            TextStyle(color: Colors.white))))),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, top: 20),
                          child: FlatButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text('У вас ещё нет аккаунта? ',
                                    style: TextStyle(color: Colors.grey)),
                                Text('Зарегистрируйтесь.',
                                    style: TextStyle(color: Colors.blueAccent)),
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Registration()));
                            },
                          ),
                        ),
                      ]),
                ))));
  }
}
