import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RouteService{
  final String childId;
  late final CollectionReference routeReference;

  RouteService(this.childId){
    routeReference = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('children')
        .doc(childId)
        .collection('routes');
  }


  Future<void>saveRoute(String routeName, List<GeoPoint> routeData, GeoPoint start ,GeoPoint end) async{
   await routeReference.add({
     'name':routeName,
      'start':start,
      'end':end,
      'route':routeData,
    });
  }
  Stream<QuerySnapshot> getRoutes() {
    return routeReference.snapshots();
  }

}