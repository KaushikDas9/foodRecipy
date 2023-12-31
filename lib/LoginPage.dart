import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:untitled/utils_.dart';

import 'FireBase_work/LogIn.dart';

bool loginCheak = false;

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

GoogleSignIn _googleSignIn = GoogleSignIn();
FirebaseAuth _auth = FirebaseAuth.instance;

class _loginPageState extends State<loginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _email = TextEditingController();
  TextEditingController _passWord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(color: Colors.orange),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.fastfood, size: 150, color: Colors.pink),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    "Food Karo",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.pinkAccent),
                  ),
                ),
                const Text(
                  "Search karo food banao ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * .07)),
                //Form Suru
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .05,
                              right: MediaQuery.of(context).size.width * .05),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.email_outlined),
                              hintText: "Username",
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                            controller: _email,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * .05,
                              right: MediaQuery.of(context).size.width * .05),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline),
                              hintText: "Password",
                            ),
                            controller: _passWord,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter PassWord';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  loginCheak = LogIn().LogIn_(
                                      _email.text.toString(),
                                      _passWord.text.toString(),
                                      context);

                                  print(_email.text.toString());
                                }
                              },
                              child: loginCheak
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : const Text("LOG IN")),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 15),
                          child: Text("Forgot Password?"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an Account ?"),
                            CupertinoButton(
                                child: const Text("Sign up"),
                                onPressed: () {
                                  Navigator.pushNamed(context, "/signUpPage");
                                }),
                          ],
                        )
                      ],
                    )),
                //Form Ses
                const Text(
                  "Or",
                  style: TextStyle(fontSize: 15),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                SignInButton(
                  Buttons.google,
                  onPressed: () {
                    sign_in_with_google()
                        .then((value) => {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, "/afterLogIn", (route) => false)
                            })
                        .onError((error, stackTrace) =>
                            {Utils_().fireToast(error.toString())});
                  },
                ),
              ],
            ),
          ),
        ));
  }

  Future<User?> sign_in_with_google() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    AuthCredential googleAuthCredential = await GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken);

    UserCredential userCredential =
        await _auth.signInWithCredential(googleAuthCredential);
    User? user = userCredential.user;

    assert(!user!.isAnonymous);
    assert(user?.getIdToken() != null);

    return user;
  }
}
