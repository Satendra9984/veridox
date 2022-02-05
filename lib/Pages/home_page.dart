import 'package:flutter/material.dart';
import 'package:veridox/Pages/login_page.dart';

<<<<<<< HEAD
=======

>>>>>>> 7443d58826d3d21af8a791c74f458e7c3d8d217b
class HomePage extends StatelessWidget {
  static String homePageName = 'homePage';

  const HomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              )
            ),
              onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LogInPage()));
          }, child: const Text('Log In')),
        ],
      ),
    );
  }
}