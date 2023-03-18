import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lab3/service/MapService.dart';
import 'package:latlong2/latlong.dart';
import 'package:positioned_tap_detector_2/positioned_tap_detector_2.dart';

class UserMarkers extends StatefulWidget {
  static const routeName = 'userMarkers';
  @override
  _UserMarkersState createState() => _UserMarkersState();
}

class _UserMarkersState extends State<UserMarkers> {
  late MapController _mapController;
  LatLng _selectedLocation = LatLng(0, 0);
  List<Marker> _markers = [];
  late bool firstTime;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    firstTime = true;
  }
  void _handleMarkerTap(LatLng location) async{
    setState(() {
      _selectedLocation = location;
    });

  }

  @override
  Widget build(BuildContext context) {
    List<Marker> _userMarkers = ModalRoute.of(context)?.settings.arguments as List<Marker>;
    if(_userMarkers.isNotEmpty && firstTime) {
      _selectedLocation = _userMarkers.first.point;
      firstTime = false;
    }
    return Scaffold(
      appBar:  _userMarkers.isNotEmpty ? AppBar(
        title: Text('Select a location to calculate route',
          style: TextStyle(fontSize: 14),),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () async{
              final mapService = MapService.instance;
              await mapService.openMap(_selectedLocation.longitude, _selectedLocation.latitude);
            },
          ),
        ],
      ):
      AppBar(
        title: Text('There are no Event Locations',)
      ),
      body: FlutterMap(
        options: MapOptions(
          center: LatLng(42.004204515826544, 21.40954342273825), // Finki
          zoom: 14,
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
          _userMarkers.isNotEmpty ?
          MarkerLayer(
            markers: _userMarkers.map((marker) => Marker(
              point: marker.point,
              builder: (ctx) => GestureDetector(
                onTap: () => _handleMarkerTap(marker.point),
                child: Container(
                  child: Icon(
                    Icons.location_pin,
                    size: 50.0,
                    color: _selectedLocation == marker.point
                        ? Colors.blue
                        : Colors.red,
                  ),
                ),
              ),
            )).toList(),
          )
              :
              MarkerLayer(markers: _markers)
        ],
      ),
    );
  }
}

