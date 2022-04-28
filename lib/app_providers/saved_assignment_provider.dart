import 'package:flutter/foundation.dart';
import '../app_models/saved_assignment_model.dart';

class SavedAssignmentProvider with ChangeNotifier {
  final List<SavedAssignment> _savedTasks = [];

  List<SavedAssignment> get savedAssignments {
    return [..._savedTasks];
  }

  void addSaveAssignment(SavedAssignment saveAsgn) {
    if (_savedTasks.contains(saveAsgn) == false) {
      _savedTasks.insert(_savedTasks.length, saveAsgn);
    } else {
      updateSaveAssignment(saveAsgn);
    }
    notifyListeners();
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
}
