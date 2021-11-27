import 'package:flutter/material.dart';
import 'package:untitled/screens/config/config_screen.dart';
import 'package:untitled/screens/followingAndFollowers/following_and_followers_screen.dart';
import 'package:untitled/screens/profile/components/follow_btn.dart';
import 'package:untitled/screens/profile/components/publication_card.dart';

import 'package:untitled/screens/profile/models/User.dart';

class Body extends StatefulWidget {
  late Future<User> _futureUser;
  bool isMyProfile;

  Body(this._futureUser, this.isMyProfile, {Key? key}) : super(key: key);

  @override
  BodyState createState() => BodyState(_futureUser, isMyProfile);
}

class BodyState extends State<Body> {
  late Future<User> _futureUser;
  String name = '';
  String surname = '';
  String aboutMe = '';
  String avatar = '';
  String login = '';
  late int userId;
  List publications = [];
  List countSubscribers = [];
  List countSubscriptions = [];
  bool isMyProfile;

  BodyState(this._futureUser, this.isMyProfile);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder<User>(
          future: _futureUser,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                _futureUser.then(
                  (data) {
                    setState(
                      () {
                        name = data.name;
                        surname = data.surname;
                        aboutMe = data.aboutMe;
                        avatar = data.avatar;
                        publications = data.publications;
                        countSubscribers = data.subscribers;
                        countSubscriptions = data.subscriptions;
                        login = data.login;
                        userId = data.userId;
                      },
                    );
                  },
                );

                return GenerateProfile(
                    name,
                    surname,
                    aboutMe,
                    avatar,
                    publications,
                    countSubscribers,
                    countSubscriptions,
                    login,
                    isMyProfile,
                    userId);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }

            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class GenerateProfile extends StatelessWidget {
  String name = '';
  String surname = '';
  String aboutMe = '';
  String avatar = '';
  String login = '';
  int userId = 0;
  List publications = [];
  List subscribers = [];
  List subscriptions = [];
  bool isMyProfile;

  GenerateProfile(
      this.name,
      this.surname,
      this.aboutMe,
      this.avatar,
      this.publications,
      this.subscribers,
      this.subscriptions,
      this.login,
      this.isMyProfile,
      this.userId,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.of(context).size.width * (1 / 3);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          if (!isMyProfile)
            SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    ),
                    color: Colors.white,
                  ),
                  const Spacer(),
                  Text(
                    login,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 75,
                      height: 75,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(90),
                        child: Image.network(
                          avatar,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        // Posts button
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                publications.length.toString(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const Text(
                                'Posts',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        // Followers button
                        Container(
                          padding: const EdgeInsets.only(left: 20),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FollowingAndFollowersScreen(
                                          login, 0, userId),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  subscribers.length.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Text(
                                  'Followers',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Following button
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FollowingAndFollowersScreen(
                                          login, 1, userId),
                                ),
                              );
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  subscriptions.length.toString(),
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                                const Text(
                                  'Following',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    name + ' ' + surname,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    aboutMe,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                if (isMyProfile)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ConfigScreen()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text('Edit Profile',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                if (!isMyProfile) FollowBtn(userId)
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              crossAxisCount: 3,
              children: getPublications(imageWidth, publications, context),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> getPublications(double imageWidth, List publications, context) {
  List<Widget> result = [];
  for (int i = 0; i < publications.length; i++) {
    String link = '';
    var publicationId = 0;
    publications[i].forEach((key, value) {
      if (key == 'src') {
        link = value;
      } else if (key == 'publicationId') {
        publicationId = value;
      }
    });

    result.add(
      PublicationCard(
        imageWidth: imageWidth,
        id: publicationId,
        link: link,
      ),
    );
  }

  return result;
}
