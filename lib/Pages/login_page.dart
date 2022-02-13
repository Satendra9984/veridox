import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/Elements/submit_button.dart';
import 'package:veridox/Elements/text_input.dart';
import 'package:veridox/Pages/assignments_home_page.dart';
import 'package:veridox/Pages/otp_screen.dart';

class LogInPage extends StatefulWidget {
  static String logInPageName = 'loginInPage';

  const LogInPage({Key? key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  void signInWithPhone() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "+91${_phoneController.text}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance.signInWithCredential(credential);
          Navigator.push(context, CupertinoPageRoute(builder: (context) => AssignmentsHomePage()));
        },
        verificationFailed: (FirebaseAuthException _authException) async {
          print(_authException.message);
        },
        codeSent: (String verificationId, int? token) async {
          Navigator.push(context, CupertinoPageRoute(builder: (context) => OTPScreen(id: verificationId, number: _phoneController.text,)));
        },
        codeAutoRetrievalTimeout: (verificationID) async {
          print(verificationID);
        }
    );
  }
  final TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      color: Colors.grey.withOpacity(0.5),
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
                    children: [
                      // const CustomTextInput(
                      //     text: "Email",
                      //     keyboardType: TextInputType.text,
                      //     password: false),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      CustomTextInput(
                        controller: _phoneController,
                          text: "Phone Number",
                          keyboardType: TextInputType.number,
                          password: false),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // const CustomTextInput(
                      //     text: "Password",
                      //     keyboardType: TextInputType.text,
                      //     password: true),
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
                      SubmitButton(text: 'Log In', onPress: () {
                        signInWithPhone();
                      },),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
