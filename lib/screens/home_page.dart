import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/screens/apart_pages/show_apart_page.dart';
import 'package:bitirme5/screens/home_drawer.dart';
import 'package:bitirme5/screens/users_page/login_page.dart';
import 'package:bitirme5/screens/post_pages/new_post_page.dart';
import 'package:bitirme5/screens/post_pages/show_post_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final bool isAuth = user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
      ),
      drawer: HomeDraver(),
      body: Container(
        color: Colors.red,
        margin:  EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            RaisedButton(
              child: Text("Ev Arkadaşı Arıyorum"),
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowPostPage(deger: (SingingCharacter.arkadas).toString(),)),
              );
            },),
            RaisedButton(
              child: Text("Ev Arıyorum"),
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowPostPage(deger: (SingingCharacter.ev).toString())),
              );
            },),
            RaisedButton(
              child: Text("Apart Arıyorum"),
              onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowApartPage()),
              );
            },),

          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isAuth) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewPostPage()),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
        tooltip: isAuth ? "Yeni Post" : "Login",
        child:
            isAuth ? Icon(Icons.note_add) : Icon(Icons.settings_backup_restore),
      ),
    );
  }
}
