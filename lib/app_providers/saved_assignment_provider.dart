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
//   Future<void> getLastAssignments() async {
//     isLoading = true;
//     List<String>? lastAssignments = await _spServices.getSavedAssignmentList();
//     debugPrint(lastAssignments.toString());
//     _savedAssignments.clear();
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//
//     if (lastAssignments != null && lastAssignments.isNotEmpty) {
//       for (var id in lastAssignments) {
//         final jsonData = await _spServices.getSavedAssignment(id);
//         final formData = await _spServices.getSavedAssignmentForm(id);
//
//         String _actualCaseId = id.substring(userId.length, id.length);
//         _savedAssignments
//             .add(SavedAssignment.fromJson(jsonData, formData, _actualCaseId));
//       }
//     }
//     isLoading = false;
//     debugPrint('last_ass: ${_savedAssignments.toString()}');
//     notifyListeners();
//   }
//
//   Future<void> _add(SavedAssignment assignment) async {
//     if (_savedAssignments.contains(assignment) == false) {
//       _savedAssignments.insert(_savedAssignments.length, assignment);
//
//       /// todo : update assignment status in firebase
//     }
//     debugPrint('length --> ${_savedAssignments.length.toString()}\n');
//     notifyListeners();
//   }
//
//   Future<void> updateStatus(SavedAssignment savedAssignment) async {
//     await FirestoreServices.updateAssignmentStatus(
//         status: 'working', caseId: savedAssignment.caseId);
//   }
//
//   Future<void> addSavedAssignment(String caseId) async {
//     isLoading = true;
//     try {
//       // fetch from firebase database
//       final data = await FirestoreServices.getAssignmentById(caseId);
//       // fetching form data from firestore
//       final formData = await FirestoreServices.getFormDataById(caseId);
//
//       debugPrint(data.toString());
//       debugPrint(
//           'formdata in saved ass provider --> \n${formData.toString()}\n\n');
//
//       SavedAssignment savedAssignment =
//           SavedAssignment.fromJson(data!, formData!, caseId);
//
//       // now we will use caseId --> '$userId$caseId'
//       String userId = FirebaseAuth.instance.currentUser!.uid;
//       // save data in local database
//       await _spServices.setSavedAssignment(
//           savedAssignment.toJson(), '$userId$caseId');
//       await _spServices.setSavedAssignmentForm(formData, '$userId$caseId');
//
//       // add object in provider
//       debugPrint('add called\n\n');
//       savedAssignment.status = 'working';
//       _add(savedAssignment);
//
//       // update the saved assignment list in local database
//       await _spServices.setSavedAssignmentList(
//           savedAssignments.map((e) => '$userId${e.caseId}').toList());
//       notifyListeners();
//     } catch (err) {
//       debugPrint(err.toString());
//     }
//     isLoading = false;
//   }
//
//   void updateSaveAssignment(SavedAssignment assignment) {
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//     isLoading = true;
//     _savedAssignments[_savedAssignments.indexWhere(
//             (element) => element.caseId == '$userId${assignment.caseId}')] =
//         assignment;
//     isLoading = false;
//     notifyListeners();
//   }
//
//   Future<void> removeFromSaveAssignments(String caseId) async {
//     isLoading = true;
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//     // remove object from savedAssignments list
//     _savedAssignments.removeWhere((element) => element.caseId == '$caseId');
//
//     _spServices.setSavedAssignmentList(
//         savedAssignments.map((e) => '$userId${e.caseId}').toList());
//
//     // TODO: remove from local database
//
//     try {
//       await _spServices.removeSavedAssignment('$userId$caseId');
//       await FirestoreServices.updateAssignmentStatus(
//           status: 'assigned', caseId: caseId);
//     } catch (error) {
//       debugPrint(error.toString());
//     }
//
//     notifyListeners();
//     isLoading = false;
//   }
//
//   SavedAssignment getAssignmentById(String id) {
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//     return _savedAssignments
//         .firstWhere((element) => element.caseId == '$userId$id');
//   }
//
//   /// TODO : DELETE SAVED ASSIGNMENT
//   Future<void> deleteSavedAssignment(String caseId) async {
//     String userId = FirebaseAuth.instance.currentUser!.uid;
//     _savedAssignments.removeWhere((element) => element.caseId == '$caseId');
//     notifyListeners();
//   }
// }
