import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import 'package:veridox/app_widgets/submit_button.dart';
import 'package:veridox/app_widgets/text_input.dart';
import '../assignments_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogInPage extends StatefulWidget {
  static String logInPageName = 'loginInPage';

  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late String id;
  final SPServices prefs = SPServices();

  void signInWithPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91${_phoneController.text}",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        if (FirebaseAuth.instance.currentUser == null) {
          FirebaseFirestore.instance.collection('users');
          final user = Provider.of<User?>(context);
          // print('${user?.uid}');
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => const AssignmentsHomePage(),
            ),
          );
        }
      },
      verificationFailed: (FirebaseAuthException _authException) async {},
      codeSent: (String verificationId, int? token) async {
        id = verificationId;
        _pageController.jumpToPage(1);
      },
      codeAutoRetrievalTimeout: (verificationID) async {},
    );
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          spreadRadius: 1,
          color: Colors.black.withOpacity(0.4),
          blurRadius: 10,
          offset: const Offset(1, 7),
        ),
      ],
      color: Colors.white,
      border: Border.all(color: Colors.deepPurpleAccent),
      borderRadius: BorderRadius.circular(15.0),
    );
  }

  void changeScreen() async {
    if (FirebaseAuth.instance.currentUser == null) {
      PhoneAuthCredential _credential = PhoneAuthProvider.credential(
          verificationId: id, smsCode: _pinputController.text);
      await FirebaseAuth.instance.signInWithCredential(_credential);
      await prefs.setLogInCredentials(_credential);
    }
    Navigator.pushReplacement(context,
        CupertinoPageRoute(builder: (context) => const AssignmentsHomePage()));
  }

  void saveLogInData() async {

  }

  final TextEditingController _pinputController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _phoneController.dispose();
    _pinputController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.cyanAccent,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(30.0),
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 19,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(9.0),
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0XFFC925E3),
                          Color(0XFF256CBF),
                        ],
                      ),
                    ),
                    child: Column(
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
                        const SizedBox(
                          height: 20,
                        ),
                        SubmitButton(
                          text: 'Log In',
                          onPress: () {
                            signInWithPhone();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.all(30.0),
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 0,
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 19,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(9.0),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0XFFC925E3),
                            Color(0XFF256CBF),
                          ]),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Type the code sent to",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "+91-${_phoneController.text}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 27,
                        ),
                        PinPut(
                          fieldsCount: 6,
                          controller: _pinputController,
                          submittedFieldDecoration: _pinPutDecoration.copyWith(
                            color: Colors.white.withOpacity(0.9),
                          ),
                          selectedFieldDecoration: _pinPutDecoration,
                          followingFieldDecoration: _pinPutDecoration.copyWith(
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              width: 2.3,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SubmitButton(
                          text: "Submit",
                          onPress: () {
                            changeScreen();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
