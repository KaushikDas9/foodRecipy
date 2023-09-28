import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utils_.dart';

class LogIn {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  LogIn_(String _email, String _passWord, BuildContext context) {
    try {
      _auth.signInWithEmailAndPassword(email: _email, password: _passWord);

      Navigator.pushNamedAndRemoveUntil(
          context, "/afterLogIn", (Route route) => false);
    } catch (error) {
      {
        Utils_().fireToast(error.toString());
      }
    }
  }
}
