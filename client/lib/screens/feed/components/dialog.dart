import 'package:flutter/material.dart';

class Dialog extends StatefulWidget {
  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<Dialog> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar:
    AppBar(title: Text("Dialog"),),
      body: SingleChildScrollView(
      child: Column(children: <Widget>[
      Text("dialog", style: TextStyle(color: Colors.black, fontSize: 26.0),)],
    )
    ,
    )
    ,
    );
  }
}
