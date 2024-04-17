import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_utils/http_requests.dart';

class SendRequestProvider extends ChangeNotifier {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _dropDownController = TextEditingController();

  // String dropDown = 'Select your agency';
  String agencyUid = '';
  final TextEditingController _aadharRef = TextEditingController();
  final TextEditingController _panRef = TextEditingController();

  get getFormKey => _key;
  get getNameCtrl => _nameController;
  get getPhoneCtrl => _phoneController;
  get getEmailCtrl => _emailController;
  get getDropDownCtrl => _dropDownController;
  get getAadharRef => _aadharRef;
  get getPanRef => _panRef;

  get nameValidator {}
  get emailValidator {}
  get phoneValidator {}
  get dropDownValidator {}
  get aadharLinkValidator {}
  get panLinkValidator {}

  Future<void> submit(BuildContext context) async {
    _phoneController.text =
        FirebaseAuth.instance.currentUser!.phoneNumber.toString();

    Map<String, dynamic> data = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'email': _emailController.text,
      'aadharRef': _aadharRef.text,
      'panRef': _panRef.text,
      'agency_name': _dropDownController.text,
    };
    // http://veridocs.pythonanywhere.com/api/user/uid
    debugPrint('sending add request with data -> ${data}');

    await HTTPRequests.sendPostRequest(
            'user/${FirebaseAuth.instance.currentUser!.uid}')
        .then((value) async {
      if (value != null) {
        debugPrint('dUid -> ${value}\n');
        String dUid = value['id'];
        data['id'] = dUid;
        await FirestoreServices.sendJoinRequest(
          data,
          FirebaseAuth.instance.currentUser!.uid,
          agencyUid,
        );
      }
    });
  }
}
