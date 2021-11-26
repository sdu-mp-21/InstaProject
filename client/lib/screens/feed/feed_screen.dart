import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/screens/feed/components/direct.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => FeedScreenState();
}

class FeedScreenState extends State<FeedScreen> {

  Future fetch() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final response = await http.get(Uri.parse(
        'http://localhost:5000/get/publications?token=${sharedPreferences.getString('token')}'));
  }

  final storyProfile = Expanded(
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => Stack(
        alignment: Alignment.topLeft,
        children: [
          Container(
            width: 60.0,
            height: 60.0,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Circle-icons-profile.svg/1200px-Circle-icons-profile.svg.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
          ),
          index == 0
              ? const Positioned(
            right: 10.0,
            child: CircleAvatar(
              backgroundColor: Colors.blueAccent,
              radius: 10.0,
              child: Icon(
                Icons.add,
                size: 14.0,
                color: Colors.white,
              ),
            ),
          )
              : Container()
        ],
      ),
    ),
  );

  Widget build(BuildContext context) {
    fetch();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 1.0,
        centerTitle: true,
        leading:GestureDetector(onTap: (){} ,child:Icon(Icons.camera_alt)),
        title: const Text("Instagram"),
        actions: [
          // action button
          IconButton(
              icon: Icon(Icons.send),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft, child: Direct()));
              })
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            storyProfile,
          ],
        ),
      ),
    );
  }
}