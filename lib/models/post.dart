
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String? id;
  final String? title;
  final String? content;
  final Timestamp? createdAt;
  final Timestamp? updatedAt;
  final String? isHome;

  Post({
    this.id,
    this.title,
    this.content,
    this.createdAt,
    this.updatedAt,
    this.isHome,
  });

  Post.fromFirestore(DocumentSnapshot document)
      : id = document.id,
        title = document['title'],
        content = document['content'],
        createdAt = document['createdAt'],
        updatedAt = document['updatedAt'],
        isHome = document['isHome'];


}