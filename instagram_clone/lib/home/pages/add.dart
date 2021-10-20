import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Add extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextButton(
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
        'Upload photo',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}