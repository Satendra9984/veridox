import 'package:flutter/cupertino.dart' hide Form;
import 'package:flutter/material.dart' hide Form;
import 'package:provider/provider.dart';
import 'package:veridox/app_models/saved_assignment_model.dart';
import 'package:veridox/app_providers/saved_assignment_provider.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import '../app_services/database/shared_pref_services.dart';
import '../app_widgets/basic_details.dart';
import '../templates/form.dart';

class AssignmentDetailPage extends StatefulWidget {
  /// getting the caseId
  final String caseId;
  const AssignmentDetailPage({Key? key, required this.caseId})
      : super(key: key);

  @override
  State<AssignmentDetailPage> createState() => _AssignmentDetailPageState();
}

class _AssignmentDetailPageState extends State<AssignmentDetailPage> {
  bool _isAssignmentSaved = true;

  /// Function for checking if the given assignment with the caseId
  /// already exist in the local_database

  void _showPopUp() async {
    /// TODO : IN CASE IF _getAssignment() did not worked
    /// show a popUpMenu and return to the previous screen
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Container(
            color: CupertinoColors.white,
            child: Column(
              children: [
                Text('Return to preivous screen'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  initState() {
    super.initState();
    print('init state called -->> ');
  }

  /// Getting the basic details of the assignment from the available sources
  /// firebase or local_storage and saving the assignment with form_data(!)

  Future<SavedAssignment?> _getAssignment() async {
    print('get assignmnet called -->>');
    final saveAssProvider =
        Provider.of<SavedAssignmentProvider>(context, listen: false);

    if (await saveAssProvider.checkSaved(widget.caseId)) {
      _isAssignmentSaved = true;
    } else {
      _isAssignmentSaved = false;
    }

    final data = await saveAssProvider.getAssignment(widget.caseId);
    print('getting data --->>> $data');
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignemnt details page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _getAssignment(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data != null) {
                final details = snapshot.data as SavedAssignment;
                final data = details.formData;

                final basicData = Map.from(data["pages"][0]["page"]);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: basicData.entries.map((entry) {
                        return BasicDetails(
                          value: entry.value,
                          title: entry.key,
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_isAssignmentSaved == false) {
                              /// Saving the Saved_Assignment as json_data in the local database
                              await Provider.of<SavedAssignmentProvider>(
                                      context,
                                      listen: false)
                                  .addSavedAssignment(
                                details.toJson(),
                              );
                              _isAssignmentSaved = true;
                              print('saving saved assi--->>>>');
                              // await SPServices().setFormDataById(
                              //   details.formData,
                              //   widget.caseId,
                              // );
                            }
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                // TODO: PASS THE JSON DATA TO Form() got from _getAssignment()
                                builder: (context) =>
                                    Form(saveAssignment: details),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(10),
                            minimumSize:
                                MaterialStateProperty.all(const Size(150, 40)),
                          ),
                          child: const Text(
                            'Verify',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Column(
                    children: [
                      const Text('Something Went Wrong'),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        child: const Text('Click To previous screen'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
