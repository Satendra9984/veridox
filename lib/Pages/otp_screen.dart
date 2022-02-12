import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:veridox/Elements/submit_button.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key,required this.number, required this.id}) : super(key: key);
  final String id;
  final String number;
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {

  final TextEditingController _pinputController = TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Type the code sent to",
                    style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),),
                  const SizedBox(
                    height: 12,
                  ),
                  Text("+91-${widget.number.toString()}",
                    style: const TextStyle(color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),),
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
                  const SizedBox(height: 30,),
                  SubmitButton(text: "Submit", onPress: () {
                    signInUser();
                  })
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
  void signInUser() async {
    PhoneAuthCredential _credential = PhoneAuthProvider.credential(verificationId: widget.id, smsCode: _pinputController.text);
    await FirebaseAuth.instance.signInWithCredential(_credential);
  }
}
