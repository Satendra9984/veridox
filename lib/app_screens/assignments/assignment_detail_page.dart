import 'package:firebase_auth/firebase_auth.dart';
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
  const AssignmentDetailPage({Key? key, required this.caseId})
      : super(key: key);

  @override
  State<AssignmentDetailPage> createState() => _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends State<AssignmentDetailPage> {
  late SavedAssignmentProvider _savedAssignmentProvider;

  /// Function for checking if the given assignment with the caseId
  /// already exist in the local_database
  Future<bool> checkSaved() async {
    String _userId = FirebaseAuth.instance.currentUser!.uid;
    debugPrint('Checking for ${_userId}${widget.caseId}\n');
    return await SPServices().checkIfExists('${_userId}${widget.caseId}');
  }

  /// getting data to display in detailsPage
  Future<Map<String, dynamic>> _getAssignment() async {
    final res = await FirestoreServices.getAssignmentById(widget.caseId);
    debugPrint('res type in ass details page --> ${res.runtimeType}\n\n');
    return Map<String, dynamic>.from(res!);
  }

  @override
  initState() {
    _savedAssignmentProvider =
        Provider.of<SavedAssignmentProvider>(context, listen: false);
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
                    ...snapshot.data!.keys
                        .map(
                          (value) => Container(
                            margin: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    value.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    snapshot.data![value].toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ],
                );
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25.0),
        child: FutureBuilder(
          future: checkSaved(),
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              /// if assignment is not in the local database then adding it in
              return !snapshot.data!
                  ? ElevatedButton(
                      style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10),
                      ),
                      onPressed: () async {
                        /// adding assignment in savedAssignmentList/local database

                        await _savedAssignmentProvider
                            .addSavedAssignment(widget.caseId)
                            .then((value) {
                          debugPrint('Now navigating to Saved Assignment Page');
                          navigatePushReplacement(
                            context,
                            const SavedAssignmentsPage(),
                          );
                        });
                        // navigatePushReplacement(
                        //     context, const SavedAssignmentsPage());
                      },
                      child: const Text(
                        'Verify',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blueGrey),
                        elevation: MaterialStateProperty.all(10),
                      ),
                      onPressed: () {
                        navigatePushReplacement(
                            context, const SavedAssignmentsPage());
                      },
                      child: const Text(
                        'Already added',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    );
            }
          },
        ),
      ),
    );
  }
}
