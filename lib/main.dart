import 'package:flutter/material.dart';
import 'package:veridox/Pages/home_page.dart';
import 'package:veridox/Pages/login_page.dart';
import 'package:veridox/Pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Veridox',
      home: HomePage(),
      routes: {
        HomePage.homePageName: (context) => HomePage(),
        LogInPage.logInPageName: (context) => LogInPage(),
        SignUp.signUpPageName: (context) => SignUp(),
      },
    );
  }
}
