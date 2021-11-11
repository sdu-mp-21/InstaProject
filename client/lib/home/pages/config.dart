import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
               title:Text('Edit Profile'),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: <Widget>[
        TextButton(
        onPressed: () {
          Navigator.of(context).pop(true);
        },
        child: const Text('Done'),
      ),
    ],
          ),

      body:SafeArea(
       child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[


          CircleAvatar(
          backgroundImage: AssetImage('assets/IMG_5026.JPG') ,
          radius: 50,
        ),
      TextButton(
        onPressed: () {
        },
        child: Text('Chang Profile Photo', style: TextStyle(color: Colors.blue),),
      ),
              Row(
                children:[
                  Container(
                    padding: EdgeInsets.fromLTRB(50,10,50,10),
                    child:
                Text('Name',style: TextStyle(color: Colors.white),),

                  ),
                    ],
              ),

              Row(
                children:[
                  Container(
                    padding: EdgeInsets.fromLTRB(50,10,50,10),
                    child:
                    Text('Username',style: TextStyle(color: Colors.white),),

                  ),
                ],
              ),
              Row(
                children:[
                  Container(
                    padding: EdgeInsets.fromLTRB(50,10,50,10),
                    child:
                    Text('Website',style: TextStyle(color: Colors.white),),

                  ),
                ],
              ),
              Row(
                children:[
                  Container(
                    padding: EdgeInsets.fromLTRB(50,10,50,10),
                    child:
                    Text('Bio',style: TextStyle(color: Colors.white),),

                  ),
                ],
              ),
        
        ],



      ),







      ),
      // TextButton(onPressed: () {
      //   Navigator.of(context).pop(true);
      // }, child: Text('Back', style: TextStyle(color: Colors.white)))
     );
  }
}