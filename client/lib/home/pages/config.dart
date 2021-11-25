import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editfields.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Config extends StatefulWidget {
  const Config({Key? key}) : super(key: key);

  @override
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {
  final myController = TextEditingController();

  get http => null;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
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
            CircleAvatar(
              backgroundImage: AssetImage('assets/IMG_5026.JPG'),
              radius: 50,
            ),
    TextButton(
    onPressed: () async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
    Uint8List? fileBytes = result.files.first.bytes;

    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();

    Map data = {
    'image': fileBytes,
    'token': sharedPrefs.getString('token')
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(
    Uri.parse('http://localhost:5000/upload/publication'),
    body: body,
    headers: {
    'Content-Type': 'application/json',
    },
    );
    }
    },
    child: const Text(
    'Change Profile Photo',
    style: TextStyle(color: Colors.blue),
    ),
    ),


            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: new Padding(
                padding: new EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 20,
                      height: 20,
                    ),
                    Text(
                      myController.text,
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
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: new Padding(
                padding: new EdgeInsets.all(15.0),
                child: Row(
                  children: [
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
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: new Padding(
                padding: new EdgeInsets.all(15.0),
                child: Row(
                  children: [
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
                  MaterialPageRoute(builder: (context) => NextPage()),
                );
              },
              child: new Padding(
                padding: new EdgeInsets.all(15.0),
                child: Row(
                  children: [
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




