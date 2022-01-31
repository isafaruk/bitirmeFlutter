import 'dart:io';

import 'package:bitirme5/models/users.dart';
import 'package:bitirme5/screens/home_page.dart';
import 'package:bitirme5/services/auth.dart';
import 'package:bitirme5/services/database.dart';
import 'package:bitirme5/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class NewApartPage extends StatefulWidget {
  const NewApartPage({Key? key}) : super(key: key);

  @override
  _NewApartPageState createState() => _NewApartPageState();
}

class _NewApartPageState extends State<NewApartPage> {
  FirebaseStorage storage = FirebaseStorage.instance;
  List<Map<String, dynamic>> files = [];
  String? apartName = "";
  String? apartDesc = "";
  String? apartAdress = "";
  String? apartContact = "";
  bool? isCamera = false;
  bool? isSecure = false;
  bool? haveBalcony = false;
  String? apartImageUrl = "";
  final ImagePicker picker = ImagePicker();
  File? uploadPostImage;
  File get getUploadPostImage => uploadPostImage!;
  String? uploadPostImageUrl;
  String get getUploadPostImageUrl => uploadPostImageUrl!;
  late UploadTask postImageUploadTask;

  Future pickPostImage(BuildContext context) async {
    final uploadPostImageVal =
        await picker.pickImage(source: ImageSource.gallery);
    uploadPostImageVal == null
        ? debugPrint('Select image')
        : setState(() {
            uploadPostImage = File(uploadPostImageVal.path);
          });
  }

  Future uploadPostImageToFirebase() async {
    Reference imageReference = FirebaseStorage.instance
        .ref()
        .child('posts/${uploadPostImage!.path}/${TimeOfDay.now()}');

    postImageUploadTask = imageReference.putFile(uploadPostImage!);
    await postImageUploadTask.whenComplete(() {
      debugPrint('Picture uploaded successfully');
    });
    await imageReference.getDownloadURL().then((imageUrl) {
      uploadPostImageUrl = imageUrl;
      debugPrint(uploadPostImageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Apart Oluşturma"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text("Yeni Apart Ekle", style: TextStyle(fontSize: 30.0, color: Colors.black),),
              TextField(
                decoration: textInputDecoration.copyWith(hintText: 'Apart İsim'),
                onChanged: (value) {
                  apartName = value;
                },
              ),
              TextField(
                decoration: textInputDecoration.copyWith(hintText: 'Açıklama'),
                onChanged: (value) {
                  apartDesc = value;
                },
              ),
              CheckboxListTile(
                title: Text("Kamera Sistemi"),
                value: isCamera == true ? true : false,
                onChanged: (value) {
                  setState(() {
                    isCamera = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Güvenlik"),
                value: isSecure == true ? true : false,
                onChanged: (value) {
                  setState(() {
                    isSecure = value;
                  });
                },
              ),
              CheckboxListTile(
                title: Text("Balkon"),
                value: haveBalcony == true ? true : false,
                onChanged: (value) {
                  setState(() {
                    haveBalcony = value;
                  });
                },
              ),
              TextField(
                decoration: textInputDecoration.copyWith(hintText: 'Adres'),
                onChanged: (value) {
                  apartAdress = value;
                },
              ),
              TextField(
                decoration: textInputDecoration.copyWith(hintText: 'İletişim Bilgileri'),
                onChanged: (value) {
                  apartContact = value;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => pickPostImage(context),
                    icon: const Icon(Icons.library_add),
                    label: const Text('Resim Ekle'),
                  ),
                ],
              ),
              uploadPostImage != null
                  ? Container(child: Image.file(uploadPostImage!))
                  : Container(),
              ElevatedButton(
                onPressed: () async {
                  await uploadPostImageToFirebase();
                  await FirebaseFirestore.instance.collection("aparts").add({
                    "apartName": apartName,
                    "apartDesc": apartDesc,
                    "isCamera": isCamera,
                    "isSecure": isSecure,
                    "haveBalcony": haveBalcony,
                    "apartAdress": apartAdress,
                    "apartContact": apartContact,
                    "apartImageUrl": uploadPostImageUrl,
                  });
                  files.clear();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                      ));
                },
                child: Text("Apart Ekle"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
