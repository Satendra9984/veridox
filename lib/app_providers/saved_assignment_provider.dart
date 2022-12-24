// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
// import 'package:veridox/app_services/database/shared_pref_services.dart';
// import '../app_models/saved_assignment_model.dart';
// import '../app_services/database/firestore_services.dart';
//
// class SavedAssignmentProvider with ChangeNotifier {
//   bool isLoading = false;
//   final List<SavedAssignment> _savedAssignments = [];
//   final SPServices _spServices = SPServices();
//
//   List<SavedAssignment> get savedAssignments {
//     return [..._savedAssignments];
//   }
//
//   SavedAssignment getAssignmentById(String id) {
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//     return _savedAssignments
//         .firstWhere((element) => element.caseId == '$userId$id');
//   }
//
// }
