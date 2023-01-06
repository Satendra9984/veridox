import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import '../app_models/saved_assignment_model.dart';
import '../app_services/database/firestore_services.dart';

class SavedAssignmentProvider with ChangeNotifier {
  bool _isListAlreadyInitialized = false;
  final List<SavedAssignment> _savedAssignments = [];

  List<SavedAssignment> get savedAssignments {
    return [..._savedAssignments];
  }

  SavedAssignment getAssignmentById(String id) {
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return _savedAssignments
        .firstWhere((element) => element.caseId == '$userId$id');
  }

  Future<void> setSavedAssignmentList() async {
    try {
      await FirestoreServices.getAssignmentsByStatus(
              filter1: 'in_progress', filter2: 'reassigned')
          .then((list) {
        if (list != null && list.isNotEmpty) {
          for (var ele in list) {
            _savedAssignments.add(SavedAssignment.fromJson(ele, ele['caseId']));
          }
        }
      });
    } catch (e) {}
  }
}
