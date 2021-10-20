import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Result> fetchResult(String query) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/search?token=${sharedPrefs.getString('token')}&q=$query'),
  );

  if (response.statusCode == 200) {
    return Result.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Result {
  // final int userId;
  // final String avatar;
  // final String name;
  // final String surname;
  // final String login;
  final List<dynamic> result;

  Result({required this.result});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
        // userId: json['userId'],
        // name: json['name'],
        // surname: json['surname'],
        // avatar: json['avatar'],
        // login: json['login'],
        result: json['result']);
  }
}

class Search extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StateSearch();
  }
}

class StateSearch extends State<Search> {
  late Future<Result> _futureResult;
  List<dynamic> result = [];

  @override
  void initState() {
    super.initState();

    _futureResult = fetchResult('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(59, 59, 59, 1.0),
            border: Border.all(color: Colors.black, width: 1.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              onChanged: (text) async {
                setState(() {
                  _futureResult = fetchResult(text);
                });
              },
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: const InputDecoration(
                hintText: 'Поиск',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        FutureBuilder(
          future: _futureResult,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                _futureResult.then((data) {
                  setState(() {
                    result = data.result;
                  });
                });

                return PrintResult(result);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            return const CircularProgressIndicator();
          },
        )
      ],
    ));
  }
}

class PrintResult extends StatelessWidget {
  List result = [];

  PrintResult(this.result);

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < result.length; i++) {
      list.add(Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.network(
                  result[i]['avatar'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        result[i]['login'],

                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Container(
                      child: Text(
                        result[i]['name'] + ' ' + result[i]['surname'],

                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                )),
          ],
        ),
      ));
    }

    return Expanded(
      child: ListView(children: list),
    );
  }
}

// class Search extends StatelessWidget {
//
//
//   TextEditingController searchController = TextEditingController();
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           color: const Color.fromRGBO(59, 59, 59, 1.0),
//           border: Border.all(color: Colors.black, width: 1.0),
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10),
//           child: TextField(
//             controller: searchController,
//             onChanged: (text) async {
//               Response response = await get(
//                 Uri.parse(
//                     'http://localhost:5000/search?q=$text'),
//               );
//
//               print(response.body);
//             },
//             style: const TextStyle(color: Colors.white, fontSize: 14),
//             decoration: const InputDecoration(
//               hintText: 'Логин',
//               hintStyle: TextStyle(color: Colors.grey),
//               border: InputBorder.none,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
