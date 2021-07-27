import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/screens/home_screen.dart';
import 'package:quiz_app/services/auth/authentication.dart';

class Start extends StatefulWidget {
  const Start({Key? key}) : super(key: key);

  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  
  Future signIn() async {
    await Provider.of<Authentication>(context, listen: false)
        .login()
        .whenComplete(() {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
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
            children: [
              SizedBox(height: size.height * 0.1),
              const Text(
                "Welcome to",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset(
                "assets/app_logo.png",
                height: size.height * 0.3,
              ),
              const SizedBox(height: 30),
              const Text(
                "Please Sign in with",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  elevation: 10,
                ),
                icon: const FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.blue,
                ),
                label: const Text(
                  "Google Sign In",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: signIn,
              ),
              const SizedBox(height: 10),
              RichText(
                  text: const TextSpan(
                      text: "To explore the ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:  Color(0xFF1E1B17),
                      ),
                      children: <TextSpan>[
                    TextSpan(
                        text: "DID YOU KNOW? ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color:  Color(0xFF1E1B17),)),
                    TextSpan(
                      text: "App",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color:  Color(0xFF1E1B17),
                      ),
                    )
                  ])),
              const SizedBox(height: 20),
              Lottie.asset(
                "assets/hello.json",
                repeat: true,
                height: size.height * 0.3,
              )
            ],
          ),
        ),
      ),
    );
  }
}
