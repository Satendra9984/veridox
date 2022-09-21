import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:veridox/app_utils/app_constants.dart';

class GetUserLocation extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  const GetUserLocation({
    Key? key,
    required this.widgetJson,
  }) : super(key: key);

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  LocationData? _currentLocation;
  bool _gettingLocation = false;
  String _address = "";

  String _getLabel() {
    String label = widget.widgetJson['label'];

    if (widget.widgetJson.containsKey('required') &&
        widget.widgetJson['required'] == true) {
      label += '*';
      debugPrint('$label \n\n');
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerElevationDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.only(bottom: 15),
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _currentLocation,
        validator: (val) {
          if (widget.widgetJson.containsKey('required') &&
              widget.widgetJson['required'] &&
              _currentLocation == null) {
            return 'Please enter address';
          }
          return null;
        },
        builder: (formState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                _getLabel(),
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_gettingLocation)
                    const Expanded(
                      flex: 8,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  if (_currentLocation != null && !_gettingLocation)
                    Expanded(
                      flex: 8,
                      child: Column(
                        children: [
                          Text(
                            "Location: ${_currentLocation?.latitude}, ${_currentLocation?.longitude}",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Address: $_address",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_currentLocation == null)
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.location_on,
                            size: 38,
                            color: CupertinoColors.systemGreen,
                          ),
                          onPressed: () async {
                            setState(() {
                              _gettingLocation = true;
                            });
                            await _getLocation().then((value) async {
                              LocationData? location = value;
                              await _getAddress(
                                      location?.latitude, location?.longitude)
                                  .then((value) {
                                setState(() {
                                  _currentLocation = location;
                                  _address = value;
                                  _gettingLocation = false;
                                });
                                formState.didChange(_currentLocation);
                              });
                            });
                          },
                          color: Colors.purple,
                        ),
                      ),
                    ),
                  if (_currentLocation != null)
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            FontAwesomeIcons.xmark,
                            size: 38,
                            color: CupertinoColors.destructiveRed,
                          ),
                          onPressed: () {
                            setState(() {
                              _currentLocation = null;
                            });
                          },
                        ),
                      ),
                    ),
                ],
              ),
              if (formState.hasError)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: CupertinoColors.systemRed,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formState.errorText!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemRed,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  // _getLocation1() async {
  //   Position position =
  //       await Geolocator.getCurrentPosition();
  //   debugPrint('location: ${position.latitude}');
  //   List<Placemark> addresses =
  //       await placemarkFromCoordinates(position.latitude, position.longitude);
  //
  //   var first = addresses.first;
  //   print("${first.name} : ${first..administrativeArea}");
  // }
  //
  Future<LocationData?> _getLocation() async {
    Location location = Location();
    LocationData _locationData;

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  Future<String> _getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lang);

    return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  }
}
