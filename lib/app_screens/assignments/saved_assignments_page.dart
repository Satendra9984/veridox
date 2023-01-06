import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_models/saved_assignment_model.dart';
import 'package:veridox/app_screens/assignments/saved_assignment_list.dart';

class SavedAssignmentsPage extends StatefulWidget {
  static String savedAssignmentPageName = '/saved_assignment_page';
  const SavedAssignmentsPage({Key? key}) : super(key: key);
  @override
  State<SavedAssignmentsPage> createState() => _SavedAssignmentsPageState();
}

class _SavedAssignmentsPageState extends State<SavedAssignmentsPage> {
  late String _uid;

  @override
  void initState() {
    _uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<List<SavedAssignment>> _setInitialSavedAssignmentsList() async* {
    List<SavedAssignment> list = [];
    await FirebaseFirestore.instance
        .collection('field_verifier')
        .doc(_uid)
        .collection('assignments')
        .where(
          'status',
          isEqualTo: 'in_progress',
        )
        .get()
        .then((lists) async {
      if (lists.docs.isNotEmpty) {
        lists.docs.forEach((elementQuery) {
          var element = elementQuery.data();
          element['caseId'] = elementQuery.id;
          list.add(SavedAssignment.fromJson(element, elementQuery.id));
        });
      }
      await FirebaseFirestore.instance
          .collection('field_verifier')
          .doc(_uid)
          .collection('assignments')
          .where('status', isEqualTo: 'reassigned')
          .get()
          .then((lists) {
        if (lists.docs.isNotEmpty) {
          lists.docs.forEach((elementQuery) {
            var element = elementQuery.data();
            element['caseId'] = elementQuery.id;
            list.add(SavedAssignment.fromJson(element, elementQuery.id));
          });
        }
      });
    });

    yield list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _setInitialSavedAssignmentsList(),
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
