import 'package:flutter/material.dart';
import 'package:veridox/app_providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_providers/assignment_provider.dart';
import 'package:veridox/app_providers/saved_assignment_provider.dart';
import 'package:veridox/app_screens/login/otp_page.dart';
import 'package:veridox/app_screens/on_boarding/on_boarding_screen.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'app_models/assignment_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
            create: (context) => FirebaseAuth.instance.authStateChanges(),
            initialData: null),
        StreamProvider<List<Assignment>>(
            create: (context) => FirestoreServices.getAssignments(),
            initialData: const []),
        ChangeNotifierProvider<AssignmentProvider>(
            create: (context) => AssignmentProvider()),
        ChangeNotifierProvider<SavedAssignmentProvider>(
            create: (context) => SavedAssignmentProvider()),
        ChangeNotifierProvider<CustomAuthProvider>(
            create: (context) => CustomAuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Veridox',
        theme: ThemeData(
            // fontFamily: 'Roboto',
            primaryColor: Colors.lightBlue,
            primarySwatch: Colors.blue,
            textTheme: const TextTheme()
            // fontFamily:
            ),
        // home: const OnBoardingScreen(),
        routes: {
          '/': (context) => const OnBoardingScreen(),
          OTPPage.otpRouteName: (context) => const OTPPage(),
        },
      ),
    );
  }
}
// onst Color(0XFFC925E3)
