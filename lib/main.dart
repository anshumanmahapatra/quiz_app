import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';

import 'package:quiz_app/services/auth/authentication.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/screens/home_screen.dart';
import '/screens/start.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: NavigationScreen(),
        ),
        providers: [
          ChangeNotifierProvider(create: (_) => Authentication()),
        ]);
  }
}

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  String? finalEmail;
  
  @override
  void initState() {
    super.initState();
    isSignedIn().whenComplete(() {
      Timer(const Duration(seconds: 3), () {
      

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => finalEmail != null
                    ?  const HomeScreen()
                    :  const Start()));
      });
    });
  }



  Future isSignedIn() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString("email");
    setState(() {
      finalEmail = obtainedEmail;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      height: size.height,
      width: size.width,
      color: const Color(0xFFFAD410),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: size.height * 0.2,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              width: size.width,
              height: size.height * 0.1,
              child: Align(
                alignment: Alignment.center,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E1B17),
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Checking if the User is Logged In or Not...",
                        speed: const Duration(milliseconds: 55),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Lottie.asset(
              "assets/search.json",
              repeat: false,
            ),
          ],
        ),
      ),
    ));
  }
}
