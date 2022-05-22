import 'package:flutter/foundation.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import '../app_models/saved_assignment_model.dart';
import '../app_services/database/firestore_services.dart';

// here we will connect local database(shared_preference) and provider
class SavedAssignmentProvider with ChangeNotifier {
  final List<SavedAssignment> _savedTasks = [];

  List<SavedAssignment> get savedAssignments {
    return [..._savedTasks];
  }

  void addSaveAssignment(SavedAssignment saveAsgn) {
    if (_savedTasks.contains(saveAsgn) == false) {
      _savedTasks.insert(_savedTasks.length, saveAsgn);
    }
    notifyListeners();
  }

  // Fetching the complete data from the Firestore database
  // because the form template will be available there so can't fetch it as a stream
  Future<void> addSaveAssignments(String caseId) async {
    try {
      // final data = await FirestoreServices().getAssignmentById(caseId);
      // final formData = await FirestoreServices().getFormDataById(caseId);
      // final SavedAssignment saveAsgn = SavedAssignment.fromJson(data, formData);
      // _savedTasks.insert(_savedTasks.length, saveAsgn);
    } catch (e) {
      return;
    }
    // TODO: ADD THE SAVED ASSIGNMENT IN SHARED_PREFERENCE ALSO
  }

  void updateSaveAssignment(SavedAssignment saveAsgn) {
    _savedTasks[_savedTasks
        .indexWhere((element) => element.caseId == saveAsgn.caseId)] = saveAsgn;
    notifyListeners();
  }

  void removeFromSaveAssignments(String caseId) {
    _savedTasks.removeWhere((element) => element.caseId == caseId);
    notifyListeners();
  }

  Future<Map<String, dynamic>?> findById(String id) async {
    try {
      final sp = SPServices();

      _savedTasks.firstWhere((element) => element.caseId == id);
      if (await sp.checkIfExists(id)) {
        return await sp.getSavedAssignment(id);
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
