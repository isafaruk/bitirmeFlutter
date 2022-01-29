import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String? uid;
  DatabaseService({this.uid});

  final CollectionReference collectionReference = FirebaseFirestore.instance.collection("users");

  Future registerUser(String uid, String name, String email) async{
    try{
      return await collectionReference
          .doc(uid)
          .set({
        "name": name,
        "email": email,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
    }catch(e){
      print("Hata oluştu: " + e.toString());
    }
  }

  Future createPost(String uid, String title, String content) async{
    try{
      await collectionReference
          .doc(uid)
          .collection("posts")
          .doc()
          .set({
        "title": title,
        "content": content,
        "createdAt": FieldValue.serverTimestamp(),
        "updatedAt": FieldValue.serverTimestamp(),
      });
      return uid;
    }catch(e){
      print("Hata oluştu: " + e.toString());
    }
  }

}