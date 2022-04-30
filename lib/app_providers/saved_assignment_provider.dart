import 'package:flutter/foundation.dart';
import '../app_models/saved_assignment_model.dart';
import '../app_services/database/firestore_services.dart';

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

  Future<void> addSaveAssignments(String caseId) async {
    try {
      final data = await FirestoreServices().getAssignmentById(caseId);
      final formData = await FirestoreServices().getFormDataById(caseId);
      final SavedAssignment saveAsgn = SavedAssignment.fromJson(data, formData);
      _savedTasks.insert(_savedTasks.length, saveAsgn);
    } catch (e) {
      // rethrow;
      return;
    }
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

  SavedAssignment findById(String id) {
    return _savedTasks.firstWhere((element) => element.caseId == id);
  }
}
