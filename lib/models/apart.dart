import 'package:cloud_firestore/cloud_firestore.dart';

class Apart {
  final String? id;
  final String? apartName;
  final String? apartDesc;
  final bool? isCamera;
  final bool? isSecure;
  final bool? haveBalcony;
  final String? apartAdress;
  final String? apartContact;
  final String? imageUrl;

  Apart(
      {this.id,
      this.apartName,
      this.apartDesc,
      this.isCamera,
      this.isSecure,
      this.haveBalcony,
      this.apartAdress,
      this.apartContact,
      this.imageUrl});

  Apart.fromFirestore(DocumentSnapshot document)
      : id = document.id,
        apartName = document['apartName'],
        apartDesc = document['apartDesc'],
        isCamera = document['isCamera'],
        isSecure = document['isSecure'],
        haveBalcony = document['haveBalcony'],
        apartAdress = document['apartAdress'],
        apartContact = document['apartContact'],
        imageUrl = document['apartImageUrl'];
}
