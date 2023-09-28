import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../utils_.dart';

class SignUp {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void signUp_(String _email, String _passWord, BuildContext context) {
    _auth
        .createUserWithEmailAndPassword(email: _email, password: _passWord)
        .then((value) => {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/logInPage", (Route route) => false)
            })
        .onError((error, stackTrace) => {Utils_().fireToast(error.toString())});
  }
}
