import 'package:flutter/material.dart';
import 'package:veridox/Pages/login_page.dart';

class HomePage extends StatelessWidget {
  static String homePageName = 'homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, LogInPage.logInPageName);
                },
                child: const Text('Log In'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
