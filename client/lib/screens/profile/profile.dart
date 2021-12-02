 // ignore_for_file: use_key_in_widget_constructors, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/home/pages/config.dart';
import './following.dart';
import 'package:http/http.dart' as http;
import 'publicationPage/publication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'publicationPage/setting.dart';

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
  final List subscriptions;
  final List subscribers;

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
      required this.publications,
      required this.subscriptions,
      required this.subscribers});

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
      subscriptions: json['subscriptions'],
      subscribers: json['subscribers'],
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
        scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      ),
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
                      countSubscribers = data.subscribers;
                      countSubscriptions = data.subscriptions;
                    });
                  });

                  return GenerateProfile(name, surname, aboutMe, avatar,
                      publications, countSubscribers, countSubscriptions);
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

  GenerateProfile(this.name, this.surname, this.aboutMe, this.avatar,
      this.publications, this.subscribers, this.subscriptions);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * (1 / 3);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('login'),

        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon:Icon(
          Icons.list
      ),
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                context: context,
                builder: (context) {
                  return Container(
                    color: Colors.grey[920],
                    height: 1000,
                    child: Column(
                      children: [
                        ListTile(
                          leading: Icon(Icons.settings),
                          title: Text('Settings'),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Settings()),
                              );
                            }
                        ),
                        ListTile(
                          leading: Icon(Icons.archive),
                          title: Text('Archive'),
                        ),
                        ListTile(
                          leading: Icon(Icons.timelapse),
                          title: Text('Your activity'),
                        ),
                        ListTile(
                          leading: Icon(Icons.insights),
                          title: Text('Insights'),
                        ),
                        ListTile(
                          leading: Icon(Icons.qr_code),
                          title: Text('QR Code'),
                        ),
                        ListTile(
                          leading: Icon(Icons.save),
                          title: Text('Saved'),
                        ),

                        ListTile(
                          leading: Icon(Icons.person_add),
                          title: Text('Discover People'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
    ),
  ],
      ),



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
                            onPressed: () {},
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Following(0)),
                              );
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
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    aboutMe,
                    style: const TextStyle(color: Colors.white),
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
    var publicationId = 0;
    publications[i].forEach((key, value) {
      if (key == 'src') {
        link = value;
      } else if (key == 'publicationId') {
        publicationId = value;
      }
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
              MaterialPageRoute(
                  builder: (context) => Publication(publicationId)),
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
