import 'package:flutter/material.dart';
import 'package:veridox/app_models/saved_assignment_model.dart';
import 'package:veridox/app_screens/assignments/submitted_assignment_list.dart';
import 'package:veridox/app_services/database/firestore_services.dart';

class SubmittedAssignmentsPage extends StatefulWidget {
  const SubmittedAssignmentsPage({Key? key}) : super(key: key);
  @override
  State<SubmittedAssignmentsPage> createState() =>
      _SubmittedAssignmentsPageState();
}

class _SubmittedAssignmentsPageState extends State<SubmittedAssignmentsPage>
    with AutomaticKeepAliveClientMixin {
  // late SavedAssignmentProvider _provider;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<SavedAssignment>> _setInitialSubmittedAssignmentsList() async {
    List<SavedAssignment> subList = [];
    await FirestoreServices.getAssignmentsByStatus(filter1: 'submitted')
        .then((list) {
      if (list != null && list.isNotEmpty) {
        subList = list.map((assignment) {
          return SavedAssignment.fromJson(assignment, assignment['caseId']);
        }).toList();
      }
    });
    // debugPrint('subList-> $subList');
    return subList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder(
        future: _setInitialSubmittedAssignmentsList(),
        builder: (context, AsyncSnapshot<List<SavedAssignment>> form) {
          if (form.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (form.hasError) {
            return Center(
              child: Text('Something Went Wrong'),
            );
          } else {
            debugPrint('Submitted ass page is rebuilt');
            return SubmittedAssignmentList(
              savedAssList: form.data!,
            );
          }
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
