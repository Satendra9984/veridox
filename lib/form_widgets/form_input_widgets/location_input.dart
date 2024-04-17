import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:veridox/app_utils/app_constants.dart';
import 'package:veridox/form_widgets/form_input_widgets/show_map.dart';
import '../../app_providers/form_provider.dart';
import '../../form_screens/form_constants.dart';

class GetUserLocation extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final FormProvider provider;
  final String pageId;
  final String fieldId;
  final String? rowId;
  final String? colId;
  const GetUserLocation({
    Key? key,
    required this.pageId,
    required this.fieldId,
    required this.provider,
    required this.widgetJson,
    this.rowId,
    this.colId,
  }) : super(key: key);

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  Position? _currentLocation;
  bool _gettingLocation = false;
  String _address = "";

  @override
  void initState() {
    // TODO: implement initState
    _initializeSignatureFromDatabase();
    super.initState();
  }

  Widget _getLabel() {
    String label = widget.widgetJson['label'];

    return RichText(
      text: TextSpan(
        text: '$label',
        style: const TextStyle(
          fontSize: kLabelFontSize,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        children: [
          if (widget.widgetJson.containsKey('required') &&
              widget.widgetJson['required'] == true)
            TextSpan(
              text: ' *',
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: kLabelFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  void _addData() {
    if (_currentLocation != null) {
      String coordinates =
          '${_currentLocation!.latitude},${_currentLocation!.longitude}';
      widget.provider.updateData(
          rowId: widget.rowId,
          columnId: widget.colId,
          pageId: widget.pageId,
          fieldId: widget.fieldId,
          value: coordinates);
    }
  }

  void _initializeSignatureFromDatabase() {
    debugPrint('initial location called');
    String? coordinates;
    if (widget.rowId == null) {
      coordinates =
          widget.provider.getResult['${widget.pageId},${widget.fieldId}'];
    } else {
      coordinates = widget.provider.getResult[
          '${widget.pageId},${widget.fieldId},${widget.rowId},${widget.colId}'];
    }
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
      height: 115,
      decoration: widget.rowId == null ? containerElevationDecoration : null,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _getLabel(),
              const SizedBox(
                height: 15,
              ),
              if (_gettingLocation)
                Center(
                  child: CircularProgressIndicator(),
                ),
              if (_currentLocation != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 8,
                      child: GestureDetector(
                        onTap: () async {
                          if (_currentLocation != null) {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) {
                                  double? lat = _currentLocation!.latitude;
                                  double? long = _currentLocation!.longitude;
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
                            Row(
                              children: [
                                Text(
                                  'Lati :   ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${_currentLocation!.latitude}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Longi :   ',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${_currentLocation!.longitude}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
                              // widget.provider.getResult['${widget.pageId},${widget.fieldId}'] = null;
                              widget.provider.updateData(
                                pageId: widget.pageId,
                                fieldId: widget.fieldId,
                                value: null,
                              );
                              _currentLocation = null;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              if (_currentLocation == null && _gettingLocation == false)
                GestureDetector(
                  onTap: () async {
                    setState(() {
                      _gettingLocation = true;
                    });
                    await _getLocation().then((value) async {
                      Position? location = value;
                      setState(() {
                        _currentLocation = location;
                        _gettingLocation = false;
                      });

                      _addData();
                      formState.didChange(_currentLocation);
                      // await _getAddress(location?.latitude,
                      //         location?.longitude)
                      //     .then((value) {
                      //   setState(() {
                      //     _address = value;
                      //   });

                      // });
                    });
                  },
                  child: Container(
                    width: 60,
                    constraints: BoxConstraints.tightForFinite(),
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.add_location_outlined,
                      // size: 30,
                      color: CupertinoColors.white,
                    ),
                  ),
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
