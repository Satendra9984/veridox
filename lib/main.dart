import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:veridox/Pages/login_page.dart';
=======
import 'package:veridox/Pages/home_page.dart';
import 'package:veridox/Pages/login_page.dart';
import 'package:veridox/Pages/signup_page.dart';
>>>>>>> 7443d58826d3d21af8a791c74f458e7c3d8d217b

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return const MaterialApp(
      title: 'Veridox',
      home: LogInPage(),
    );
  }
}
=======
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
>>>>>>> 7443d58826d3d21af8a791c74f458e7c3d8d217b
