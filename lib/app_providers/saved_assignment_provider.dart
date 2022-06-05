import 'package:flutter/foundation.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import '../app_models/saved_assignment_model.dart';
import '../app_services/database/firestore_services.dart';

class SavedAssignmentProvider with ChangeNotifier {
  final List<SavedAssignment> _savedAssignments = [];
  final SPServices _spServices = SPServices();

  List<SavedAssignment> get savedAssignments {
    return [..._savedAssignments];
  }

  void _add(SavedAssignment saveAsgn) {
    if (_savedAssignments.contains(saveAsgn) == false) {
      _savedAssignments.insert(_savedAssignments.length, saveAsgn);
    }
    notifyListeners();
  }

  Future<void> addSavedAssignment(String caseId) async {
    try {
      // fetch from firebase database
      final data = await FirestoreServices().getAssignmentById(caseId);
      final formData = await FirestoreServices().getFormDataById(caseId);

      SavedAssignment savedAssignment = SavedAssignment.fromJson(data!, formData);

      // save data in local database
      await _spServices.setSavedAssignment(savedAssignment.toJson());
      await _spServices.setSavedAssignmentForm(formData);

      // add object in provider
      _add(savedAssignment);

      // update the saved assignment list in local database
      await _spServices.setSavedAssignmentList(savedAssignments.map((e) => e.caseId).toList());

    } catch (e) {
      return;
    }
  }

  void updateSaveAssignment(SavedAssignment saveAsgn) {
    _savedAssignments[_savedAssignments
        .indexWhere((element) => element.caseId == saveAsgn.caseId)] = saveAsgn;
    notifyListeners();
  }

  void removeFromSaveAssignments(String caseId) async {

    // remove object from savedAssignments list
    _savedAssignments.removeWhere((element) => element.caseId == caseId);
    notifyListeners();

    _spServices.setSavedAssignmentList(savedAssignments.map((e) => e.caseId).toList());
  }

  SavedAssignment getAssignmentById(String id) {
    return _savedAssignments.firstWhere((element) => element.caseId == id);
  }
}
