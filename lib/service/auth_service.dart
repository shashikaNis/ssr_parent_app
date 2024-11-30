import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static login(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
    }
  }

  static logout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
  }

  static register(String email, String password, String phoneNumber,
      String fullName) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      CollectionReference user = FirebaseFirestore.instance.collection('users');
      user.doc(FirebaseAuth.instance.currentUser!.uid).set({
        'email':email,
        'fullName':fullName,
        'phone':phoneNumber,
        'uid':
        FirebaseAuth.instance.currentUser!.uid,
      });
    } catch (e) {
      print(e);
    }
  }
}
