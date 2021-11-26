import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/config/screens/edit_fields.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ConfigScreenState();
}

class ConfigScreenState extends State<ConfigScreen> {
  final myController = TextEditingController();

  get http => null;

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text('Done'),
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/IMG_5026.JPG'),
              radius: 50,
            ),
            TextButton(
              onPressed: () async {},
              child: const Text(
                'Change Profile Photo',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NextPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    const Text(
                      'Name',
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      myController.text,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NextPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Text(
                      'Username',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      'Maha02',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NextPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Text(
                      'Website',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Text(' '),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NextPage()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: const [
                    Text(
                      'Bio',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      ' ',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // TextButton(onPressed: () {
      //   Navigator.of(context).pop(true);
      // }, child: Text('Back', style: TextStyle(color: Colors.white)))
    );
  }
}
