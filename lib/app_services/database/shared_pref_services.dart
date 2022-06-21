import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPServices {
  Future<void> setLogInCredentials(AuthCredential credential) async {
    final _prefs = await SharedPreferences.getInstance();
    debugPrint(credential.toString());
    await _prefs.setString('credentials', credential.toString());
    await _prefs.setString('token', 'loggedIn');
  }

  Future<String?> getToken() async {
    final _prefs = await SharedPreferences.getInstance();
    print(_prefs.getString('token'));
    return _prefs.getString('token');
  }

  Future<AuthCredential> getAuthCreds() async {
    final _prefs = await SharedPreferences.getInstance();
    Map<String, String> _data = json.decode(_prefs.getString('credentials')!);
    late AuthCredential _cred;
    if (_data.isNotEmpty) {
      _cred = AuthCredential(
          providerId: _data['providerId'] ?? '',
          token: int.parse(_data['token'] ?? '100'),
          signInMethod: _data['signInMethod'] ?? '');
    }
    return _cred;
  }

  Future<bool> checkIfExists(String caseId) async {
    final _prefs = await SharedPreferences.getInstance();

    return (_prefs.getString(caseId) != null);
  }

  Future<void> removeSavedAssignment(String caseId) async {
    final _prefs = await SharedPreferences.getInstance();
    _prefs.remove(caseId);
    _prefs.remove('$caseId/form');
  }

  /// Getting the store SavedAssignment with the given CaseId
  Future<Map<String, dynamic>> getSavedAssignment(String caseId) async {
    final _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> _data = json.decode(_prefs.getString(caseId)!);
    return _data;
  }

  Future<Map<String, dynamic>> getSavedAssignmentForm(String caseId) async {
    final _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> _data = json.decode(_prefs.getString('form$caseId')!);
    return _data;
  }

  Future<List<String>?> getSavedAssignmentList() async {
    final _prefs = await SharedPreferences.getInstance();
    return _prefs.getStringList('savedAssignments');
  }

  /// Getting the list of SavedAssignment to display
  Stream<Map<String, dynamic>> getSaveAssignmentStream(String caseId) async* {
    final _prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data;
    while (true) {
      data = jsonDecode(_prefs.getString(caseId)!);
      yield data;
    }
  }

  Future setSavedAssignment(Map<String, dynamic> data, String caseId) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString(caseId, jsonEncode(data));
  }

  Future<void> setSavedAssignmentForm(
      Map<String, dynamic> formData, String caseId) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('form$caseId', jsonEncode(formData));
  }

  /// setting the list of SavedAssignmentList Id's
  Future<void> setSavedAssignmentList(List<String> list) async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setStringList('savedAssignments', list);
  }
}
