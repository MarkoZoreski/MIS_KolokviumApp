import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class MapScreen extends StatefulWidget {
  static const routeName = 'locationSelectScreen';
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late LatLng selectedLocation;
  late MapController _mapController;
  List<Marker> _markers = [];

  void _handleTap(TapPosition tapPosition, LatLng point) {
    setState(() {
      _markers.clear();
      _markers.add(Marker(
        width: 80.0,
        height: 80.0,
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Location'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).pop(_markers.first.point);
            },
          ),
        ],
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(42.004204515826544, 21.40954342273825), // Finki
          zoom: 15,
          onTap: _handleTap,
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

