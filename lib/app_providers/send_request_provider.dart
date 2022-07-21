import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/firestore_services.dart';

class SendRequestProvider extends ChangeNotifier {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final String _dropDown = 'Select your agency';
  final TextEditingController _aadharRef = TextEditingController();
  final TextEditingController _panRef = TextEditingController();

  get getFormKey => _key;
  get getNameCtrl => _nameController;
  get getPhoneCtrl => _phoneController;
  get getEmailCtrl => _emailController;
  get getDropDown => _dropDown;
  get getAadharRef => _aadharRef;
  get getPanRef => _panRef;

  get nameValidator {}
  get emailValidator {}
  get phoneValidator {}
  get dropDownValidator {}
  get aadharLinkValidator {}
  get panLinkValidator {}

  void submit() {
    if (_key.currentState!.validate()) {
      Map<String, dynamic> data = {
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'aadharRef': _aadharRef.text,
        'panRef': _panRef.text
      };
      FirestoreServices.sendJoinRequest(data, '', '');
    }
  }
}
