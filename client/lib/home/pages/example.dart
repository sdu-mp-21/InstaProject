import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<User> fetchUser() async {
  final response = await http.get(
    Uri.parse('http://localhost:5000/get/profile'),
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

  User(
      {required this.name,
      required this.surname,
      required this.site,
      required this.phoneNumber,
      required this.email,
      required this.aboutMe,
      required this.avatar,
      required this.userId,
      required this.login});

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
    );
  }
}

void main() {
  final PageController controller = PageController(initialPage: 1);
  runApp(
    MaterialApp(home: Gr()),
  );
}

class Gr extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * (1 / 3);
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            primary: false,
            crossAxisCount: 3,
            children: getPublications(imageWidth),
          ),
        ),
      ],
    );
  }
}

List<Widget> getPublications(double imageWidth) {
  List<Widget> result = [];
  for (int i = 0; i < 6; i++) {
    result.add(
      ButtonTheme(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minWidth: 0,
        height: 0,
        child: FlatButton(
          onPressed: () {
            print('open photo ${i}');
          },
          child: Container(
            width: imageWidth,
            height: imageWidth,
            child: Image.network(
              'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8cHJvZmlsZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
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

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  final TextEditingController _controller = TextEditingController();
  late Future<User> _futureUser;
  String name = '';
  int countPublications = 0;

  @override
  void initState() {
    super.initState();
    _futureUser = fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<User>(
            future: _futureUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  _futureUser.then((data) {
                    setState(() {
                      name = data.name;
                    });
                  });

                  return Text(name);
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
