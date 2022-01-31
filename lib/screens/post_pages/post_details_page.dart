import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;
  const PostDetailsPage({Key? key, required this.post}) : super(key: key);

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("İlan Detay"),
      ),
      body: Column(
        children: <Widget>[
          Card(
            color: Colors.cyan[50],
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Text(
                "Başlık: " + widget.post.title!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              subtitle: Text("Mesaj :" + widget.post.content!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            ),
          ),
          Card(
            color: Colors.cyan[50],
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: ListTile(
              title: Text(
                "Adres: " + widget.post.adress!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),

            ),
          ),
        ],
      ),
    );
  }
}
