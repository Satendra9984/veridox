import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_utils/app_functions.dart';

import '../../app_providers/auth_provider.dart';
import '../../app_widgets/submit_button.dart';
import '../assignments_home_page.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late CustomAuthProvider _provider;

  final TextEditingController _pinputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _provider = Provider.of<CustomAuthProvider>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = Provider.of<CustomAuthProvider>(context);
  }

  PinTheme get _pinPutDecoration {
    return PinTheme(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
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
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('otp'),
      ),
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
                  "+91-${_provider.phoneNumber}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 27,
                ),
                Pinput(
                  length: 6,
                  controller: _pinputController,
                  submittedPinTheme: _pinPutDecoration.copyWith(
                    // color: Colors.white.withOpacity(0.9),
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
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30, width: 742),
                SubmitButton(
                  text: "Submit",
                  onPress: () async {
                    await _provider.verifyCredential(context).then(
                          (value) => navigatePushReplacement(
                            context,
                            const AssignmentsHomePage(),
                          ),
                        );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
