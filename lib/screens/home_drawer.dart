
import 'package:bitirme5/screens/home_page.dart';
import 'package:bitirme5/screens/users_page/login_page.dart';
import 'package:bitirme5/screens/users_page/my_post.dart';
import 'package:bitirme5/screens/users_page/register_page.dart';
import 'package:bitirme5/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeDraver extends StatelessWidget {
  final _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    bool isAuth = user != null;
    String email = "";
    if (isAuth) {
      email = user.email!;
    } else {
      email = "Anonim";
    }
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: ListTile(
              leading: Icon(Icons.account_circle),
              title: Text(
                "$email",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          ),

          if (!isAuth) ...[
            InkWell(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Giriş Yap"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.account_circle),
                title: Text("Kayıt Ol"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
              ),
            ),
          ] else ...[
            InkWell(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("İlanlarım"),
                onTap: () async {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyPosts(user: user)),
                  );
                },
              ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text("Çıkış Yap"),
                onTap: () async {
                  await _auth.signOut();
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
