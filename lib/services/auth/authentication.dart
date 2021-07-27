import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication with ChangeNotifier {
  final _googleSignIn = GoogleSignIn();

  Future login() async {
    await _googleSignIn.signIn();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.setString(
        "displayName", _googleSignIn.currentUser!.displayName.toString());
    sharedPreferences.setString(
        "photoUrl", _googleSignIn.currentUser!.photoUrl.toString());

    notifyListeners();
  }

  Future logout() async {
    await _googleSignIn.disconnect();
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    sharedPreferences.remove("displayName");
    sharedPreferences.remove("photoUrl");
    notifyListeners();
  }
}
