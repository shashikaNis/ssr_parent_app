import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginService {
  static login(String email, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(

          content: Text("Invalied Credentials", textAlign: TextAlign.center, style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.red,
        ),
      );
      if (e.code == 'user-not-found') {

        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      print(e);
    }
  }

  static logout() async{
    try{
      print("On Log Out");
      await FirebaseAuth.instance.signOut();
    }catch(e){
      print(e);
    }
  }
}
