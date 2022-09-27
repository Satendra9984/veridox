import 'package:flutter/cupertino.dart';

class FormProvider extends ChangeNotifier {
  Map<String, dynamic> _result = {};

  get getResult => _result;

  updateData({required String pageId, required String fieldId, String? rowId,
    String? columnId, String? type, required String value}) {
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
}