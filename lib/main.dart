import 'package:flutter/material.dart';
import 'package:veridox/Pages/assignment_list.dart';
import 'package:veridox/Pages/assignments_home_page.dart';
import 'package:veridox/Pages/home_page.dart';
import 'package:veridox/Pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:veridox/models/assignment_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
          initialData: null,
          create: (_) {
            return FirebaseAuth.instance.authStateChanges();
          },
          child: const MyApp(),
        ),

        ChangeNotifierProvider(create: (ctx) => AssignmentProvider()),
      ],
      child: MaterialApp(
        title: 'Veridox',
        theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: const Color(0XFFC925E3),
          primarySwatch: Colors.purple,
        ),
        home: const AssignmentsHomePage(),

        routes: {
          HomePage.homePageName: (context) => const HomePage(),
          LogInPage.logInPageName: (context) => const LogInPage(),
          SignUp.signUpPageName: (context) => const SignUp(),
          AssignmentsHomePage.assignmentsHomePage: (context) =>
              const AssignmentsHomePage(),
        },
      ),
    );
  }
}
