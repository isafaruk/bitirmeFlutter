import 'package:bitirme5/models/users.dart';
import 'package:bitirme5/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();

  Stream<Users?> get user {
    return _auth.authStateChanges()
        .map((User? user) =>
    (user != null) ? Users(uid: user.uid) : null);
  }

  Future loginWithEmailAndPass(String email, String pass) async{
    try{
      UserCredential credential = (await FirebaseAuth
          .instance
          .signInWithEmailAndPassword(
          email: email,
          password: pass));
      return  credential.user!;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPass(String name, String email, String pass) async{
    try{
      UserCredential credential = await FirebaseAuth
          .instance
          .createUserWithEmailAndPassword(
          email: email,
          password: pass);
      await _db.registerUser(credential.user!.uid, name, email);
      return credential.user!;
    }catch(e){
      print(e.toString());
      return null;
    }

  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }
}