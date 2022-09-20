import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _currentLocation;
  String _address = "";

  Future<LocationData?> _getLocationData() async {
    final Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await location.serviceEnabled();

    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
    } else {
      return null;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    _currentLocation = await location.getLocation();
    return _currentLocation;
  }

  Future<String> _getAddress(double? lat, double? long) async {
    if (lat == null && long == null) return "";

    GeoCode _geoCode = GeoCode();
    Address address =
        await _geoCode.reverseGeocoding(latitude: lat!, longitude: long!);

    String add =
        "${address.streetNumber} ${address.streetAddress} ${address.city} ${address.countryName} ${address.postal}";
    _address = add;
    return add;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_currentLocation != null)
                Text(
                    "Location: ${_currentLocation?.latitude}, ${_currentLocation?.longitude}"),
              if (_currentLocation != null) Text("Address: $_address"),
              MaterialButton(
                onPressed: () {
                  _getLocationData().then((value) {
                    LocationData? location = value;
                    _getAddress(location?.latitude, location?.longitude)
                        .then((value) {
                      setState(() {
                        _currentLocation = location;
                        _address = value;
                      });
                    });
                  });
                },
                color: Colors.purple,
                child: const Text(
                  "Get Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
