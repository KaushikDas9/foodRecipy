import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class Splash {
  FirebaseAuth _auth = FirebaseAuth.instance;

  void isLogin(BuildContext context) {
    if (_auth.currentUser == null) {
      Timer(const Duration(seconds: 3), () {
        Navigator.popAndPushNamed(context, "/logInPage");
      });
    } else {
      Timer(const Duration(seconds: 3), () {
        Navigator.popAndPushNamed(context, "/afterLogIn");
      });
    }
  }
}
