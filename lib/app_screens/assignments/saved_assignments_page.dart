import 'package:flutter/material.dart';
import 'package:veridox/app_models/saved_assignment_model.dart';
import 'package:veridox/app_screens/assignments/saved_assignment_list.dart';
import 'package:veridox/app_services/database/firestore_services.dart';

class SavedAssignmentsPage extends StatefulWidget {
  const SavedAssignmentsPage({Key? key}) : super(key: key);
  @override
  State<SavedAssignmentsPage> createState() => _SavedAssignmentsPageState();
}

class _SavedAssignmentsPageState extends State<SavedAssignmentsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<SavedAssignment>> _setInitialSavedAssignmentsList() async {
    List<SavedAssignment> saveList = [];
    await FirestoreServices.getAssignmentsByStatus(
            filter1: 'in_progress', filter2: 'reassigned')
        .then((list) {
      if (list.isNotEmpty) {
        saveList = list.map((assignment) {
          return SavedAssignment.fromJson(assignment!, assignment['caseId']);
        }).toList();
      }
    });
    return saveList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _setInitialSavedAssignmentsList(),
        builder: (context, AsyncSnapshot<List<SavedAssignment>> form) {
          if (form.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (form.hasError) {
            return Center(
              child: Text('Something Went Wrong ${form.error}'),
            );
          } else {
            return SavedAssignmentList(
              savedAssList: form.data!,
              renewListAfter: () {
                setState(() {});
              },
            );
          }
        },
      ),
    );
  }
}
