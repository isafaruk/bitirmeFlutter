import 'package:bitirme5/models/apart.dart';
import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/models/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid, isHome;

  DatabaseService({this.uid, this.isHome});

  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection("users");

  List<Post> _postListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Post.fromFirestore(doc);
    }).toList();
  }
  List<Apart> _apartListFromSnapshots(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
        return Apart.fromFirestore(doc);
    }).toList();
  }

  Stream<List<Post>> get posts {
    return FirebaseFirestore.instance
        .collectionGroup('posts')
        .snapshots()
        .map((event) => _postListFromSnapshots(event));
  }
  Stream<List<Apart>> get aparts {
    return FirebaseFirestore.instance
        .collection('aparts')
        .snapshots()
        .map((event) => _apartListFromSnapshots(event));
  }

  Stream<List<Post>> get homePosts {
    return FirebaseFirestore.instance
        .collectionGroup('posts')
        .where('isHome', isEqualTo: isHome)
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
        "isAdmin": false,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Hata oluştu: " + e.toString());
    }
  }

  Future<Users?> getProfile(String? uid) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> result =
          await FirebaseFirestore.instance
              .collection("users")
              .doc(uid)
              .get();

      if (result.exists) {
        return Users.fromFirestore(result);
      }
    } catch (e) {
      print("Hata oluştu: " + e.toString());
    }
  }
  Future editProfile(String uid, String name) async {
    try {
      return await collectionReference.doc(uid).update({
        "name": name,
        "updatedAt": FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print('Hata oluştu!! : $e');
    }
  }

  Future createPost(String uid, String title, String content, String character,
      String adress) async {
    try {
      await collectionReference.doc(uid).collection("posts").doc().set({
        "title": title,
        "content": content,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
        "isHome": character,
        "adress": adress,
      });
      return uid;
    } catch (e) {
      print("Hata oluştu: " + e.toString());
    }
  }

  Future editPost(String id, String title, String content, String char,
      String adress) async {
    try {
      await collectionReference.doc(uid).collection('posts').doc(id).update({
        "title": title,
        "content": content,
        "updatedAt": FieldValue.serverTimestamp(),
        "isHome": char,
        "adress": adress
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
      await collectionReference.doc(uid).collection('posts').doc(id).delete();
    } catch (e) {
      print('Hata oluştu!! : $e');
      return null;
    }
  }
}
