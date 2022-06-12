import 'package:flutter/material.dart' hide Form;
import 'package:provider/provider.dart';
import 'package:veridox/app_providers/saved_assignment_provider.dart';
import 'package:veridox/app_screens/assignments/saved_assignments_page.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import '../../app_services/database/shared_pref_services.dart';
import '../../app_utils/app_functions.dart';

class AssignmentDetailPage extends StatefulWidget {
  // getting the caseId for further
  final String caseId;
  const AssignmentDetailPage({Key? key, required this.caseId}) : super(key: key);

  @override
  State<AssignmentDetailPage> createState() => _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends State<AssignmentDetailPage> {

  late SavedAssignmentProvider _savedAssignmentProvider;

  /// Function for checking if the given assignment with the caseId
  /// already exist in the local_database
  Future<bool> checkSaved() async {
    return await SPServices().checkIfExists(widget.caseId);
  }

  Future<Map<String, dynamic>> _getAssignment() async {
    final res = await FirestoreServices().getAssignmentById(widget.caseId);
    return res!;
  }
  @override
  initState() {
    _savedAssignmentProvider = Provider.of<SavedAssignmentProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25.0),
        child: FutureBuilder(
          future: checkSaved(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            } else {
              return !snapshot.data! ? ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                ),
                onPressed: () {
                  _savedAssignmentProvider.addSavedAssignment(widget.caseId);
                  navigatePushReplacement(context, const SavedAssignmentsPage());
                },
                child: const Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),) : ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                  elevation: MaterialStateProperty.all(10),
                ),
                onPressed: () {},
                child: const Text(
                  'Already added',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),);
            }
            }

        ),
      ),
      appBar: AppBar(
        title: const Text('Assignment details page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _getAssignment(),
            builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                );
              } else {
                return Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ...snapshot.data!.keys.map((value) => ListTile(
                      leading: Text(value), title: Text(snapshot.data![value] ?? ''),
                    )).toList(),

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
