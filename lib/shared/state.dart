
import 'package:flutter/cupertino.dart';

class GlobalState extends ChangeNotifier{
  bool isAuth = false;

  void updateIsAuth(bool value){
    isAuth = value;
    notifyListeners();
  }
}