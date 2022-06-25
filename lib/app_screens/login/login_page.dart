import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_providers/auth_provider.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import 'package:veridox/app_widgets/submit_button.dart';
import 'package:veridox/app_widgets/text_input.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late String id;
  final SPServices prefs = SPServices();

  late CustomAuthProvider _provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _provider = Provider.of<CustomAuthProvider>(context);
    super.didChangeDependencies();
  }

  final TextEditingController _phoneController = TextEditingController();
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _phoneController.dispose();
    // _pinputController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFf0f5ff),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.all(15),
          child: SubmitButton(
            text: 'Log In',
            onPress: () {
              _provider.setPhoneNumber(_phoneController.text);
              if (kDebugMode) {}
              _provider.signInWithPhone(context);
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0XFFf0f5ff), Colors.white],
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'Verify\nPhone',
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF0e4a86)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'To the agency you want to join',
                          style: TextStyle(fontSize: 27),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      CustomTextInput(
                          controller: _phoneController,
                          text: "Phone Number",
                          keyboardType: TextInputType.number,
                          password: false),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 7),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.transparent, elevation: 0),
                              child: const Text(
                                "Having issues?",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),

                  // SubmitButton(
                  //   text: 'Log In',
                  //   onPress: () {
                  //     setState(() {});
                  //     _provider.signInWithPhone(context);
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
