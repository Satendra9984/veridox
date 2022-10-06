import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:veridox/app_services/database/firestore_services.dart';

class FormProvider extends ChangeNotifier {
  Map<String, dynamic> _result = {};
  get getResult => _result;

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
      debugPrint(_result.toString());
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
        .collection('assignment')
        .doc(_assignmentId)
        .collection('form_data')
        .doc('response')
        .get();

    if (snap.exists) {
      Map<String, dynamic>? data = snap.data();
      if (data != null && data.isNotEmpty) {
        _result = data;
      }
    }
  }

  Future<void> saveDraftData() async {
    await FirebaseFirestore.instance
        .collection('assignment')
        .doc(assignmentId)
        .collection('form_data')
        .doc('response')
        .set(_result);
  }
}
