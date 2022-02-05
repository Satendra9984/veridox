import 'package:flutter/material.dart';
import 'package:veridox/Pages/login_page.dart';

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