import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShowMapScreen extends StatefulWidget {
  final double lat, longi;
  const ShowMapScreen({
    Key? key,
    required this.lat,
    required this.longi,
  }) : super(key: key);

  @override
  State<ShowMapScreen> createState() => _ShowMapScreenState();
}

class _ShowMapScreenState extends State<ShowMapScreen> {
  late GoogleMapController _googleMapController;

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  late final LatLng _center;
  @override
  void initState() {
    // TODO: implement initState
    _center = LatLng((widget.lat), (widget.longi));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 11.0,
        ),
      ),
    );
  }
}
