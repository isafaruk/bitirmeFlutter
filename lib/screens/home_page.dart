import 'package:bitirme5/screens/home_drawer.dart';
import 'package:bitirme5/screens/login_page.dart';
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
      appBar: AppBar(title: Text("Anasayfa"),
      ),
      drawer: HomeDraver(),
      body: Center(
        child: isAuth
          ? Text("Login işlem sonrası anasayfa")
          : Text("login işlem öncesi anasayfa"),
      ),
    );
  }
}
