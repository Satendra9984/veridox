import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_utils/app_functions.dart';
import '../../app_providers/auth_provider.dart';
import '../../app_widgets/submit_button.dart';
import '../../form_screens/home_page.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);
  static const String otpRouteName = 'OTPPage';
  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late CustomAuthProvider _provider;

  final TextEditingController _pinputController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = Provider.of<CustomAuthProvider>(context);
    // _provider.startTimer();
  }

  PinTheme get _pinPutDecoration {
    return PinTheme(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.4),
            blurRadius: 2.5,
            offset: const Offset(1, 7),
          ),
        ],
        color: Colors.white,
        border: Border.all(color: Colors.blueGrey, width: 1.4),
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final seconds = strDigits(_provider.myDuration.inSeconds.remainder(60));

    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.all(15),
        child: _provider.isLoading
            ? SubmitButton(
                text: 'Verifying',
                color: Colors.blueGrey,
                onPress: () {},
                loading: const SizedBox(
                  width: 17,
                  height: 17,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : SubmitButton(
                text: "Verify OTP",
                onPress: () async {
                  _provider.setOTP(_pinputController.text);
                  await _provider
                      .verifyCredential(context)
                      .then(
                        (value) => navigatePushReplacement(
                            context,

                            /// TODO: CHANGE IT
                            // const AssignmentsHomePage(),
                            /// todo: only for testing purpose
                            FormHomePage(
                              formId: '1',
                            )),
                      )
                      .catchError((error) {
                    SnackBar snackBar = const SnackBar(
                      content: Text('Something went wrong. Try again'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  });
                },
              ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(30.0),
            padding: const EdgeInsets.all(30.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Text(
                        "Enter Your Verification Code",
                        style: TextStyle(
                          color: Color(0XFF0e4a86),
                          // color: CupertinoColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  "We had sent a verification code to +91-${_provider.phoneNumber}",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    // color: Color(0XFF0e4a86),
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 27,
                ),
                Pinput(
                  length: 6,
                  controller: _pinputController,
                  submittedPinTheme: _pinPutDecoration.copyWith(
                    decoration: _pinPutDecoration.decoration?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  focusedPinTheme: _pinPutDecoration,
                  followingPinTheme: _pinPutDecoration.copyWith(
                    decoration: _pinPutDecoration.decoration?.copyWith(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        width: 2.3,
                        color: const Color(0XFF0e4a86),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30, width: 742),
                TextButton(
                  onPressed: () async {
                    if (seconds == '00') {
                      await _provider.signInWithPhone(context);
                    }
                  },
                  child: Text(
                    'Resend OTP  ${seconds == '00' ? '' : seconds}',
                    style: const TextStyle(
                      // color: Colors.grey.shade700,
                      color: Color(0XFF0e4a86),
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
