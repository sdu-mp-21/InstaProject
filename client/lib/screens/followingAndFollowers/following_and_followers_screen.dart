import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/followingAndFollowers/components/followers.dart';
import 'package:untitled/screens/followingAndFollowers/components/followings.dart';
import 'package:untitled/screens/followingAndFollowers/models/Followers.dart';
import 'package:http/http.dart' as http;

class FollowingAndFollowersScreen extends StatefulWidget {
  String login = '';
  int index = 0;

  FollowingAndFollowersScreen(this.login, this.index, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      FollowingAndFollowersState(login, index);
}

Future<FollowersModel> fetchData() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString('token');

  // eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOjcwODczNzc3NzM3LCJpYXQiOjE2Mzc5NjQyODUsImV4cCI6MTYzNzk4NTg4NX0.5QqUTZZL5xEtIWxd_bcpEgTBEquTcOKX0kGaxtbLSRI

  final response = await http
      .get(Uri.parse('http://localhost:5000/get/followers?token=$token'));

  if (response.statusCode == 200) {
    return FollowersModel.fromJson(jsonDecode(response.body));
  } else {
    return FollowersModel(followers: [], following: []);
  }
}

class FollowingAndFollowersState extends State<FollowingAndFollowersScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  late Future<FollowersModel> futureFollowers;

  List followers = [];
  List following = [];

  String login = '';
  int index = 0;

  FollowingAndFollowersState(this.login, this.index);

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: index);

    futureFollowers = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<FollowersModel>(
          future: futureFollowers,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                futureFollowers.then(
                  (data) {
                    setState(
                      () {
                        following = data.following;
                        followers = data.followers;
                      },
                    );
                  },
                );

                return Scaffold(
                  appBar: buildAppBar(
                      tabController, followers.length, following.length),
                  body: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      Column(
                        children: [
                          Followers(followers),
                        ],
                      ),
                      Column(
                        children: [
                          Followings(following),
                        ],
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(
      TabController _tabController, int followers, int following) {
    return AppBar(
      backgroundColor: Colors.black,
      title: SizedBox(
        width: double.infinity,
        child: Text(
          login,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        tabs: <Widget>[
          Tab(
            text: '$followers Followers',
          ),
          Tab(
            text: '$following Following',
          ),
        ],
      ),
    );
  }
}
