import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'approved_assignment_list.dart';

class ApprovedAssignmentsPage extends StatefulWidget {
  const ApprovedAssignmentsPage({Key? key}) : super(key: key);
  @override
  State<ApprovedAssignmentsPage> createState() =>
      _ApprovedAssignmentsPageState();
}

class _ApprovedAssignmentsPageState extends State<ApprovedAssignmentsPage>
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

  Future<List<DocumentSnapshot>> _setInitialSubmittedAssignmentsList() async {
    List<DocumentSnapshot> subList = [];
    try {
      await FirebaseFirestore.instance
          .collection('field_verifier')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('assignments')
          .where('status', isEqualTo: 'approved')
          // .orderBy("", descending: false)
          .limit(5)
          .get()
          .then((value) {
        // debugPrint('value-> ${value.docs.first.data()}');
        subList.addAll(value.docs);
      });
    } catch (error) {}
    // debugPrint('subList-> $subList');
    return subList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: FutureBuilder(
        future: _setInitialSubmittedAssignmentsList(),
        builder: (context, AsyncSnapshot<List<DocumentSnapshot>> form) {
          if (form.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (form.hasError) {
            return Center(
              child: Text('Something Went Wrong'),
            );
          } else {
            // debugPrint('Submitted ass page is rebuilt');
            return ApprovedAssignmentList(
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
