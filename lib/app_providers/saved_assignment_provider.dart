import 'package:flutter/foundation.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import '../app_models/saved_assignment_model.dart';
import '../app_services/database/firestore_services.dart';

/// here we will connect local database(shared_preference) and provider
class SavedAssignmentProvider with ChangeNotifier {
  final List<SavedAssignment> _savedTasks = [];

  List<SavedAssignment> get savedAssignments {
    return [..._savedTasks];
  }

  Future<bool> checkSaved(String caseId) async {
    return await SPServices().checkIfExists(caseId);
  }

  /// saving basic_details of assignment in local_database
  /// This jsonData is from SavedAssignment.toJson() function
  /// currently used when verify button is pressed in @assignment_details_page
  Future<void> addSavedAssignment(Map<String, dynamic> jsonData) async {
    final _spService = SPServices();

    try {
      /// saving basic_details in local_database
      await _spService.setSavedAssignment({
        'caseId': jsonData['caseId'],
        'phone': jsonData['phone'],
        'name': jsonData['name'],
        'address': jsonData['address'],
        'assigned_at': jsonData['assigned_at'],
        'document_type': jsonData['document_type'],
        'status': jsonData['status'],
      });

      /// saving form_data in local_database
      await _spService.setFormDataById(
        jsonData['report_data'],
        jsonData['caseId'],
      );
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  /// adding SavedAssignment in local_database (probably from assignment_list)
  /// currently used when pressing popUpMenuButton option
  Future<void> addSavedAssignmentByID(String caseId) async {
    final _spService = SPServices();
    if (await checkSaved(caseId)) {
      return;
    }
    try {
      final jsonData = await FirestoreServices().getAssignmentById(caseId);
      if (jsonData != null) {
        /// saving basic_details of assignment in local_database
        await _spService.setSavedAssignment({
          'caseId': caseId,
          'phone': jsonData['phone'],
          'name': jsonData['name'],
          'address': jsonData['address'],
          'assigned_at': jsonData['assigned_at'],
          'document_type': jsonData['document_type'],
          'status': jsonData['status'],
        });

        /// saving form_data in local_database
        await _spService.setFormDataById(
          jsonData['report_data'] ?? {},
          caseId,
        );
      }
      notifyListeners();
    } catch (e) {
      return;
    }
  }

  /// Getting the stored form with the given CaseId
  Future<Map<String, dynamic>> getFormById(String caseId) async {
    final _prefs = SPServices();
    final Map<String, dynamic> _form = await _prefs.getFormById(caseId);
    return _form;
  }

  /// getting SavedAssignment (@assignment_details_page #currently)
  Future<SavedAssignment?> getAssignment(String caseId) async {
    if (await checkSaved(caseId)) {
      /// checking if it already present in local_database
      try {
        /// FETCHING DATA FROM THE LOCAL_STORAGE
        final mappedData = await SPServices().getSavedAssignment(caseId);
        final formData = await SPServices().getFormById(caseId);

        final SavedAssignment saveAssignment =
            SavedAssignment.fromJson(mappedData, formData, caseId);

        return saveAssignment;
      } catch (e) {
        print('hive error--> $e');
        return null;
      }
    } else {
      try {
        /// FETCH DATA FROM THE FIRESTORE
        final mappedData = await FirestoreServices().getAssignmentById(caseId);
        print('in savedProvider line --. 108 --> $mappedData\n');
        if (mappedData != null) {
          final formData = mappedData['report_data'] ?? {};
          final SavedAssignment savedAssignment =
              SavedAssignment.fromJson(mappedData, formData, caseId);

          return savedAssignment;
        } else {
          return null;
        }
      } catch (e) {
        print('firebase error--> $e');
        return null;
      }
    }
  }

  /// for updating the value of the form with @newFormData in local_database
  Future<void> updateForm(
      String caseId, Map<String, dynamic> newFormData) async {
    await SPServices().updateForm(caseId, newFormData);
    notifyListeners();
  }
}
