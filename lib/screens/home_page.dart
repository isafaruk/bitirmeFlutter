import 'package:bitirme5/screens/home_drawer.dart';
import 'package:bitirme5/screens/login_page.dart';
import 'package:bitirme5/screens/new_post_page.dart';
import 'package:bitirme5/screens/register_page.dart';
import 'package:bitirme5/shared/state.dart';
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
      body: Center(
        child: isAuth
            ? Text("Login işlem sonrası anasayfa")
            : Text("login işlem öncesi anasayfa"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        if (isAuth) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewPostPage()),
          );
        }else{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        }
      },
        tooltip: isAuth ? "Yeni Post" : "Login",
        child: isAuth
            ? Icon(Icons.note_add)
            : Icon(Icons.settings_backup_restore),

      ),
    );
  }
}
