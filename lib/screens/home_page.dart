import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/screens/home_drawer.dart';
import 'package:bitirme5/screens/login_page.dart';
import 'package:bitirme5/screens/new_post_page.dart';
import 'package:bitirme5/screens/show_post_page.dart';
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
    final posts = Provider.of<List<Post>?>(context) ?? [];
    final bool isAuth = user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
      ),
      drawer: HomeDraver(),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              posts[index].title!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShowPostPage(post:posts[index])),
              );
            },
          );
        },
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
