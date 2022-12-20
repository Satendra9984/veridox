import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_screens/profile/send_request_screen.dart';
import 'package:veridox/app_screens/profile/status_screen.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import 'package:veridox/app_utils/app_functions.dart';
import '../home_page.dart';
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

    if (uid != null && token != null) {
      /// checking if field verifier already exists
      await FirestoreServices.checkIfRequested(uid).then((value) async {
        if (value) {
          /// requested
          // debugPrint('requested\n');
          navigatePushReplacement(context, StatusScreen(uid: uid));
        } else {
          /// not requested
          // debugPrint('not requested requested\n');

          await FirestoreServices.checkIfFvExists(uid).then((value) {
            if (value) {
              /// field verifier exists
              // debugPrint('field verifier existes\n');

              navigatePushReplacement(context, HomePage());
            } else {
              /// nor exists neither requested(fresh case)
              // debugPrint('fresh new case\n');
              navigatePushReplacement(context, SendRequestScreen());
            }
          });
        }
      });
    } else {
      navigatePushReplacement(context, LogInPage());
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
              'Veridocs',
              style: TextStyle(fontSize: 60.0),
            ),
          ),
        ],
      ),
    );
  }
}
