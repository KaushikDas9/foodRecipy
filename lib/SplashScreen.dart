import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Splash.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Splash().isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(color: Colors.orange),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.fastfood,
                size: MediaQuery.of(context).size.aspectRatio * 350,
                color: Colors.pink,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              const Text(
                "welcome  To Our App",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
