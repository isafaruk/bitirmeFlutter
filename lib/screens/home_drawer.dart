import 'package:bitirme5/main.dart';
import 'package:bitirme5/screens/home_page.dart';
import 'package:bitirme5/screens/login_page.dart';
import 'package:bitirme5/screens/register_page.dart';
import 'package:bitirme5/services/auth.dart';
import 'package:bitirme5/shared/state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeDraver extends StatelessWidget {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final bool isAuth = user != null;
    String email= "";
    if(isAuth){
      email = user.email!;
    }else{
      email = "anonim";
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text("$email}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24
              ),
            ),
          ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Giriş Yap"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> LoginPage()
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text("Kayıt Ol"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> RegisterPage()
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text("Çıkış Yap"),
              onTap: () async {
                await _auth.signOut();
                Provider.of<GlobalState>(context,listen: false)
                  .updateIsAuth(false);
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=> HomePage()
                  ),
                );
              },
            ),

        ],
      ),
    );
  }
}
