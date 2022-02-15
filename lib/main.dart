import 'package:flutter/material.dart';
import 'package:veridox/Pages/assignment_list.dart';
import 'package:veridox/Pages/assignments_home_page.dart';
import 'package:veridox/Pages/home_page.dart';
import 'package:veridox/Pages/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
// import 'package:veridox/Pages/sign_up.dart';
import 'package:veridox/Pages/signup_page.dart';
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
        StreamProvider.value(
            value: FirebaseAuth.instance.authStateChanges(), initialData: null),
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
        // home: const LogInPage(),
        // home: SignUp(),
        // home: HomePage(),

        routes: {
          HomePage.homePageName: (context) => const HomePage(),
          LogInPage.logInPageName: (context) => const LogInPage(),
          SignUp.signUpPageName: (context) => const SignUp(),
          AssignmentsHomePage.assignmentsHomePage: (context) =>
              const AssignmentsHomePage(),
          // AssignmentList.assignmentListPage: (context) => AssignmentList(controller: null,),
        },
      ),
    );
  }
}
