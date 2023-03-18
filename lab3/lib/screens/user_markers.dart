import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class UserMarkers extends StatefulWidget {
  static const routeName = 'userMarkers';
  @override
  _UserMarkersState createState() => _UserMarkersState();
}

class _UserMarkersState extends State<UserMarkers> {
  late MapController _mapController;
  List<Marker> _markers = [];

  void _handleTap(TapPosition tapPosition, LatLng point) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        width: 100.0,
        height: 100.0,
        point: point,
        builder: (ctx) => Container(
          child: Icon(Icons.location_pin, color: Colors.red),
        ),
      ));
    });
  }

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    _markers = ModalRoute.of(context)?.settings.arguments as List<Marker>;
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a location to calculate route',
          style: TextStyle(fontSize: 14),),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.check),
        //     onPressed: () {
        //
        //     },
        //   ),
        // ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(42.004204515826544, 21.40954342273825), // Finki
          zoom: 15,
        ),
        mapController: _mapController,
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(markers: _markers,)
        ],
      ),
    );
  }
}

