import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/home/pages/config.dart';
import 'package:http/http.dart' as http;
import 'anotherProfile.dart';
import 'publicationPage/publication.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<FollowingModel> fetchFollowing() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(Uri.parse(
    'http://localhost:5000/get/following?token=${sharedPrefs.getString('token')}',
  ));

  if (response.statusCode == 200) {
    return FollowingModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load following');
  }
}

class FollowingModel {
  final List<dynamic> followings;

  FollowingModel({required this.followings});

  factory FollowingModel.fromJson(Map<String, dynamic> json) {
    return FollowingModel(followings: json['followings']);
  }
}

class Following extends StatefulWidget {
  int userId = 0;

  Following(this.userId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return StateFollowing(userId);
  }
}

class StateFollowing extends State<Following> {
  int userId = 0;

  StateFollowing(this.userId);

  late Future<FollowingModel> _futureUser;
  List data = [];

  @override
  void initState() {
    super.initState();
    _futureUser = fetchFollowing();
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
          child: FutureBuilder<FollowingModel>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _futureUser.then((res) {
                    setState(() {
                      data = res.followings;
                    });
                  });

                  return GenerateFollowing(data);
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

class GenerateFollowing extends StatelessWidget {
  List data = [];

  GenerateFollowing(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * (1 / 3);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: printItems(data, context),
      ),
    );
  }

  List<Widget> printItems(List items, BuildContext context) {
    List<Widget> result = [];

    for (int i = 0; i < items.length; i++) {
      result.add(getItem(
          items[i]['login'],
          items[i]['userId'],
          items[i]['avatar'],
          items[i]['name'] + ' ' + items[i]['surname'],
          context));
    }

    return result;
  }

  Widget getItem(String login, int userId, String avatar, String fullName, BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90),
              child: Image.network(
                avatar,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnotherProfile(userId),
                        ),
                      );
                    },
                    child: Text(
                      login,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      fullName,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
