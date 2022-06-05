import 'package:flutter/material.dart' hide Form;
import 'package:veridox/app_models/saved_assignment_model.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import '../../app_services/database/shared_pref_services.dart';

class AssignmentDetailPage extends StatefulWidget {
  // getting the caseId for further
  final String caseId;
  const AssignmentDetailPage({Key? key, required this.caseId})
      : super(key: key);

  @override
  State<AssignmentDetailPage> createState() => _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends State<AssignmentDetailPage> {

  /// Function for checking if the given assignment with the caseId
  /// already exist in the local_database
  Future<bool> checkSaved() async {
    return await SPServices().checkIfExists(widget.caseId);
  }


  Future<SavedAssignment> _getAssignment() async {
    final res1 = await FirestoreServices().getAssignmentById(widget.caseId);
    final res2 = await FirestoreServices().getFormDataById(widget.caseId);

    print(res1);
    SavedAssignment assignment = SavedAssignment.fromJson(res1!, res2);
    print(assignment.caseId);
    return assignment;
  }
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment details page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _getAssignment(),
            builder: (BuildContext context, AsyncSnapshot<SavedAssignment> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
