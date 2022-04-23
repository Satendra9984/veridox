import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:veridox/models/assignment_model.dart';

class AssignmentProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<AssignmentModel> _tasks = [];

  List<AssignmentModel> get tasks {
    return [..._tasks];
  }

  List<AssignmentModel> _savedTasks = [];

  List<AssignmentModel> get savedTasks {
    return [..._savedTasks];
  }

  List<AssignmentModel> get oldFirstTasks {
    List<AssignmentModel> oldFirstList = [..._tasks];
    oldFirstList.sort((a, b) => b.assignedDate.compareTo(a.assignedDate));

    return oldFirstList;
  }

  Future<void> fetchAndLoadData() async {
    // TODO : HERE WE HAVE TO FETCH AND LOAD THE ASSIGNMENTS LIST FORM FIREBASE

    try {
      final docSnap = await _firestore
          .collection('assignments')
          .where('fv', isEqualTo: 'Satendra Pal')
          .orderBy('createdAt')
          .get();
      final docs = docSnap.docs;
      List<AssignmentModel> fireTasks = [];
      for (var doc in docs) {
        // print('${doc.data()}\n\n');
        fireTasks.add(
          AssignmentModel(
            address: doc['address'],
            caseId: doc.id,
            description: doc['description'],
            type: doc['type'],
            assignedDate: DateTime.parse(
              // converting server timeStamps in DateTime format
              doc['createdAt'].toDate().toString(),
            ),
          ),
        );
        // _firestore.collection('assignments').doc(doc.id).update({
        //   'createdAt': FieldValue.serverTimestamp(),
      }
      _tasks = fireTasks;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void addSaveAssignment(String id) {
    // ADD A METHOD TO ADD IN SAVE ASSIGNMENTS
    // TODO: ADD THESE SAVED ASSIGNMENTS IN THE LOCAL DATABASE
    AssignmentModel save = _tasks.firstWhere((element) => element.caseId == id);
    if (!_savedTasks.contains(save)) {
      _savedTasks.add(save);
    }
    notifyListeners();
  }

  void removeFromSaveAssignments(String id) {
    _savedTasks.removeWhere((element) => element.caseId == id);
    notifyListeners();
  }
}
// AssignmentModel(
//     address: '26A Iiit kalyani, West Bengal',
//     caseId: 'sbi123456',
//     description: 'description',
//     type: 'Home Loan',
//     status: Status.completed),
// AssignmentModel(
//     address: '26A Iiit kalyani, West Bengal',
//     caseId: 'sbi123456',
//     description: 'description',
//     type: 'Car Loan',
//     status: Status.saved),
// AssignmentModel(
//     address: '26A Iiit kalyani, West Bengal',
//     caseId: 'sbi123456',
//     description: 'description',
//     type: 'Bike Loan'),
// AssignmentModel(
//     address: '26A Iiit kalyani, West Bengal',
//     caseId: 'sbi123456',
//     description: 'description',
//     type: 'Education Loan',
//     status: Status.saved),