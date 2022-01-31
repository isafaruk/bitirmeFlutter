import 'package:cloud_firestore/cloud_firestore.dart';

class Users {
  final String? uid;
  final String? name;
  final String? email;
  final bool? isAdmin;

  Users({this.uid, this.name, this.email, this.isAdmin});

  Users.fromFirestore(DocumentSnapshot<Map<String, dynamic>> document)
      : uid = document.id,
        name = document.data()?['name'],
        email = document.data()?['email'],
        isAdmin = document.data()?['isAdmin'];
}
