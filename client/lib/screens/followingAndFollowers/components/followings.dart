import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/followingAndFollowers/components/card.dart';

class Followings extends StatelessWidget {
  List following = [];

  Followings(this.following, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: following.length,
          itemBuilder: (data, index) => FollowingCard(following[index])),
    );
  }
}
