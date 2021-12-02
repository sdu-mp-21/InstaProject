import 'package:flutter/material.dart';

class DialogScreen extends StatefulWidget {
  const DialogScreen({Key? key}) : super(key: key);

  @override
  _DialogState createState() => _DialogState();
}

class _DialogState extends State<DialogScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dialog"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const <Widget>[
            Text(
              "dialog",
              style: TextStyle(color: Colors.black, fontSize: 26.0),
            )
          ],
        ),
      ),
    );
  }
}
