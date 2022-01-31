import 'package:bitirme5/models/users.dart';
import 'package:bitirme5/screens/home_page.dart';
import 'package:bitirme5/screens/users_page/register_page.dart';
import 'package:bitirme5/services/auth.dart';
import 'package:bitirme5/shared/constants.dart';
import 'package:bitirme5/shared/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

  bool loading = false;
  String error = '';

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  final _auth = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Giriş Yap"),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: _loginFormKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
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
                        decoration:
                            textInputDecoration.copyWith(hintText: "Şifre"),
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Lütfen şifre giriniz.";
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: RaisedButton(
                          child: Text("Giriş"),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          onPressed: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              setState(() {
                                loading = true;
                              });
                              try {
                                final User? user =
                                    await _auth.loginWithEmailAndPass(
                                  _emailController.text,
                                  _passController.text,
                                );
                                if (user != null) {
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
                      Text("Hala kayıtlı değil misiniz?"),
                      FlatButton(
                        child: Text("Kayıt ol"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterPage()),
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
