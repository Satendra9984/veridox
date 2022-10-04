import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SPServices {
  Future<void> setLogInCredentials(AuthCredential credential) async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint(credential.toString());
    await prefs.setString('credentials', credential.toString());
    await prefs.setString('token', 'loggedIn');
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint(prefs.getString('token'));
    return prefs.getString('token');
  }

  Future<AuthCredential> getAuthCreds() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String> data = json.decode(prefs.getString('credentials')!);
    late AuthCredential cred;
    if (data.isNotEmpty) {
      cred = AuthCredential(
          providerId: data['providerId'] ?? '',
          token: int.parse(data['token'] ?? '100'),
          signInMethod: data['signInMethod'] ?? '');
    }
    return cred;
  }

  Future<bool> checkIfExists(String caseId) async {
    final prefs = await SharedPreferences.getInstance();
    return (prefs.getString(caseId) != null);
  }

  Future<void> removeSavedAssignment(String caseId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(caseId);
    prefs.remove('$caseId/form');
  }

  /// Getting the store SavedAssignment with the given CaseId
  Future<Map<String, dynamic>> getSavedAssignment(String caseId) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = json.decode(prefs.getString(caseId)!);
    return data;
  }

  Future<Map<String, dynamic>> getSavedAssignmentForm(String caseId) async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data = json.decode(prefs.getString('form$caseId')!);
    return data;
  }

  Future<List<String>?> getSavedAssignmentList() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('savedAssignments');
  }

  /// Getting the list of SavedAssignment to display
  Stream<Map<String, dynamic>> getSaveAssignmentStream(String caseId) async* {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> data;
    while (true) {
      data = jsonDecode(prefs.getString(caseId)!);
      yield data;
    }
  }

  Future setSavedAssignment(Map<String, dynamic> data, String caseId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(caseId, jsonEncode(data));
  }

  Future<void> setSavedAssignmentForm(
      Map<String, dynamic> formData, String caseId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('form$caseId', jsonEncode(formData));
  }

  /// setting the list of SavedAssignmentList Id's
  Future<void> setSavedAssignmentList(List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedAssignments', list);
  }
}
