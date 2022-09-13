import 'package:shared_preferences/shared_preferences.dart';

class FormRepository {
  static Future<void> saveSingleFieldData(
    String pageId,
    String fieldId,
    dynamic fieldData,
  ) async {
    String key = '$pageId/$fieldId';

    final pref = await SharedPreferences.getInstance();
    pref.setString(key, fieldData);
  }
}
