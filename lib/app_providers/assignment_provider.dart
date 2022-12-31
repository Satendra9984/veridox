// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
//
// class AssignmentProvider extends ChangeNotifier {
//   final List<Assignment> _tasks = [];
//
//   List<Assignment> get tasks {
//     return [..._tasks];
//   }
//
//   /// fetching the assignments with the report_data(form_data) to the field_verifier
//   Future<void> fetchAndLoadData() async {
//     // try {
//     //   notifyListeners();
//     // } catch (error) {
//     //   _tasks = [];
//     //   notifyListeners();
//     // }
//   }
//
//   List<Assignment> get oldFirstTasks {
//     List<Assignment> oldFirstList = [..._tasks];
//     oldFirstList.sort((a, b) => b.assignedDate.compareTo(a.assignedDate));
//
//     return oldFirstList;
//   }
// }
