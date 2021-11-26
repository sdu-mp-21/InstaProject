import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/config/config_screen.dart';
import 'package:untitled/screens/followingAndFollowers/following_and_followers_screen.dart';
import 'package:untitled/screens/profile/components/publication_card.dart';
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
  String name = '';
  String surname = '';
  String aboutMe = '';
  String avatar = '';
  String login = '';
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
                  _futureUser.then(
                    (data) {
                      setState(
                        () {
                          name = data.name;
                          surname = data.surname;
                          aboutMe = data.aboutMe;
                          avatar = data.avatar;
                          publications = data.publications;
                          countSubscribers = data.subscribers;
                          countSubscriptions = data.subscriptions;
                          login = data.login;
                        },
                      );
                    },
                  );

                  return GenerateProfile(name, surname, aboutMe, avatar,
                      publications, countSubscribers, countSubscriptions,login);
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
  String login = '';
  List publications = [];
  List subscribers = [];
  List subscriptions = [];

  GenerateProfile(this.name, this.surname, this.aboutMe, this.avatar,
      this.publications, this.subscribers, this.subscriptions, this.login,
      {Key? key})
      : super(key: key);

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
                    Row(
                      children: [
                        // Posts button
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                publications.length.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const Text(
                                'Posts',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        // Followers button
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FollowingAndFollowersScreen(login, 0),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  subscribers.length.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Text(
                                  'Followers',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
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
                                  builder: (context) => FollowingAndFollowersScreen(login, 1),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  subscriptions.length.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Text(
                                  'Following',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
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
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfigScreen()),
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
      PublicationCard(
        imageWidth: imageWidth,
        id: publicationId,
        link: link,
      ),
    );
  }

  return result;
}
