import 'package:flutter/foundation.dart';
import 'package:veridox/app_models/assignment_model.dart';

class SavedAssignmentProvider with ChangeNotifier {
  final List<Assignment> _savedTasks = [];

  
  List<Assignment> get savedAssignments {
    return [..._savedTasks];
  }
  
  void addSaveAssignment() {
    
  }

  void removeFromSaveAssignments(String caseId) {}
}
