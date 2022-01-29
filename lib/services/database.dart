import 'package:bitirme5/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");

  List<Post> _postListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post.fromFirestore(doc);
    }).toList();
  }
  Stream<List<Post>> get posts {
    return FirebaseFirestore.instance
        .collectionGroup('posts')
        .snapshots()
        .map((event) => _postListFromSnapshots(event));
  }

  Stream<List<Post>> get individualPosts {
    return collectionReference
        .doc(uid)
        .collection('posts')
        .snapshots()
        .map((event) => _postListFromSnapshots(event));
  }

  Future registerUser(String uid, String name, String email) async {
    try {
      return await collectionReference.doc(uid).set({
        "name": name,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Hata oluştu: " + e.toString());
    }
  }

  Future createPost(String uid, String title, String content) async {
    try {
      await collectionReference.doc(uid).collection("posts").doc().set({
        "title": title,
        "content": content,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
     /* await FirebaseFirestore.instance.collection("posts").doc().set({
        "title": title,
        "content": content,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });*/
      return uid;
    } catch (e) {
      print("Hata oluştu: " + e.toString());
    }
  }
  Future editPost(String id, String title, String content) async {
    try {
      await collectionReference.doc(uid).collection('posts').doc(id).update({
        "title": title,
        "content": content,
        "updatedAt": FieldValue.serverTimestamp(),
      });
      return uid;
    } catch (e) {
      print('Hata oluştu!! : $e');
      return null;
    }
  }

  Future deletePost(
      String id,
      ) async {
    try {
       await collectionReference
          .doc(uid)
          .collection('posts')
          .doc(id)
          .delete();

    } catch (e) {
      print('Hata oluştu!! : $e');
      return null;
    }
  }
}
