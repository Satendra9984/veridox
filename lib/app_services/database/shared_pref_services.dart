import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPServices {
  Future<void> setLogInCredentials(AuthCredential credential) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.setString('credentials', credential.toString());
    _prefs.setString('token', credential.token.toString());
  }

  Future<String?> getToken() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getString('token');
  }

  Future<AuthCredential> getAuthCreds() async {
    final _prefs = await SharedPreferences.getInstance();
    Map<String, String> _data = json.decode(_prefs.getString('credentials')!);
    late AuthCredential _cred;
    if (_data.isNotEmpty) {
      _cred = AuthCredential(providerId: _data['providerId'] ?? '', token: int.parse(_data['token'] ?? '100'), signInMethod: _data['signInMethod'] ?? '');
    }
    return _cred;
  }

  Future setSavedAssignment(Map<String, dynamic> data) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(data['caseId'], jsonEncode(data));
  }

  Future<bool> checkIfExists(String caseId) async {
    final _prefs = await SharedPreferences.getInstance();
    return (_prefs.getString(caseId) != null);
  }

  Future<Map<String, dynamic>> getSavedAssignment(String caseId) async {
    final _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> _data = json.decode(_prefs.getString('caseId')!);
    return _data;
  }
}