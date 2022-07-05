import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_screens/login/login_page.dart';
import 'package:veridox/app_screens/sign_up/send_request_screen.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import 'package:veridox/app_utils/app_functions.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late bool loggedIn;
  final SPServices _spServices = SPServices();

  void initialization() async {
    final auth = FirebaseAuth.instance;
    final uid = auth.currentUser?.uid;
    final String? token = await _spServices.getToken();
    if (kDebugMode) {
      print('uid: $uid token: $token');
    }
    if (uid != null && token != null) {
      loggedIn = true;
      debugPrint('loggedIn-->\n');
    } else {
      loggedIn = false;
    }
    await Future.delayed(const Duration(seconds: 1), navigate);
  }

  void navigate() {
    if (loggedIn) {
      navigatePushReplacement(context, const SendRequestScreen());
    } else {
      navigatePushReplacement(context, const LogInPage());
    }
    // navigatePushReplacement(context, const SendRequestScreen());
  }

  @override
  void initState() {
    initialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Center(
            child: Text(
              'Veridox',
              style: TextStyle(fontSize: 60.0),
            ),
          ),
        ],
      ),
    );
  }
}
