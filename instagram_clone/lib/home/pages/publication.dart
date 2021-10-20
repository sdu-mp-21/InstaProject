import 'package:flutter/material.dart';

class Publication extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StatePublication();
  }
}

class StatePublication extends State<Publication> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(100),
      child: const CircularProgressIndicator(),
    );
  }
}
