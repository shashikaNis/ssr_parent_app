import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoutePage extends StatefulWidget {
  @override
  State<RoutePage> createState() => RoutePageState();
}

class RoutePageState extends State<RoutePage> {
  static LatLng latLng = LatLng(80.000000, 79.000000);
  static CameraPosition cp = CameraPosition(target:latLng);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              SizedBox(
                height: 500,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: cp,
                ),
              ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("ADD ROUTE"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

