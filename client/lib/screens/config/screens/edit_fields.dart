import 'package:flutter/material.dart';


// Define a custom Form widget.
class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<NextPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Name', style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);

            },
            child: Text('Done'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:

        TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.grey),
            hintText: "Enter your name",
          ),
          controller: myController,
        ),
      ),

    );
  }
}