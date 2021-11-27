import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FollowBtn extends StatefulWidget {
  int userId;

  FollowBtn(this.userId, {Key? key}) : super(key: key);

  @override
  FollowBtnState createState() {
    print(userId);
    return FollowBtnState(userId);
  }
}

class FollowBtnState extends State<FollowBtn> {
  Color backgroundColorBtn = Colors.blue;
  String text = 'Follow';

  int userId;

  FollowBtnState(this.userId);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: backgroundColorBtn,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Colors.white),
      ),
      child: TextButton(
        onPressed: () async {
          bool isSubscribe = await followOrUnfollow(userId);

          setState(() {
            if (isSubscribe) {
              backgroundColorBtn = Colors.black;
              text = 'Unfollow';
            } else {
              backgroundColorBtn = Colors.blue;
              text = 'Follow';
            }
          });
        },
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Future followOrUnfollow(int id) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      final token = sharedPreferences.getString('token');

      Map data = {'id': id, 'token': token};
      var body = json.encode(data);

      final response = await http.post(
        Uri.parse('http://localhost:5000/follow/'),
        body: body,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final result = jsonDecode(response.body);

      return result['isSubscribe'];
    } catch (_) {
      return false;
    }
  }
}
