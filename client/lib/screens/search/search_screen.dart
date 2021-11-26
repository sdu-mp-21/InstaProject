import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled/screens/search/models/Search.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchScreenState();
}

Future<SearchModel> fetchResult(String query) async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  final response = await http.get(
    Uri.parse(
        'http://localhost:5000/search?token=${sharedPrefs.getString('token')}&q=$query'),
  );

  if (response.statusCode == 200) {
    return SearchModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class SearchScreenState extends State<SearchScreen> {
  late Future<SearchModel> _futureResult;
  List<dynamic> result = [];

  @override
  void initState() {
    super.initState();

    _futureResult = fetchResult('');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(
          children: [
            Container(
              width: size.width - 30,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(59, 59, 59, 1.0),
                border: Border.all(color: Colors.black, width: 1.0),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextField(
                  onChanged: (text) async {
                    setState(() {
                      _futureResult = fetchResult(text);
                    });
                  },
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintText: 'Поиск',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
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
      list.add(
        Container(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
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
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) =>
                          //           AnotherProfile(result[i]['userId'])),
                          // );
                        },
                        child: Text(
                          result[i]['login'],
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
                          result[i]['name'] + ' ' + result[i]['surname'],
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
        ),
      );
    }

    return Expanded(
      child: ListView(children: list),
    );
  }
}