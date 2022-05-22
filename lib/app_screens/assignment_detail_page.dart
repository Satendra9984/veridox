import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  // getting the caseId for further
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
  Future<bool> checkSaved() async {
    return await SPServices().checkIfExists(widget.caseId);
  }

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
    // await FirebaseFirestore.instance
    //     .collection('assignments')
    //     .doc('ISFbwFZ4tQybjvbQw6pV')
    //     .update({
    //       "report_data": {
    //         "pages": [
    //           {
    //             "page": [
    //               {
    //                 "Policy Number": "7583046",
    //                 "Customer Name": "Subhadeep Chowdhary",
    //                 "Applied for policy": "Yes",
    //                 "Application Date": "01/03/22",
    //                 "Date and time of field visit": "03/01/22 12:00pm",
    //                 "Age": "NA",
    //                 "Application No.": "1234567"
    //               }
    //             ]
    //           },
    //           {
    //             "page": [
    //               {"type": "text", "title": "customer details"},
    //               {"type": "text_input", "title": ""}
    //             ]
    //           },
    //           {
    //             "page": [
    //               {"type": "input"},
    //               {}
    //             ]
    //           },
    //           {
    //             "page": [
    //               {"type": "checkbox"}
    //             ]
    //           }
    //         ]
    //       }
    //     })
    //     .then((value) => print('successfule'))
    //     .catchError((error) => print('unsuccessful -->  $error'));
  }

  @override
  initState() {
    super.initState();
  }

  /// Getting the basic details of the assignment from the available sources
  /// firebase or local_storage and saving the assignment with form_data(!)
  Future<SavedAssignment?> _getAssignment() async {
    if (await checkSaved()) {
      /// FETCHING DATA FROM THE LOCAL_STORAGE
      try {
        final mappedData = await SPServices().getSavedAssignment(widget.caseId);
        final SavedAssignment savedAssignment =
            SavedAssignment.fromJson(mappedData, widget.caseId);
        return savedAssignment;
      } catch (e) {
        print('hive error--> $e');
        _showPopUp();
      }
    } else {
      try {
        /// FETCH DATA FROM THE FIRESTORE
        print('fetching data from firestore\n\n\n');
        final mappedData =
            await FirestoreServices().getAssignmentById(widget.caseId);
        // print(mappedData!['report_data']);

        if (mappedData != null) {
          print('mappedData is not null\n\n\n');
          final SavedAssignment savedAssignment =
              SavedAssignment.fromJson(mappedData, widget.caseId);
          print('got saved assignment\n\n\n');

          /// assignment is not saved in local database
          _isAssignmentSaved = false;
          return savedAssignment;
        } else {
          print('mappedData is not null\n\n\n');
          return null;
        }
      } catch (e) {
        print('firebase error--> $e');
        _showPopUp();
      }
    }
    return null;
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
                final basicData =
                    Map<String, dynamic>.from(data['pages'][0]['page']);
                print('basicData-->  ' + jsonEncode(basicData));
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: MAKING A LIST OF WIDGETS IN COLUMN
                    Column(
                      children: basicData.forEach((key, value) {
                        return Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(key),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(value.toString()),
                            ),
                          ],
                        );
                      }),
                    ),

                    // const BasicDetails(
                    //   title: 'Policy Number',
                    //   value: '7583046',
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const BasicDetails(
                    //   title: 'Customer Name',
                    //   value: 'Singh Kumar Rahul',
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const BasicDetails(
                    //   title: 'Applied for Policy',
                    //   value: 'YES',
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const BasicDetails(
                    //   title: 'Application Date',
                    //   value: 'August 11, 2021',
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const BasicDetails(
                    //   title: 'Date and time of field visit',
                    //   value: 'September 06,2021 & 5:00 PM',
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const BasicDetails(
                    //   title: 'Age',
                    //   value: 'NA',
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const BasicDetails(
                    //   title: 'Received The policy',
                    //   value: 'YES',
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // const BasicDetails(
                    //   title: 'APP NO',
                    //   value: 'A60729340',
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // For the Verify button
                    Flexible(
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_isAssignmentSaved == false) {
                              /// TODO: SHOW A SAVING INDICATOR
                              /// Saving the data in the local database
                              await SPServices().setSavedAssignment(
                                details.toJson(),
                              );
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
