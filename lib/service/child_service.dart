import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChildService {
  getReference() {
    final currentUSerld = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(currentUSerld)
        .collection('children');
  }

  Future<void> addChild(String name) {
    try {
      final random = Random();
      final otp = (100000 + random.nextInt(900000)).toString();
      final childCode = "SSRC"+otp.toString();
      return getReference().add({'name': name, 'childCode':childCode});
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Stream<QuerySnapshot> getChildren() {
    return getReference().snapshots();
  }

  Future<DocumentSnapshot> getChild(String id) {
    return getReference().doc(id).get();
  }
}
