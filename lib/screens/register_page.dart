import 'package:bitirme5/main.dart';
import 'package:bitirme5/screens/home_page.dart';
import 'package:bitirme5/screens/login_page.dart';
import 'package:bitirme5/services/auth.dart';
import 'package:bitirme5/shared/constants.dart';
import 'package:bitirme5/shared/loading.dart';
import 'package:bitirme5/shared/state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  final _auth = AuthService();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
        appBar: AppBar(
          title: Text("Kayıt Ol"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _registerFormKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration:
                        textInputDecoration.copyWith(hintText: "İsim Soyisim"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen isim giriniz.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration:
                        textInputDecoration.copyWith(hintText: "E-Posta"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen email giriniz.";
                      } else if (!EmailValidator.validate(value)) {
                        return "Lütfen geçerli bir email giriniz";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _passController,
                    decoration: textInputDecoration.copyWith(hintText: "Şifre"),
                    obscureText: true,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Lütfen şifre giriniz.";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _confirmPassController,
                    decoration: textInputDecoration.copyWith(
                        hintText: "Şifre Doğrulama"),
                    obscureText: true,
                    validator: (value) {
                      if (value != _passController.text) {
                        return "Şifreleriniz Eşleşmiyor";
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                    child: RaisedButton(
                      child: Text("Register"),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: () async {
                        if (_registerFormKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          try {
                            final User? user =
                                (await _auth.registerWithEmailAndPass(
                                    _nameController.text,
                                    _emailController.text,
                                    _passController.text));
                            if(user != null){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }else{
                              setState(() {
                                error = 'Bilgilerini kontrol ediniz!';
                                loading = false;
                              });
                            }
                          } catch (e) {
                            print("hata oluştu " + e.toString());
                          }
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text("Hesabınız var mı?"),
                  FlatButton(
                    child: Text("Giriş"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
