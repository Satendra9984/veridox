import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_screens/profile/send_request_screen.dart';
import 'package:veridox/app_screens/profile/status_screen.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import 'package:veridox/app_utils/app_functions.dart';
import '../../form_screens/home_page.dart';
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
      await FirestoreServices.checkIfFvExists(uid).then((value) async {
        if (value) {
          /// if field verifier exists then navigate it to HomePage
          navigatePushReplacement(context, const HomePage());
        } else {
          /// Or checking if it had sent a request to join any agency
          bool requested =
              await FirestoreServices.checkIfRequested(uid);
          if (requested) {
            navigatePushReplacement(context, StatusScreen(uid: uid));
          } else {
            navigatePushReplacement(
              context,
              const SendRequestScreen(),
            );
          }
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
