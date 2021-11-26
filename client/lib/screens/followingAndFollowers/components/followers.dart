import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/followingAndFollowers/components/card.dart';

class Followers extends StatelessWidget {
  List followers = [];

  Followers(this.followers, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (data, index) => FollowingCard(followers[index])
      ),
    );
  }
}
