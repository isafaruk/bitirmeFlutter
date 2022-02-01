import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/screens/home_page.dart';
import 'package:bitirme5/services/database.dart';
import 'package:bitirme5/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPostPage extends StatefulWidget {
  Post post;

  EditPostPage({Key? key, required this.post}) : super(key: key);

  @override
  _EditPostPageState createState() => _EditPostPageState();
}
enum SingingCharacter { arkadas, ev }
class _EditPostPageState extends State<EditPostPage> {
  final _editPostFormKey = GlobalKey<FormState>();

  SingingCharacter? _character;
  bool loading= false;
  String error ="";

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _contactController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    _contactController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    _titleController.text=widget.post.title!;
    _contentController.text=widget.post.content!;
    _contactController.text=widget.post.adress!;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Scaffold(
      appBar: AppBar(title: Text("İlan Düzenleme"),
      ),
      body:Container(
        padding : const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _editPostFormKey,
            child: Column(
              children: <Widget>[
                RadioListTile<SingingCharacter>(
                  title: Text("Ev arkadaşı arıyorum"),
                  value: SingingCharacter.arkadas,
                  groupValue: _character,
                  onChanged: (value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                RadioListTile<SingingCharacter>(
                  title: Text("Ev arıyorum"),
                  value: SingingCharacter.ev,
                  groupValue: _character,
                  onChanged: (value) {
                    setState(() {
                      _character = value;
                    });
                  },
                ),
                TextFormField(
                  decoration:
                  textInputDecoration.copyWith(hintText: 'Başlık'),
                  controller: _titleController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen başlık giriniz";
                    }else{
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration:
                  textInputDecoration.copyWith(hintText: 'Mesaj'),
                  controller: _contentController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen içerik giriniz";
                    }else{
                      return null;
                    }
                  },
                ),
                TextFormField(
                  decoration:
                  textInputDecoration.copyWith(hintText: 'İletişim'),
                  controller: _contactController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen içerik giriniz";
                    }else{
                      return null;
                    }
                  },
                ),
                Container(
                  margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                  child: RaisedButton(
                      child: Text("İlanı güncelle"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_editPostFormKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          try {
                            // Log in user by firebase auth
                            final user = Provider.of<User?>(
                                context,
                                listen:false
                            );
                            dynamic result =
                            await DatabaseService(uid: user!.uid).editPost(
                                widget.post.id!,
                                _titleController.text,
                                _contentController.text,
                                _character.toString(),
                                _contactController.text);

                            if (result != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            } else {
                              setState(() {
                                error = 'Bilgilerini kontrol ediniz!';
                                loading = false;
                              });
                            }
                          } catch (e) {
                            print('Hata Oluştu!!: $e');
                          }
                        }
                      }),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    )),

              ],
            ),

          ),
        ),
      ),
    );
  }
}
