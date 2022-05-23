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
      // await FirebaseFirestore.instance
      //     .collection('assignments')
      //     .doc('ISFbwFZ4tQybjvbQw6pV')
      //     .update({
      //   "report_data": {
      //     // "id": "12345ab893adfjADF9aksl",
      //     "pages": [
      //       {
      //         "page": {
      //           "Policy Number": "7583046",
      //           "Customer Name": "Subhadeep Chowdhary",
      //           "Applied for policy": "Yes",
      //           "Application Date": "01/03/22",
      //           "Date and time of field visit": "03/01/22 12:00pm",
      //           "Age": "NA",
      //           "Application No.": "1234567"
      //         }
      //       },
      //       {
      //         "page": [
      //           {
      //             "type": "text",
      //             "label": "Death Claim Investigation Report",
      //             "heading_type": 1
      //           },
      //           {"type": "text", "label": "Heading 2", "heading_type": 2},
      //           {"type": "text", "label": "Heading 3", "heading_type": 3},
      //           {
      //             "type": "single_line_input",
      //             "label": "Other life/health insurance*",
      //             "value": "",
      //             "input_type": "string/integer/email",
      //             "hint": "yahan likho"
      //           },
      //           {
      //             "type": "single_line_row_input",
      //             "label": "Other life/health insurance*",
      //             "value": "",
      //             "input_type": "string/integer/email",
      //             "hint": "yahan likho"
      //           },
      //           {
      //             "type": "table_input",
      //             "label": "Profile of the life assured*",
      //             "row_labels": [
      //               "Name",
      //               "Date of Birth",
      //               "Age",
      //               "Marital Status",
      //               "Occupation",
      //               "Annual Income",
      //               "Education",
      //               "Other life/health insurance",
      //               "Address",
      //               "Nominee Relationship"
      //             ],
      //             "column_labels": [
      //               "As per investigation",
      //               "Mismatch noted (Yes/No)",
      //               "Evidence procured (Yes/No)"
      //             ],
      //             "value": [
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               },
      //               {
      //                 "As per investigation": "",
      //                 "Mismatch noted (Yes/No)": "",
      //                 "Evidence procured (Yes/No)": ""
      //               }
      //             ]
      //           },
      //           {
      //             "type": "multi_line_input",
      //             "label": "Final Remarks*-:",
      //             "value": null,
      //             "input_type": "string",
      //             "hint": "yahan likho"
      //           },
      //           {
      //             "type": "dropdown_menu",
      //             "label": "Select Options",
      //             "value": null,
      //             "options": ["1", "2", "3", "4", "5"],
      //             "hint": "yahan likho"
      //           },
      //           {
      //             "type": "toggle_button",
      //             "label":
      //                 "Collect Ration Card / Parivar Card/Voter ID or other possible age proofs of all family members*",
      //             "value": false,
      //             "lines": "multi line",
      //             "heading_type": 1
      //           },
      //           {
      //             "type": "date_time_picker",
      //             "label": "Visited On",
      //             "value": ""
      //           },
      //           {"type": "location_image", "value": "firebase_storage_id"},
      //           {"type": "image_input", "value": "firebase_storage_id"}
      //         ]
      //       },
      //       {"page": []},
      //       {"page": []}
      //     ]
      //   }
      // });
      try {
        final mappedData = await SPServices().getSavedAssignment(widget.caseId);
        print('sp mappedDatatype-->  ${mappedData.runtimeType}');

        final SavedAssignment saveAssignment =
            SavedAssignment.fromJson(mappedData, widget.caseId);
        return saveAssignment;
      } catch (e) {
        print('hive error--> $e');
        _showPopUp();
      }
    } else {
      try {
        /// FETCH DATA FROM THE FIRESTORE
        // await FirebaseFirestore.instance
        //     .collection('assignments')
        //     .doc('ISFbwFZ4tQybjvbQw6pV')
        //     .update({
        //       "report_data": {
        //
        //         "pages": [
        //           {
        //             "page": {
        //               "Policy Number": "7583046",
        //               "Customer Name": "Subhadeep Chowdhary",
        //               "Applied for policy": "Yes",
        //               "Application Date": "01/03/22",
        //               "Date and time of field visit": "03/01/22 12:00pm",
        //               "Age": "NA",
        //               "Application No.": "1234567"
        //             }
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
        //     .then((value) => print('successfult'))
        //     .catchError((error) => print('unsuccessful --> $error'));
        // print('fetching data from firestore\n\n\n');
        final mappedData =
            await FirestoreServices().getAssignmentById(widget.caseId);
        // print(mappedData!['report_data']);

        if (mappedData != null) {
          // print('mappedData is not null\n\n\n');
          final SavedAssignment savedAssignment =
              SavedAssignment.fromJson(mappedData, widget.caseId);
          // print('got saved assignment\n\n\n');

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
