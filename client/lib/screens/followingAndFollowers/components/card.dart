import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled/screens/profile/another_profile_screen.dart';

class FollowingCard extends StatelessWidget {
  var following;

  FollowingCard(this.following);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnotherProfileScreen(following['userId']),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.network(
                  following['avatar'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${following['login']}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  following['name'] + ' ' + following['surname'],
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
