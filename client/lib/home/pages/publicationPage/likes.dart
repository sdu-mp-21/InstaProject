import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<Likes> fetchLikes() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/get/profile?token=${sharedPrefs.getString('token')}'),
  );

  if (response.statusCode == 200) {
    return Likes.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Likes {
  final List users;

  Likes({required this.users});

  factory Likes.fromJson(Map<String, dynamic> json) {
    return Likes(
      users: json['userId'],
    );
  }
}

class Like extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateLike();
  }
}

class StateLike extends State<Like> {
  late Future<Likes> futureLikes;
  List users = [];

  @override
  void initState() {
    super.initState();
    futureLikes = fetchLikes();
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
          child: FutureBuilder<Likes>(
            future: futureLikes,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  futureLikes.then((data) {
                    setState(() {
                      print(data.users);
                    });
                  });

                  // return GenerateProfile(
                  //     name, surname, aboutMe, avatar, publications);
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
