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

  Future<void> fetchAndLoadData() async {
    try {
      final docSnap = await _firestore
          .collection('assignments')
          .where('fv', isEqualTo: 'Satendra Pal')
          // .orderBy('createdAt')
          .get();
      final docs = docSnap.docs;
      List<Assignment> fireTasks = [];
      for (var doc in docs) {
        fireTasks.add(
          Assignment.fromJson(
            doc.data(),
          ),
        );
      }
      _tasks = fireTasks;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }
}
