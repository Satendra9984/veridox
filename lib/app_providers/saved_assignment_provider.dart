import 'package:flutter/foundation.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import '../app_models/saved_assignment_model.dart';
import '../app_services/database/firestore_services.dart';

class SavedAssignmentProvider with ChangeNotifier {
  bool isLoading = false;
  final List<SavedAssignment> _savedAssignments = [];
  final SPServices _spServices = SPServices();

  List<SavedAssignment> get savedAssignments {
    return [..._savedAssignments];
  }

  Future<void> getLastAssignments() async {
    isLoading = true;
    List<String>? lastAssignments = await _spServices.getSavedAssignmentList();
    debugPrint(lastAssignments.toString());
    _savedAssignments.clear();
    if (lastAssignments != null && lastAssignments.isNotEmpty) {
      for (var id in lastAssignments) {
        final jsonData = await _spServices.getSavedAssignment(id);
        final formData = await _spServices.getSavedAssignmentForm(id);
        _savedAssignments.add(SavedAssignment.fromJson(jsonData, formData, id));
      }
    }
    isLoading = false;
    debugPrint('last_ass: ${_savedAssignments.toString()}');
    notifyListeners();
  }

  Future<void> _add(SavedAssignment assignment) async {
    if (_savedAssignments.contains(assignment) == false) {
      // assignment.status = 'working';
      // await updateStatus(assignment);
      _savedAssignments.insert(_savedAssignments.length, assignment);

      /// todo : update assignment status in firebase
    }
    debugPrint('length --> ${_savedAssignments.length.toString()}\n');
    notifyListeners();
  }

  Future<void> updateStatus(SavedAssignment savedAssignment) async {
    await FirestoreServices
        .updateStatus(status: 'working', caseId: savedAssignment.caseId);
  }

  Future<void> addSavedAssignment(String caseId) async {
    isLoading = true;
    try {
      // fetch from firebase database
      final data = await FirestoreServices.getAssignmentById(caseId);

      final formData = await FirestoreServices.getFormDataById(caseId);

      debugPrint(data.toString());
      debugPrint('formdata --> ${formData.toString()}\n\n');

      SavedAssignment savedAssignment =
          SavedAssignment.fromJson(data!, formData!, caseId);

      // save data in local database
      await _spServices.setSavedAssignment(savedAssignment.toJson(), caseId);
      await _spServices.setSavedAssignmentForm(formData, caseId);

      // add object in provider
      debugPrint('add called\n\n');
      savedAssignment.status = 'working';
      _add(savedAssignment);

      // update the saved assignment list in local database
      await _spServices.setSavedAssignmentList(
          savedAssignments.map((e) => e.caseId).toList());
      notifyListeners();
    } catch (err) {
      debugPrint(err.toString());
    }
    isLoading = false;
  }

  void updateSaveAssignment(SavedAssignment assignment) {
    isLoading = true;
    _savedAssignments[_savedAssignments.indexWhere(
        (element) => element.caseId == assignment.caseId)] = assignment;
    isLoading = false;
    notifyListeners();
  }

  void removeFromSaveAssignments(String caseId) async {
    isLoading = true;
    // remove object from savedAssignments list
    _savedAssignments.removeWhere((element) => element.caseId == caseId);

    _spServices
        .setSavedAssignmentList(savedAssignments.map((e) => e.caseId).toList());

    // TODO: remove from local database

    try {
      await _spServices.removeSavedAssignment(caseId);
    } catch (error) {
      debugPrint(error.toString());
    }

    notifyListeners();

    isLoading = false;
  }

  SavedAssignment getAssignmentById(String id) {
    return _savedAssignments.firstWhere((element) => element.caseId == id);
  }

  /// TODO : DELETE SAVED ASSIGNMENT
  Future<void> deleteSavedAssignment(String caseId) async {
    _savedAssignments.removeWhere((element) => element.caseId == caseId);
  }

  // Future<List<String>?> getSavedAssignmentList() async {
  //   final list = await _spServices.getSavedAssignmentList();
  //   return list;
  // }
}
