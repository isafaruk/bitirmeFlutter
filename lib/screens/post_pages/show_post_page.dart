import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/screens/home_drawer.dart';
import 'package:bitirme5/screens/post_pages/post_details_page.dart';
import 'package:bitirme5/screens/users_page/login_page.dart';
import 'package:bitirme5/screens/post_pages/new_post_page.dart';
import 'package:bitirme5/screens/post_pages/show_post_page.dart';
import 'package:bitirme5/services/database.dart';
import 'package:bitirme5/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShowPostPage extends StatefulWidget {
  String deger;
  ShowPostPage({Key? key, required this.deger}) : super(key: key);
  @override
  _ShowPostPageState createState() => _ShowPostPageState();
}

class _ShowPostPageState extends State<ShowPostPage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final bool isAuth = user != null;

    return Scaffold(
      appBar: AppBar(
        title: Text("İlanlar"),
      ),
      body: StreamBuilder<List<Post>>(
        stream: DatabaseService().posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            var posts = snapshot.data!;
            return ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  if(posts[index].isHome == widget.deger){
                    return Card(
                        color: Colors.cyan[50],
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          title: Text(
                            posts[index].title!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            posts[index].content!,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PostDetailsPage(post: posts[index])),
                            );
                          },
                        ),
                    );
                  }
                  else{
                    return Container();
                  }
                }
                );
          }
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