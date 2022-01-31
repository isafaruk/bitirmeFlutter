import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/models/users.dart';
import 'package:bitirme5/screens/apart_pages/show_apart_page.dart';
import 'package:bitirme5/screens/home_drawer.dart';
import 'package:bitirme5/screens/users_page/login_page.dart';
import 'package:bitirme5/screens/post_pages/new_post_page.dart';
import 'package:bitirme5/screens/post_pages/show_post_page.dart';
import 'package:bitirme5/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    Users users = new Users();

    Future<Users?> getUserInfo() async {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user?.uid)
          .get()
          .then((value) {
        users = Users.fromFirestore(value);
        return users;
      });
    }

    final bool isAuth = user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
      ),
      drawer: HomeDraver(),
      body: Container(
        margin: EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: getUserInfo(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: ElevatedButton(
                        child: Text("Ev Arkadaşı Arıyorum"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ShowPostPage(
                                      deger: (SingingCharacter.arkadas).toString(),
                                    )),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 100,
                     child: ElevatedButton(
                      child: Text("Ev Arıyorum"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ShowPostPage(
                                      deger: (SingingCharacter.ev).toString())),
                        );
                      },
                    ),),
                    SizedBox(
                      width: 200,
                      height: 100,
                      child: ElevatedButton(
                        child: Text("Apart Arıyorum"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>
                                ShowApartPage(users: users,)),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          },

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
        tooltip: isAuth ? "Yeni İlan" : "Login",
        child:
        isAuth ? Icon(Icons.note_add) : Icon(Icons.settings_backup_restore),
      ),
    );
  }
}
