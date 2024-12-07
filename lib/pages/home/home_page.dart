import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ssr_parent_app/components/add_child_model.dart';
import 'package:ssr_parent_app/components/child_list_item.dart';
import 'package:ssr_parent_app/service/auth_service.dart';
import 'package:ssr_parent_app/service/child_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ChildService _childService = ChildService();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.0000000, 80.7001093),
    zoom: 7.4,
  );

  void showAddChildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddChildModel();
      },
    );
  }

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        context.go("/login");
        print('User is currently signed out!');
        return;
      } else {
        print('User is signed in!');
      }
    });
    setChildrenLocation();
    super.initState();
  }

  static Set<Marker> markers = {};

  setChildrenLocation() {
    _childService.getChildren().listen((children) {
      for (var child in children.docs) {
        GeoPoint? location = child["location"];
        if (location != null) {
          setState(() {
            markers.add(Marker(
                markerId: MarkerId(child.id),
                position: LatLng(location.latitude, location.longitude)));
          });
        }
      }
    });
  }

  onclickLogout() {
    AuthService.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF65558F),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Image(
              image: AssetImage('assets/icons/Notifications.png'),
            ),
          )
        ],
        title: Text(
          "SSR Parent App",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 500,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _kGooglePlex,
              markers: markers,
            ),
          ),
          ElevatedButton(
            onPressed: onclickLogout,
            child: Text("LogOut"),
          ),
          ElevatedButton(
            onPressed: () => showAddChildDialog(context),
            child: Text(
              "ADD CHILD",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF65558F)),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: _childService.getChildren(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final children = snapshot.data!.docs;
                  return ListView.builder(
                      itemCount: children.length,
                      itemBuilder: (context, index) {
                        final child = children[index];
                        return ChildListItem(
                          dotColors: Colors.greenAccent,
                          name: child['name'],
                          id: child.id,
                        );
                      });
                }),
          )
        ],
      )),
    );
  }
}
