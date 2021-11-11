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
        child: Text('Change Profile Photo', style: TextStyle(color: Colors.blue),),
      ),
                InkWell(

                  onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );
                  },
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                   child: Row(
                      children: [
                        Text('Name'),
                        SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        Text('Lesbek Rakhat'),

                   ],

                    ),



                      ),

              ),

              InkWell(

                onTap: () {print('Hello');},
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Username'),
                      SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Text('Rakhat02'),

                    ],

                  ),



                ),

              ),
              InkWell(

                onTap: () {print('Hello');},
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Website'),
                      SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Text(' '),

                    ],

                  ),



                ),

              ),
              InkWell(

                onTap: () {print('Hello');},
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Bio'),
                      SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Text(' '),

                    ],

                  ),



                ),

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
