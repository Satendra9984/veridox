import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import 'package:veridox/app_utils/app_functions.dart';
import '../../form_screens/home_page.dart';
import '../assignments_home_page.dart';
import '../login/login_page.dart';

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
      navigatePushReplacement(context, const AssignmentsHomePage());
    } else {
      debugPrint('not logged in --> \n');
      navigatePushReplacement(context, const LogInPage());
    }
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
