import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Body extends StatefulWidget {
  Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ImagePicker picker = ImagePicker();
  String path = '';
  late var bytes;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(),
          FittedBox(
            child: TextButton(
              onPressed: () async {
                try {
                  final chooseFile =
                      await picker.pickImage(source: ImageSource.gallery);
                  bytes = await chooseFile!.readAsBytes();

                  setState(() {
                    path = chooseFile.path;
                  });
                } catch (_) {}
              },
              child: const Text(
                'Choose publication',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          const Spacer(),
          if (path != '') Image.network(path),
          if (path != '') const Spacer(),
          if (path != '')
            FittedBox(
              child: TextButton(
                onPressed: () async {
                  showDialog<String>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return showDialogLoading();
                      });

                  SharedPreferences sharedPrefs =
                      await SharedPreferences.getInstance();

                  Map data = {
                    'image': bytes,
                    'token': sharedPrefs.getString('token')
                  };
                  var body = json.encode(data);

                  var response = await http.post(
                    Uri.parse('http://localhost:5000/upload/publication'),
                    body: body,
                    headers: {
                      'Content-Type': 'application/json',
                    },
                  );
                  Navigator.pop(context);

                  if (response.statusCode == 201) {
                    setState(() {
                      path = '';
                    });

                    Fluttertoast.showToast(
                        msg: 'Publication uploaded successfully',
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM_LEFT,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  }
                },
                child: const Text(
                  'Upload',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          const Spacer()
        ],
      ),
    );
  }

  Widget showDialogLoading() {
    return const AlertDialog(
      title: Text("Uploading..."),
      content: SizedBox(
        width: 60,
        height: 60,
        child: SpinKitRing(
          color: Colors.blueAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
