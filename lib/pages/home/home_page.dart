import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ssr_parent_app/components/child_list_item.dart';
import 'package:ssr_parent_app/service/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(8.0000000, 80.7001093),
    zoom: 7.4,
  );

  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        context.go("/login");
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

  static Set<Marker> markers = {
    Marker(
        markerId: MarkerId("child_id_01"),
        position: LatLng(8.0000000, 80.7001093)),
    Marker(
        markerId: MarkerId("child_id_02"),
        position: LatLng(8.0000000, 79.5005093)),
  };

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
            child: Text("Logout"),
          ),
          ChildListItem(
            name: "child 01",
            dotColors: Colors.green,
          ),
          ChildListItem(
            name: "child 02",
            dotColors: Colors.red,
          ),
          ChildListItem(
            name: "child 03",
            dotColors: Colors.yellow,
          ),
        ],
      )),
    );
  }
}
