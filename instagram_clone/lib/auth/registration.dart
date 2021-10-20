import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:instagram_clone/home/homeElements.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

class Registration extends StatelessWidget {
  TextEditingController numberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repeatPasswordController = TextEditingController();
  TextEditingController loginController = TextEditingController();

  var database;

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
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
                  'Sign up',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(59, 59, 59, 1.0),
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                        controller: nameController,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Name',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(59, 59, 59, 1.0),
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                        controller: surnameController,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Surname',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(59, 59, 59, 1.0),
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                        controller: loginController,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Login',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(59, 59, 59, 1.0),
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(59, 59, 59, 1.0),
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                        controller: repeatPasswordController,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Repeat password',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        )),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(59, 59, 59, 1.0),
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TextField(
                        controller: numberController,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                        decoration: const InputDecoration(
                          hintText: 'Phone number',
                          hintStyle: TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                        )),
                  )),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 15, bottom: 15),
                child: Text(
                  'Instagram-Clone может отправлять вам SMS. Вы можете отказаться от них в любой момент.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13, color: Color.fromRGBO(100, 100, 100, 1.0)),
                )),
            Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(5.0)),
                width: double.infinity,
                child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
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
                                'http://localhost:5000/api/auth/registration?name=${nameController.text}&surname=${surnameController.text}&phone=${numberController.text}&login=${loginController.text}&password=${passwordController.text}&repeatPassword=${repeatPasswordController.text}'),
                            body: jsonEncode(<String, String>{
                              'title': 'title',
                            }),
                          );
                          Navigator.pop(context);
                          String toastMessage = '';
                          bool isSuccess = false;
                          try {
                            Map<String, dynamic> responseJson =
                                json.decode(response.body);

                            if (responseJson['token'] != null) {
                              toastMessage = 'Вы успешно зарегистрировались!';
                              isSuccess = true;
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setString('token', responseJson['token']);
                            } else {
                              toastMessage = responseJson['message'];
                            }
                          } catch (e) {
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
                        child: const Text('Next',
                            style: TextStyle(color: Colors.white))))),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
              child: FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Уже есть аккаунт? ',
                        style: TextStyle(color: Colors.grey)),
                    Text('Войдите.',
                        style: TextStyle(color: Colors.blueAccent)),
                  ],
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
              ),
            ),
          ],
        ),
      ),
    )));
  }
}

Widget showDialogLoading() {
  return AlertDialog(
      title: Text("Загрузка..."),
      content: Container(
        width: 60,
        height: 60,
        child: SpinKitRing(
          color: Colors.blueAccent,
          size: 50.0,
        ),
      ));
}
