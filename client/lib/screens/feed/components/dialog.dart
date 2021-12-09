import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

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
        leading: IconButton(icon: Icon(Icons.chevron_left), onPressed: () { Navigator.pop(context); },),
        backgroundColor: Colors.black,
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage:
              AssetImage("lib/screens/feed/components/Tokaev.jpg"),
            ),
            SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "login",
                  style: TextStyle(fontSize: 16.0),
                ),
                Text(
                  "Active 3m ago",
                  style: TextStyle(fontSize: 12.0),
                )
              ],
            )
          ],
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.add_call,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              Icons.videocam,
              color: Colors.white,
            ),
          ),
        ],

    ),
    );
  }
}
