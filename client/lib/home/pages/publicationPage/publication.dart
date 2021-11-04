import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../profile.dart';

class Publication extends StatefulWidget {
  var publicationId;

  Publication(var publicationId) {
    this.publicationId = publicationId;
  }

  @override
  State<StatefulWidget> createState() {
    return StatePublication(this.publicationId);
  }
}

Future<PublicationModel> fetchPublication(var publicationId) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/get/publication?token=${sharedPrefs.getString('token')}&publicationId=${publicationId}'),
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

  PublicationModel({
    required this.publicationId,
    required this.userId,
    required this.likes,
    required this.comments,
    required this.description,
    required this.src,
    required this.login,
    required this.avatar,
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

  StatePublication(var publicationId) {
    this.publicationId = publicationId;
  }

  @override
  void initState() {
    super.initState();
    futurePublications = fetchPublication(this.publicationId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0)),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          child: FutureBuilder<PublicationModel>(
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
                        })
                      });

                  return RenderPublicaion(
                    publicationId,
                    userId,
                    likes,
                    comments,
                    description,
                    src,
                    login,
                    avatar,
                  );
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
      ),
    );
  }
}

class RenderPublicaion extends StatelessWidget {
  int publicationId = 0;
  int userId = 0;
  List likes = [];
  List comments = [];
  String description = '';
  String src = '';
  String login = '';
  String avatar = '';

  RenderPublicaion(int publicationId, int userId, List likes, List comments,
      String description, String src, String login, String avatar) {
    this.publicationId = publicationId;
    this.userId = userId;
    this.likes = likes;
    this.comments = comments;
    this.description = description;
    this.src = src;
    this.login = login;
    this.avatar = avatar;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Profile()),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
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
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Row(
                children: [
                  SizedBox(
                    width: 25,
                    height: 25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Image.network(
                        avatar,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
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
                    children: const [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.favorite_border,
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.mode_comment_outlined,
                          size: 25.0,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.send_outlined,
                          size: 25.0,
                          color: Colors.white,
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
      ),
    );
  }
}
