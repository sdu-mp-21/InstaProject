import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '/home/pages/config.dart';
import 'package:http/http.dart' as http;
import 'publicationPage/publication.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Following> fetchFollowing(int userId) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/get/another/profile?token=${sharedPrefs.getString('token')}&id=$userId'),
  );

  if (response.statusCode == 200) {
    return Following.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Following {
  final List<dynamic> data;

  Following({required this.data});

  factory Following.fromJson(Map<String, dynamic> json) {
    return Following(data: json['data']);
  }
}

class AnotherProfile extends StatefulWidget {
  int userId = 0;

  AnotherProfile(this.userId);

  @override
  State<StatefulWidget> createState() {
    return StateProfile(userId);
  }
}

class StateProfile extends State<AnotherProfile> {
  int userId = 0;

  StateProfile(this.userId);

  late Future<Following> _futureUser;
  List data = [];

  @override
  void initState() {
    super.initState();
    _futureUser = fetchFollowing(userId);
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
          child: FutureBuilder<Following>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _futureUser.then((res) {
                    setState(() {
                      data = res.data;
                    });
                  });

                  return GenerateProfile(data);
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
  List data = [];

  GenerateProfile(this.data);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * (1 / 3);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [

        ],
      ),
    );
  }
}
