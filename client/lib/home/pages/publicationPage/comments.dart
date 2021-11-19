// ignore_for_file: must_be_immutable, deprecated_member_use, prefer_typing_uninitialized_variables, no_logic_in_create_state, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/home/pages/anotherProfile.dart';
import 'package:flutter_app/home/pages/profile.dart';
import 'package:flutter_app/home/pages/publicationPage/publication.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Comment extends StatefulWidget {
  int publicationId = 0;

  Comment(this.publicationId);

  @override
  State<StatefulWidget> createState() {
    return StateComment(publicationId);
  }
}

Future<CommentModel> fetchComments(int publicationId) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/get/comments?token=${sharedPrefs.getString('token')}&id=$publicationId'),
  );

  if (response.statusCode == 200) {
    return CommentModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class CommentModel {
  final List comments;

  CommentModel({required this.comments});

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(comments: json['comments']);
  }
}

class StateComment extends State<Comment> {
  late Future<CommentModel> futurePublications;
  List comments = [];
  int publicationId = 0;

  StateComment(this.publicationId);

  @override
  void initState() {
    super.initState();
    futurePublications = fetchComments(publicationId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromRGBO(0, 0, 0, 1.0),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder<CommentModel>(
          future: futurePublications,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                futurePublications.then((data) => {
                      setState(() {
                        comments = data.comments;
                      })
                    });

                return RenderComments(comments, publicationId);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  Widget getFooter() {
    return Row(
      children: [
        TextField(),
        FlatButton(
          onPressed: () {},
          child: Icon(
            Icons.send,
          ),
        ),
      ],
    );
  }
}

class RenderComments extends StatelessWidget {
  List comments = [];
  int publicationId = 0;

  RenderComments(this.comments, this.publicationId);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Publication(publicationId),
                      ),
                    );
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          Column(
            children: getComments(comments, context),
          ),
        ],
      ),
    );
  }

  List<Widget> getComments(List comments, BuildContext context) {
    List<Widget> listOfComments = [];

    for (int i = 0; i < comments.length; i++) {
      listOfComments.add(
        Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Row(
            children: [
              FlatButton(
                onPressed: () {
                  print(comments[i]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AnotherProfile(comments[i]['userId'])),
                  );
                },
                child: SizedBox(
                  width: 25,
                  height: 25,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                      90,
                    ),
                    child: Image.network(
                      comments[i]['avatar'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    comments[i]['text'],
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return listOfComments;
  }
}
