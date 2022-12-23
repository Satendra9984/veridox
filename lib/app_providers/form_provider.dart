import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormProvider extends ChangeNotifier {
  Map<String, dynamic> _result = {};
  get getResult => _result;

  Set<GlobalKey<FormState>> _formKeys = {};

  Set<GlobalKey<FormState>> get getFormKeys => _formKeys;
  void addFormKey(GlobalKey<FormState> key) {
    _formKeys.add(key);
  }

  /// for the assignment id
  String _assignmentId = '';
  String get assignmentId => _assignmentId;
  void set setAssignmentId(String id) {
    this._assignmentId = id;
  }

  updateData(
      {required String pageId,
      required String fieldId,
      String? rowId,
      String? columnId,
      String? type,
      required dynamic value}) {
    if (rowId != null && columnId != null) {
      _result['$pageId,$fieldId,$rowId,$columnId'] = value;
    } else {
      _result['$pageId,$fieldId'] = value;
      debugPrint('$_result\n\n');
    }
  }

  refreshData() {
    _result.removeWhere((key, value) => value == "");
  }

  clearResult() {
    _result = {};
  }

  Future<void> initializeResponse() async {
    final snap = await FirebaseFirestore.instance
        .collection('assignments')
        .doc(_assignmentId)
        .collection('form_data')
        .doc('response')
        .get();

    if (snap.exists) {
      Map<String, dynamic>? data = snap.data();
      if (data != null && data.isNotEmpty) {
        _result = data;
        // debugPrint('initial provider data: $_result\n\n');
      }
    }
  }

  void deleteData(String keyG) {
    _result.removeWhere((key, value) => key == keyG);
    notifyListeners();
  }

  Future<void> saveDraftData() async {
    try {
      debugPrint('saving draft data: $_result\n\n');
      await FirebaseFirestore.instance
          .collection('assignments')
          .doc(assignmentId)
          .collection('form_data')
          .doc('response')
          .set(_result);
    } catch (e) {
      return;
    }
  }
  
  Future<void> submitForm(context) async {
    await FirebaseFirestore.instance.collection('assignments')
        .doc(assignmentId).update({
      'status': 'submitted'
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('From Successfully Submitted')));
    }).catchError((err) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('From Successfully Submitted')));
    });
  }
}
