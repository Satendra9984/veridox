import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:veridox/app_screens/on_boarding/on_boarding_screen.dart';

class EnablePermissionPage extends StatefulWidget {
  const EnablePermissionPage({Key? key}) : super(key: key);

  @override
  State<EnablePermissionPage> createState() => _EnablePermissionPageState();
}

class _EnablePermissionPageState extends State<EnablePermissionPage>
    with WidgetsBindingObserver {
  bool _isLocationPermissionEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // debugPrint('dependency has changed\n\n');
    _initLocationService();
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState lifecycleState) async {
    if (lifecycleState == AppLifecycleState.detached) {
      // debugPrint('Applifecyclestate is detached');
    } else if (lifecycleState == AppLifecycleState.inactive) {
      // debugPrint('Applifecyclestate is inactive');
    } else if (lifecycleState == AppLifecycleState.paused) {
      // debugPrint('Applifecyclestate is paused');
    } else if (lifecycleState == AppLifecycleState.resumed) {
      // debugPrint('Applifecyclestate is resumed');
      await _initLocationService();
    }
  }

  Future<void> _initLocationService() async {
    var location = Location();

    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {}
    }
    PermissionStatus permission = await location.hasPermission();
    // debugPrint('permission ${permission}\n\n');

    if (permission == PermissionStatus.granted) {
      Navigator.of(context)
          .push(CupertinoPageRoute(builder: (context) => OnBoardingScreen()));
    } else if (permission == PermissionStatus.denied) {
      // debugPrint('permission denied\n\n');

      if (Navigator.canPop(context)) {
        // debugPrint('can pop\n\n');
        Navigator.popUntil(context, ModalRoute.withName("/"));
      }
      permission = await location.requestPermission();
      if (permission == PermissionStatus.granted) {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (context) => OnBoardingScreen()));
      }
    }
    // var loc = await GeoLocation.getLocation();
    // print("${loc.latitude} ${loc.longitude}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 84,
          width: 154,
          margin:
              const EdgeInsets.only(right: 8.0, left: 15, top: 4, bottom: 4),
          child: Image.asset(
            'assets/launcher_icons/veridocs_launcher_icon.jpeg',
            fit: BoxFit.contain,
            height: 84,
            width: 134,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              color: CupertinoColors.destructiveRed,
              size: 44,
            ),
            const SizedBox(height: 15),
            Text(
              'Location Services are not enabled for this app !\n'
              'Please enable it to use the app.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'go to settings --> app permission --> allow',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
