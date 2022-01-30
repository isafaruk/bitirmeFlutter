
import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
   final String uid;
   final String? name;
   final String? email;

  Users({
    required this.uid,
    this.name,
    this.email,
  });

   Users.fromFirestore(DocumentSnapshot document)
       : uid = document.id,
         name = document['name'],
         email  = document['email'];

}