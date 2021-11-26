import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Direct extends StatefulWidget {
  @override
  _DirectState createState() => _DirectState();
}

Future fetch() async {
  SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

  // final response = await http.get(
  //   Uri.parse(
  //       'http://localhost:5000/get/publications?token=${sharedPrefs.getString('token')}'),
  // );
}

class _DirectState extends State<Direct> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "login",
          style: TextStyle(fontSize: 24.0, fontFamily: 'Arial'),
        ),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(
                Icons.videocam,
                size: 26.0,
              ),
              onPressed: () {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(
                Icons.message,
                size: 26.0,
              ),
              onPressed: () {},
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: "Все",
            ),
            Tab(
              text: "Звонки",
            ),
            Tab(
              text: "Запросы",
            )
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                child: TextField(
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: 'Поиск',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                      filled: true,
                      fillColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )),
                ),
              ),
              Card(
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Container(
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
                      title: const Text(
                        "login",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "message of user",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.videocam, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Card(
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Container(
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
                      title: const Text(
                        "login",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "message of user",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.videocam, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              Card(
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: Container(
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
                      title: const Text(
                        "login",
                        style: TextStyle(color: Colors.white),
                      ),
                      subtitle: const Text(
                        "message of user",
                        style: TextStyle(color: Colors.white),
                      ),
                      trailing: const IconButton(
                          onPressed: null,
                          icon: Icon(Icons.videocam, color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Center(
              child: Text(
            "Calls",
            style: TextStyle(color: Colors.white),
          )),
          const Center(
            child: Text(
              "Responces",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
