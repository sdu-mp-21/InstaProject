import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'editfields.dart';

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
                        Text('Name',style: TextStyle(color: Colors.white),),
                        SizedBox(
                          width: 20,
                          height: 20,
                        ),
                        Text('Bakytbek Kenzhebekov',style: TextStyle(color: Colors.white),),

                   ],

                    ),



                      ),

              ),

              InkWell(

                onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );},
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Username',style: TextStyle(color: Colors.white),),
                      SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Text('Rakhat02',style: TextStyle(color: Colors.white),),

                    ],

                  ),



                ),

              ),
              InkWell(

                onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );},
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Website',style: TextStyle(color: Colors.white),),
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

                onTap: () { Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NextPage()),
                  );},
                child: new Padding(
                  padding: new EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Text('Bio',style: TextStyle(color: Colors.white),),
                      SizedBox(
                        width: 20,
                        height: 20,
                      ),
                      Text(' ',style: TextStyle(color: Colors.white),),

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
