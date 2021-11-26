import 'package:flutter/material.dart';
import 'package:untitled/screens/add/add_screen.dart';
import 'package:untitled/screens/feed/feed_screen.dart';
import 'package:untitled/screens/profile/profile_screen.dart';
import 'package:untitled/screens/search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      child: const MyPages(),
    ));
  }
}

class MyPages extends StatefulWidget {
  const MyPages({Key? key}) : super(key: key);

  @override
  MyPagesState createState() => MyPagesState();
}

class MyPagesState extends State<MyPages> {
  int selectedIndex = 3;
  final List<Widget> widgetOptions = <Widget>[
    const FeedScreen(),
    SearchScreen(),
    const AddScreen(),
    const ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              activeIcon: Icon(
                Icons.home,
                color: Colors.grey,
              ),
              label: 'Feed',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: Colors.white),
              activeIcon: Icon(Icons.search, color: Colors.grey),
              label: 'Search',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, color: Colors.white),
              activeIcon: Icon(Icons.add_box_outlined, color: Colors.grey),
              label: 'Add',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, color: Colors.white),
              activeIcon: Icon(Icons.account_circle, color: Colors.grey),
              label: 'Profile',
              backgroundColor: Colors.black),
        ],
        selectedItemColor: Colors.grey,
        unselectedItemColor: Colors.white,
        onTap: onItemTapped,
        currentIndex: selectedIndex,
      ),
    );
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}
