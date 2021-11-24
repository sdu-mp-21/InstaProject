// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'pages/addPublication/add.dart';
import '/home/pages/profile.dart';
import '/home/pages/search.dart';
import 'pages/homePages/home.dart';

class HomeElements extends StatelessWidget {
  Widget build(BuildContext context) {
    print('home');
    return Scaffold(
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                ),
              ],
            ),
            child: MyPages())
        );
  }
}

class MyPages extends StatefulWidget {
  MyPagesState createState() => MyPagesState();
}

class MyPagesState extends State<MyPages> {
  int _selectedIndex = 3;
  final List<Widget> _widgetOptions = <Widget>[
    Home(),
    Search(),
    Add(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, color: Colors.white,),
              activeIcon: Icon(Icons.home, color: Colors.grey,),
              label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white),
              activeIcon: Icon(Icons.search, color: Colors.grey),
              label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, color: Colors.white),
              activeIcon: Icon(Icons.add_box_outlined, color: Colors.grey),
              label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.white),
              activeIcon: Icon(Icons.account_circle, color: Colors.grey),
              label: '',
              backgroundColor: Colors.black),
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
