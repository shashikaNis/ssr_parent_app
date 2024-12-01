import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_directions/google_maps_directions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ssr_parent_app/service/route_service.dart';
import 'package:go_router/go_router.dart';

class RoutePage extends StatefulWidget {
  final String childId;

  const RoutePage({super.key, required this.childId});

  @override
  State<RoutePage> createState() => RoutePageState();
}

class RoutePageState extends State<RoutePage> {
  TextEditingController routeNameController = TextEditingController();

  /// mekata yatin tinnath one
  static LatLng latLng = LatLng(8.0000000, 80.7001093);
  CameraPosition cp = CameraPosition(target: latLng, zoom: 7.4);

  /// Map controlling variables
  late GoogleMapController _mapController;
  final Set<Marker> _markers = {};
  late Set<Polyline> _polyline = {};
  LatLng? _startLocation;
  LatLng? _endLocation;
  List<LatLng> _routeCordinates = [];

  ///methanin danna puluwan

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      if (_startLocation == null) {
        _startLocation = position;
        _markers.add(Marker(markerId: MarkerId("start"), position: position));
      } else if (_endLocation == null) {
        _endLocation = position;
        _markers.add(Marker(markerId: MarkerId('end'), position: position));
        _getRoute();
      }
    });
  }

  Future<void> _getRoute() async {
    /// methana wela tinne api goofle Direction api aka connect karala tiyenne
    GoogleMapsDirections.init(
        googleAPIKey: 'AIzaSyC3WMm0zAfOa80jYCf3HXGdsXjWNFCBGQ8');

    /// ita passe ape start location akai end location akai deela a athara route tika aran tinawa
    ///
    Directions directions = await getDirections(
        _startLocation!.latitude,
        _startLocation!.longitude,
        _endLocation!.latitude,
        _endLocation!.longitude);

    /// methana if aken check karala tiyenne google aken hariyata roue awada kila
    /// hariyata awnm witharai ithuru awa karanne
    if (directions.ok) {
      /// ketima route aka gannawa methanin
      final route = directions.shortestRoute;

      /// methanin pallehata route ake line aka adinawa
      List<LatLng> points = PolylinePoints()
          .decodePolyline(route.overviewPolyline.points)
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();
      List<Polyline> polyline = [
        Polyline(
          width: 5,
          polylineId: PolylineId("UNIQUE_ROUTE_ID"),
          color: Colors.blue,
          points: points,
        ), //polyline
      ];
      setState(() {
        _routeCordinates = points;
        _polyline = Set.of(polyline);
      });
    }
  }

  Future<void> _saveRoute() async {
    if (routeNameController.text == "" || routeNameController.text == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please enter route name")));
      return;
    }
    if (_routeCordinates.isNotEmpty) {
      final List<GeoPoint> routeData = _routeCordinates
          .map((e) => GeoPoint(e.latitude, e.longitude))
          .toList();
      final start =
          GeoPoint(_startLocation!.latitude, _startLocation!.longitude);
      final end = GeoPoint(_endLocation!.latitude, _endLocation!.longitude);
      final routeService = RouteService(widget.childId);
      await routeService.saveRoute(
          routeNameController.text, routeData, start, end);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Rute saved.")));
      context.go('/child/${widget.childId}');
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please select route.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Route"),
        leading: IconButton(onPressed: (){
          context.go('/child/${widget.childId}');
        }, icon: Icon(Icons.arrow_back)),
      ),
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
                    onTap: _onTap,
                    markers: _markers,
                    polylines: _polyline,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: routeNameController,
                  decoration: const InputDecoration(
                    labelText: "Route name",
                    border: OutlineInputBorder(),
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveRoute,
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
