import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:veridox/app_models/assignment_model.dart';

class AssignmentProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  List<Assignment> _tasks = [];

  List<Assignment> get tasks {
    return [..._tasks];
  }

  List<Assignment> get oldFirstTasks {
    List<Assignment> oldFirstList = [..._tasks];
    oldFirstList.sort((a, b) => b.assignedDate.compareTo(a.assignedDate));

    return oldFirstList;
  }

  Stream<List<Assignment>> getAssignments() {
    return _firestore
        .collection('assignments')
        .where('fv', isEqualTo: 'Satendra Pal')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Assignment(
                  address: doc['address'],
                  caseId: doc.id,
                  description: doc['description'],
                  type: doc['type'],
                  assignedDate: DateTime.parse(
                    // converting server timeStamps in DateTime format
                    doc['createdAt'].toDate().toString(),
                  ),
                ),
              )
              .toList(),
        );
  }

  Future<void> fetchAndLoadData() async {
    try {
      final docSnap = await _firestore
          .collection('assignments')
          .where('fv', isEqualTo: 'Satendra Pal')
          .orderBy('createdAt')
          .get();
      final docs = docSnap.docs;
      List<Assignment> fireTasks = [];
      for (var doc in docs) {
        fireTasks.add(
          Assignment(
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
        // await _firestore
        //     .collection('fv')
        //     .doc('nZF37kTBVTMbAP452OUQ9ZKxIk32')
        //     .collection('assignments')
        //     .add({
        //   'address': doc['address'],
        //   'caseId': doc.id,
        //   'description': doc['description'],
        //   'type': doc['type'],
        //   'assignedDate': DateTime.parse(
        //     // converting server timeStamps in DateTime format
        //     doc['createdAt'].toDate().toString(),
        //   ),
        // });
      }
      _tasks = fireTasks;
      // await _firestore.collection('fv').doc('nZF37kTBVTMbAP452OUQ9ZKxIk32').collection('assignments').add({
      //
      // });
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  void addSaveAssignment(caseId) {}
}
