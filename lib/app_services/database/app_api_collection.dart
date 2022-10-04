import 'package:veridox/app_utils/http_requests.dart';

class AppApiCollection {
  static getAllForms() async {
    return await HTTPRequests.sendGetRequest('forms');
  }

  static Future<Map<String, dynamic>?> getForm(String id) async {
    return await HTTPRequests.sendGetRequest('form/$id');
  }
}
