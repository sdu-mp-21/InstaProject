
import 'package:flutter/material.dart';
import '';
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _listState();
}

class _listState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.black,
      ),
      body: Column(
          children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),child:
    TextField(
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white, fontSize: 18),
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          )
      ),
    ),
    ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.person_add,color: Colors.white),
                  title: Text("Follow and invite Friends",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.notifications,color: Colors.white),
                  title: Text("Notification",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.add_business,color: Colors.white),
                  title: Text("Business",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.lock,color: Colors.white),
                  title: Text("Privacy",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.security,color: Colors.white),
                  title: Text("Security",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.payment_rounded,color: Colors.white),
                  title: Text("Payments",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.add_shopping_cart,color: Colors.white),
                  title: Text("Ads",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.person,color: Colors.white),
                  title: Text("Account",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),
            Card(color: Colors.black,
              child: Column(mainAxisSize: MainAxisSize.min,children: <Widget>[
                ListTile(
                  leading:  Icon(Icons.help,color: Colors.white),
                  title: Text("Help",style: TextStyle(color: Colors.white),),

                  trailing: IconButton(onPressed: null,icon:Icon(Icons.arrow_forward_ios,color: Colors.white)),),
              ],),
            ),

],

      ),
    );
  }
}
