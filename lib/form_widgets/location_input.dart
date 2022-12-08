import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:veridox/app_utils/app_constants.dart';
import 'package:veridox/form_widgets/show_map.dart';
import '../app_providers/form_provider.dart';

class GetUserLocation extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final FormProvider provider;
  final String pageId;
  final String fieldId;
  const GetUserLocation({
    Key? key,
    required this.pageId,
    required this.fieldId,
    required this.provider,
    required this.widgetJson,
  }) : super(key: key);

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  Position? _currentLocation;
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

  void _addData() {
    if (_currentLocation != null) {
      String coordinates =
          '${_currentLocation!.latitude},${_currentLocation!.longitude}';
      widget.provider.updateData(
          pageId: widget.pageId, fieldId: widget.fieldId, value: coordinates);
    }
  }

  Future<void> _initializeSignatureFromDatabase() async {
    String? coordinates =
        widget.provider.getResult['${widget.pageId},${widget.fieldId}'];

    if (coordinates != null) {
      List<String> loca = coordinates.split(',');
      _currentLocation = Position(
        longitude: double.parse(loca[1]),
        latitude: double.parse(loca[0]),
        timestamp: null,
        accuracy: 0.0,
        altitude: 0.0,
        heading: 0.0,
        speed: 0.0,
        speedAccuracy: 0.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: containerElevationDecoration,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.only(bottom: 15),
      child: FutureBuilder(
          future: _initializeSignatureFromDatabase(),
          builder: (context, AsyncSnapshot<void> form) {
            if (form.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return FormField(
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
                        style: kFormWidgetLabelStyle,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                              child: GestureDetector(
                                onTap: () async {
                                  if (_currentLocation != null) {
                                    Navigator.of(context).push(
                                      CupertinoPageRoute(
                                        builder: (context) {
                                          double? lat =
                                              _currentLocation!.latitude;
                                          double? long =
                                              _currentLocation!.longitude;
                                          return ShowMapScreen(
                                            lat: lat,
                                            longi: long,
                                          );
                                        },
                                      ),
                                    );
                                  }
                                },
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
                                      Position? location = value;
                                      await _getAddress(location?.latitude,
                                              location?.longitude)
                                          .then((value) {
                                        setState(() {
                                          _currentLocation = location;
                                          _address = value;
                                          _gettingLocation = false;
                                        });
                                        _addData();
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 8),
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
              );
            }
          }),
    );
  }

  Future<Position?> _getLocation() async {
    Location location = Location();
    Position _locationData;

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

    _locationData = await Geolocator.getCurrentPosition();
    debugPrint(
        'lat --> ${_locationData.latitude}, long --> ${_locationData.longitude}');
    return _locationData;
  }

  Future<String> _getAddress(double? lat, double? lang) async {
    if (lat == null || lang == null) return "";
    GeoCode geoCode = GeoCode();
    debugPrint("lat $lat, long $lang");
    Address address =
        await geoCode.reverseGeocoding(latitude: lat, longitude: lang);

    return "${address.streetAddress}, ${address.city}, ${address.countryName}, ${address.postal}";
  }
}
