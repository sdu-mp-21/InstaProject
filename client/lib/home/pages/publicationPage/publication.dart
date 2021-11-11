// ignore_for_file: must_be_immutable, deprecated_member_use, prefer_typing_uninitialized_variables, no_logic_in_create_state, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../profile.dart';

class Publication extends StatefulWidget {
  var publicationId;

  Publication(this.publicationId);

  @override
  State<StatefulWidget> createState() {
    return StatePublication(publicationId);
  }
}

Future<PublicationModel> fetchPublication(var publicationId) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/get/publication?token=${sharedPrefs.getString('token')}&publicationId=$publicationId'),
  );

  if (response.statusCode == 200) {
    return PublicationModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class PublicationModel {
  final int publicationId;
  final int userId;
  final List likes;
  final List comments;
  final String description;
  final String src;
  final String login;
  final String avatar;
  final bool isLiked;

  PublicationModel({
    required this.publicationId,
    required this.userId,
    required this.likes,
    required this.comments,
    required this.description,
    required this.src,
    required this.login,
    required this.avatar,
    required this.isLiked,
  });

  factory PublicationModel.fromJson(Map<String, dynamic> json) {
    return PublicationModel(
      publicationId: json['publicationId'],
      userId: json['userId'],
      likes: json['likes'],
      comments: json['comments'],
      description: json['description'],
      login: json['login'],
      src: json['src'],
      avatar: json['avatar'],
      isLiked: json['isLiked'],
    );
  }
}

class StatePublication extends State<Publication> {
  late Future<PublicationModel> futurePublications;
  int publicationId = 0;
  int userId = 0;
  List likes = [];
  List comments = [];
  String description = '';
  String src = '';
  String login = '';
  String avatar = '';
  bool isLiked = false;

  StatePublication(this.publicationId);

  @override
  void initState() {
    super.initState();
    futurePublications = fetchPublication(publicationId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<PublicationModel>(
          future: futurePublications,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                futurePublications.then((data) => {
                      setState(() {
                        publicationId = data.publicationId;
                        userId = data.userId;
                        likes = data.likes;
                        comments = data.comments;
                        description = data.description;
                        src = data.src;
                        login = data.login;
                        avatar = data.avatar;
                        isLiked = data.isLiked;
                      })
                    });

                return RenderPublication(publicationId, userId, likes, comments,
                    description, src, login, avatar, isLiked);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class RenderPublication extends StatelessWidget {
  int publicationId = 0;
  int userId = 0;
  List likes = [];
  List comments = [];
  String description = '';
  String src = '';
  String login = '';
  String avatar = '';
  bool isLiked = false;

  RenderPublication(this.publicationId, this.userId, this.likes, this.comments,
      this.description, this.src, this.login, this.avatar, this.isLiked);

  @override
  Widget build(BuildContext context) {
    Icon likeIcon = Icon(
      isLiked ? Icons.favorite : Icons.favorite_border,
      size: 25.0,
      color: isLiked ? Colors.red : Colors.white,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: Row(
              children: [
                FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Profile(),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                  ),
                  child: const Text(
                    'Публикации',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 20,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        90,
                      ),
                      child: Image.network(
                        avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                    ),
                    child: Text(
                      login,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Image.network(
              src,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          // horizontal: 10,
                          ),
                      child: FlatButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () async {
                          SharedPreferences sharedPrefs =
                              await SharedPreferences.getInstance();

                          Map data = {'publicationId': publicationId};
                          var body = json.encode(data);
                          http.post(
                            Uri.parse(
                                'http://localhost:5000/like?token=${sharedPrefs.getString('token')}'),
                            body: body,
                            headers: {
                              'Content-Type': 'application/json',
                            },
                          );
                        },
                        child: likeIcon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        // horizontal: 10,
                      ),
                      child: FlatButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () async {

                        },
                        child: const Icon(
                          Icons.mode_comment_outlined,
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        // horizontal: 10,
                      ),
                      child: FlatButton(
                        padding: const EdgeInsets.all(0),
                        onPressed: () async {

                        },
                        child: const Icon(
                          Icons.send_outlined,
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.save,
                  size: 25.0,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
