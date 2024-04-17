import 'package:flutter/material.dart';
import 'package:veridox/app_models/saved_assignment_model.dart';
import 'package:veridox/app_screens/assignments/submitted_assignment_list.dart';
import 'package:veridox/app_services/database/firestore_services.dart';

import 'my_assignment_list.dart';

class MyAssignmentsPage extends StatefulWidget {
  const MyAssignmentsPage({Key? key}) : super(key: key);
  @override
  State<MyAssignmentsPage> createState() => _MyAssignmentsPageState();
}

class _MyAssignmentsPageState extends State<MyAssignmentsPage>
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

  Future<List<SavedAssignment>> _setInitialAllAssignmentsList() async {
    List<SavedAssignment> subList = [];
    await FirestoreServices.getAllAssignments().then((list) {
      if (list.isNotEmpty) {
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
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        shadowColor: Colors.lightBlueAccent.shade100.withOpacity(0.30),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Image.asset(
          'assets/launcher_icons/veridocs_launcher_icon.jpeg',
          fit: BoxFit.contain,
          height: 50,
          width: 150,
        ),
      ),
      body: FutureBuilder(
        future: _setInitialAllAssignmentsList(),
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
            debugPrint('My assignment page is rebuilt');
            return MyAssignmentList(
              savedAssList: form.data!,
            );
          }
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => false;
}
