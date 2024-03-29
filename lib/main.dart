import 'package:bitirme5/models/apart.dart';
import 'package:bitirme5/models/post.dart';
import 'package:bitirme5/models/users.dart';
import 'package:bitirme5/screens/home_page.dart';
import 'package:bitirme5/services/auth.dart';
import 'package:bitirme5/services/database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';



void main() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp();

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool isAuth = false;

  Stream<User?> test = FirebaseAuth.instance.authStateChanges();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        isAuth = user != null;
        print("değer " + isAuth.toString());
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
        StreamProvider<User?>(create: (context) => test, initialData: null,),
        StreamProvider<Users?>.value(value: AuthService().user, initialData: null,),
        StreamProvider<List<Post>?>(
          create: (context) => DatabaseService().posts,
          initialData: null,
        ),
        StreamProvider<List<Apart>?>(
          create: (context) => DatabaseService().aparts,
          initialData: null,
        )
      ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Firebase',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: HomePage(),
        ),
      );

  }
}



