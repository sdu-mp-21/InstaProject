import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Market extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Магазин',style:TextStyle(color: Colors.black)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.bookmark_add),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Bookmarks'),
                    ),
                    body: const Center(
                      child: Text(
                        'Your items',
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                  );
                },
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.apps),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('need to detail')));
            },
          ),
        ],
      ),
      body:
           Container(
             margin: const EdgeInsets.all(10.0),
             child: const Align(alignment: Alignment.topCenter,
              child:TextField(
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(border: OutlineInputBorder(),
            fillColor: Colors.white12,
            filled: true,
            labelText: 'Поиск',
              prefixIcon: Icon(Icons.search)
          ),
              ),
        ),
      ),
    );
  }
}
