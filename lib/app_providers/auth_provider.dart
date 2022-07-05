import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import '../app_screens/login/otp_page.dart';
import '../app_utils/app_functions.dart';

class CustomAuthProvider extends ChangeNotifier {
  String _phoneNumber = '';
  String _id = '';
  String _otp = '';
  bool isLoading = false;
  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 60);

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    // setState(() {
    final seconds = myDuration.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
    } else {
      myDuration = Duration(seconds: seconds);
    }
    notifyListeners();
    // });
  }

  void stopTimer() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
    notifyListeners();
  }

  // Step 5
  void resetTimer() {
    stopTimer();
    myDuration = const Duration(seconds: 60);
    notifyListeners();
  }

  final SPServices _spServices = SPServices();

  void setPhoneNumber(String num) {
    _phoneNumber = num;
    notifyListeners();
  }

  void setOTP(String otp) {
    _otp = otp;
  }

  void setOtp(String otp) {
    _otp = otp;
    notifyListeners();
  }

  String get phoneNumber {
    return _phoneNumber;
  }

  Future<void> verifyCredential(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    if (FirebaseAuth.instance.currentUser == null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _id,
        smsCode: _otp,
      );
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .catchError((err) {
        isLoading = false;
        notifyListeners();
      });
      await _spServices.setLogInCredentials(credential);
    } else {
      await FirebaseAuth.instance.signOut().then(
        (value) async {
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: _id,
            smsCode: _otp,
          );
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .catchError(
            (err) {
              isLoading = false;
              notifyListeners();
            },
          );
          await _spServices.setLogInCredentials(credential);
        },
      );
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> signInWithPhone(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance
        .verifyPhoneNumber(
      phoneNumber: "+91$_phoneNumber",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException authException) async {
        isLoading = false;
        notifyListeners();
      },
      codeSent: (String verificationId, int? token) async {
        _id = verificationId;
        isLoading = false;
        resetTimer();
        startTimer();
        notifyListeners();
        navigateTo(context);
      },
      codeAutoRetrievalTimeout: (verificationID) async {
        isLoading = false;
        notifyListeners();
      },
    )
        .catchError((error) {
      isLoading = false;
      notifyListeners();
    });
  }

  navigateTo(BuildContext context) {
    if (ModalRoute.of(context)?.settings.name != OTPPage.otpRouteName) {
      navigatePushReplacement(context, const OTPPage());
    }
  }
}
