// ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:instagram_clone/home/pages/config.dart';
import 'package:http/http.dart' as http;
import 'package:instagram_clone/home/pages/publication.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<User> fetchUser() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse('http://localhost:5000/get/profile?token=${sharedPrefs.getString('token')}'),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class User {
  final int userId;
  final String login;
  final String name;
  final String surname;
  final String site;
  final String phoneNumber;
  final String email;
  final String aboutMe;
  final String avatar;
  final List publications;

  User(
      {required this.name,
      required this.surname,
      required this.site,
      required this.phoneNumber,
      required this.email,
      required this.aboutMe,
      required this.avatar,
      required this.userId,
      required this.login,
      required this.publications});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      surname: json['surname'],
      site: json['site'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      aboutMe: json['aboutMe'],
      avatar: json['avatar'],
      login: json['login'],
      publications: json['publications'],
    );
  }
}

class Profile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateProfile();
  }
}

class StateProfile extends State<Profile> {
  late Future<User> _futureUser;
  String name = '';
  String surname = '';
  String aboutMe = '';
  String avatar = '';
  List publications = [];
  List countSubscribers = [];
  List countSubscriptions = [];

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: FutureBuilder<User>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _futureUser.then((data) {
                    setState(() {
                      name = data.name;
                      surname = data.surname;
                      aboutMe = data.aboutMe;
                      avatar = data.avatar;
                      publications = data.publications;
                      countSubscribers = [];
                      countSubscriptions = [];
                    });
                  });

                  return GenerateProfile(
                      name, surname, aboutMe, avatar, publications);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}

class GenerateProfile extends StatelessWidget {
  String name = '';
  String surname = '';
  String aboutMe = '';
  String avatar = '';
  List publications = [];
  List subscribers = [];
  List subscriptions = [];

  GenerateProfile(
      this.name, this.surname, this.aboutMe, this.avatar, this.publications);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * (1 / 3);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Avatar icon
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.network(
                          avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    // Posts, Followers, Followings
                    Row(
                      children: [
                        // Posts button
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(publications.length.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              const Text('Posts',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14))
                            ],
                          ),
                        ),
                        // Followers button
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextButton(
                            onPressed: () {
                              print('open page followers');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(subscribers.length.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                const Text('Followers',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14))
                              ],
                            ),
                          ),
                        ),
                        // Following button
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: TextButton(
                            onPressed: () {
                              print('open page following');
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(subscriptions.length.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16)),
                                const Text('Following',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14))
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name + ' ' + surname,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    // textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    aboutMe,
                    style: const TextStyle(color: Colors.white),
                    // textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.white),
                  ),
                  // ignore: deprecated_member_use
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Config()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: const Text('Edit Profile',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              crossAxisCount: 3,
              children: getPublications(imageWidth, publications, context),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> getPublications(double imageWidth, List publications, context) {
  List<Widget> result = [];
  for (int i = 0; i < publications.length; i++) {
    String link = '';
    publications[i].forEach((key, value) {
      link = value;
    });
    result.add(
      ButtonTheme(
        padding: const EdgeInsets.all(0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: 0,
        height: 0,
        child: FlatButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Publication()),
            );
          },
          child: SizedBox(
            width: imageWidth,
            height: imageWidth,
            child: Image.network(
              link,
              width: imageWidth,
              height: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  return result;
}
