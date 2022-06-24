import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:veridox/app_screens/assignments_home_page.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import '../app_screens/login/otp_page.dart';
import '../app_utils/app_functions.dart';

class CustomAuthProvider extends ChangeNotifier {
  // AuthProvider({}) : super(create: );
  String _phoneNumber = '';
  String _id = '';
  String _otp = '';
  bool isLoading = false;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SPServices _spServices = SPServices();

  void setPhoneNumber(String num) {
    _phoneNumber = num;
    notifyListeners();
  }

  String get phoneNumber {
    return _phoneNumber;
  }

  Future<void> verifyCredential(BuildContext context) async {
    if (FirebaseAuth.instance.currentUser == null) {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _id,
        smsCode: _otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      await _spServices.setLogInCredentials(credential);
    }
  }

  void signInWithPhone(BuildContext context) async {
    // phoneNumber = number;
    isLoading = true;
    notifyListeners();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+91$_phoneNumber",
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {},
      verificationFailed: (FirebaseAuthException authException) async {},
      codeSent: (String verificationId, int? token) async {
        _id = verificationId;
        isLoading = false;
        notifyListeners();
        navigateTo(context);
      },
      codeAutoRetrievalTimeout: (verificationID) async {},
    );
  }

  navigateTo(BuildContext context) {
    navigatePushReplacement(context, const OTPPage());
  }
}
