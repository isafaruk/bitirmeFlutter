import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/screens/edit_post_page.dart';
import 'package:bitirme5/screens/new_post_page.dart';
import 'package:bitirme5/screens/show_post_page.dart';
import 'package:bitirme5/services/database.dart';
import 'package:bitirme5/shared/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  final user;
  MyPosts({Key? key, @required this.user}) : super(key: key);

  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyPosts'),
      ),
      body: StreamBuilder<List<Post>>(
        stream: DatabaseService(uid: widget.user.uid).individualPosts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var posts = snapshot.data!;
            return ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    posts[index].title!,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(posts[index].content!),
                  trailing: PopupMenuButton(
                    onSelected: (result){
                      final type = result.toString().split(" ")[0];
                      final value = posts[int.parse(result.toString().split(" ")[1])] ;
                      print(type);
                      print(value);
                      switch (type) {
                        case 'edit':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditPostPage(post: value),
                            ),
                          );
                          break;
                        case 'delete':
                          DatabaseService(uid: widget.user.uid)
                              .deletePost(value.id!);
                          break;
                      }

                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                          value: 'edit' +" "+ index.toString()  ,
                          child: Text('Düzenle')),

                      PopupMenuItem(
                          value: 'delete' +" "+ index.toString()  ,
                          child: Text('Sil')),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowPostPage(post: posts[index]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return Loading();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NewPostPage(),
              ),
            );
          },
          tooltip: 'Yeni Post',
          child: Icon(Icons.note_add)),
    );
  }
}

