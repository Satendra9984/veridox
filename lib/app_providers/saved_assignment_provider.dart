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

  void getLastAssignments() async {
    isLoading = true;
    List<String>? _lastAssignments = await _spServices.getSavedAssignmentList();
    debugPrint(_lastAssignments.toString());
    _savedAssignments.clear();
    if (_lastAssignments!.isNotEmpty) {
      for (var id in _lastAssignments) {
        final jsonData = await _spServices.getSavedAssignment(id);
        final formData = await _spServices.getSavedAssignmentForm(id);
        _savedAssignments.add(SavedAssignment.fromJson(jsonData, formData, id));
      }
    }
    isLoading = false;
    debugPrint('last_ass: ${_savedAssignments.toString()}');
    notifyListeners();
  }

  void _add(SavedAssignment assignment) {
    if (_savedAssignments.contains(assignment) == false) {
      _savedAssignments.insert(_savedAssignments.length, assignment);
    }
    notifyListeners();
  }

  Future<void> addSavedAssignment(String caseId) async {
    isLoading = true;
    try {
      // fetch from firebase database
      final data = await FirestoreServices().getAssignmentById(caseId);

      final formData = await FirestoreServices().getFormDataById(caseId);

      // debugPrint(data.toString());
      // debugPrint(formData.toString());

      SavedAssignment savedAssignment = SavedAssignment.fromJson(
          data!, formData!, caseId);

      // save data in local database
      await _spServices.setSavedAssignment(savedAssignment.toJson(), caseId);
      await _spServices.setSavedAssignmentForm(formData, caseId);

      // add object in provider
      _add(savedAssignment);

      // update the saved assignment list in local database
      await _spServices.setSavedAssignmentList(
          savedAssignments.map((e) => e.caseId).toList());
    } catch (err) {
      debugPrint(err.toString());
    }
    isLoading = false;
  }

  void updateSaveAssignment(SavedAssignment assignment) {
    isLoading = true;
    _savedAssignments[_savedAssignments
        .indexWhere((element) => element.caseId == assignment.caseId)] = assignment;
    notifyListeners();
    isLoading = false;
  }

  void removeFromSaveAssignments(String caseId) async {

    isLoading = true;
    // remove object from savedAssignments list
    _savedAssignments.removeWhere((element) => element.caseId == caseId);
    notifyListeners();

    _spServices.setSavedAssignmentList(savedAssignments.map((e) => e.caseId).toList());
    isLoading = false;
  }

  SavedAssignment getAssignmentById(String id) {
    return _savedAssignments.firstWhere((element) => element.caseId == id);
  }
}
