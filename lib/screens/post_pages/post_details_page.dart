import 'package:bitirme5/models/post.dart';
import 'package:flutter/material.dart';

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
          title: Text("post gösterme"),
        ),
        body: Card(
          color: Colors.cyan[50],
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ListTile(
            title: Text(
              "Title: " + widget.post.title!,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Content :" + widget.post.content!,
            ),
          ),
        )
    );
  }
}
