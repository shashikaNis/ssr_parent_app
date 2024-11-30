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
      return getReference().add({'name': name});
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
