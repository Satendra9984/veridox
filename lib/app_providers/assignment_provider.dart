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

  /// fetching the assignments with the report_data(form_data) to the field_verifier
  Future<void> fetchAndLoadData() async {
    // try {
    //   notifyListeners();
    // } catch (error) {
    //   _tasks = [];
    //   notifyListeners();
    // }
  }

  List<Assignment> get oldFirstTasks {
    List<Assignment> oldFirstList = [..._tasks];
    oldFirstList.sort((a, b) => b.assignedDate.compareTo(a.assignedDate));

    return oldFirstList;
  }
}
