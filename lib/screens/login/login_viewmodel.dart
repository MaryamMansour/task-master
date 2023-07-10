import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do/screens/login/connector.dart';
import 'package:to_do/shared/base.dart';

class LoginViewModel extends BaseViewModel<LoginConnsector>{

  void login(String email, String password) async{
    {
      try {
        connector!.showLoading("");
        final credential = await FirebaseAuth.instance.
        signInWithEmailAndPassword(
            email: email,
            password: password
        );
        // logged();
        connector!.goToHome();
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          connector!.showMessage(e.message??"");
        } else if (e.code == 'wrong-password') {
          connector!.showMessage(e.message??"");
        }
      }

    }
  }


}