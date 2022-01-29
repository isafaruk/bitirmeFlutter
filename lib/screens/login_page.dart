import 'package:bitirme5/main.dart';
import 'package:bitirme5/screens/home_page.dart';
import 'package:bitirme5/screens/register_page.dart';
import 'package:bitirme5/services/auth.dart';
import 'package:bitirme5/shared/constants.dart';
import 'package:bitirme5/shared/state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();

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
    return Scaffold(
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
                    decoration: textInputDecoration.copyWith(hintText: "Şifre"),
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
                          try {
                            final User user = await _auth.loginWithEmailAndPass(
                              _emailController.text,
                              _passController.text,
                            );
                            if (user != null) {
                              Provider.of<GlobalState>(context, listen: false)
                                  .updateIsAuth(true);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomePage(),
                                ),
                              );
                            }else{

                            }
                          } catch (e) {
                            print("hata oluştu " + e.toString());
                          }
                        }
                      },
                    ),
                  ),
                  Text("Hala kayıtlı değil misiniz?"),
                  FlatButton(
                    child: Text("Kayıt ol"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
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
