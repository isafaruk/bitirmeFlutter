import 'package:bitirme5/models/post.dart';
import 'package:flutter/material.dart';

class ShowPostPage extends StatefulWidget {
  final Post post;
  const ShowPostPage({Key? key, required this.post}) : super(key: key);

  @override
  _ShowPostPageState createState() => _ShowPostPageState();
}

class _ShowPostPageState extends State<ShowPostPage> {
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
        ));
  }
}
