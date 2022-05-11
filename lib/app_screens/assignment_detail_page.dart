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
  Future<SavedAssignment?> getAssignment() async {
    final prov = Provider.of<SavedAssignmentProvider>(context, listen: false);
    final data = await FirestoreServices().getAssignmentById(widget.caseId);
    final formData = await FirestoreServices().getFormDataById(widget.caseId);
    await prov.addSaveAssignments(widget.caseId);
    try {
      final js = await prov.findById(widget.caseId);
      SavedAssignment saveAsgn = SavedAssignment.fromJson(js!, js);
      return saveAsgn;
    } catch (e) {
      //assignment not found
      return null;
    }
  }

  Future<bool> checkSaved() async {
    return await SPServices().checkIfExists(widget.caseId);
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
            future: getAssignment(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final details = snapshot.data as SavedAssignment;
                final data = details.formData;

                // return data.map((key, value) {
                //  TODO : NOW MAP EACH FORM DATA FIELD INTO A WIDGET
                // });

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // TODO: MAKING A LIST OF WIDGETS IN COLUMN
                    Column(
                      children: data.entries.map(
                        (e) {
                          return const Text('e');
                        },
                      ).toList(),
                    ),

                    const BasicDetails(
                      title: 'Policy Number',
                      value: '7583046',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const BasicDetails(
                      title: 'Customer Name',
                      value: 'Singh Kumar Rahul',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const BasicDetails(
                      title: 'Applied for Policy',
                      value: 'YES',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const BasicDetails(
                      title: 'Application Date',
                      value: 'August 11, 2021',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const BasicDetails(
                      title: 'Date and time of field visit',
                      value: 'September 06,2021 & 5:00 PM',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const BasicDetails(
                      title: 'Age',
                      value: 'NA',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const BasicDetails(
                      title: 'Received The policy',
                      value: 'YES',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const BasicDetails(
                      title: 'APP NO',
                      value: 'A60729340',
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    //TODO: ADD A PDF BOX
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.40,
                            padding: const EdgeInsets.all(0),
                            // color: Colors.redAccent,
                            child: const SelectableText(
                              'Customer Pdf ',
                              autofocus: false,
                              style: TextStyle(
                                fontSize: 16,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                constraints: const BoxConstraints.tightFor(),
                                padding: const EdgeInsets.all(3),
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10.0)),
                                  // shape: BoxShape.circle,
                                ),
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    // For the Verify button
                    Flexible(
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: FETCH THE DATA FROM FIREBASE --> No Needed anymore
                            // TODO: SAVE THE ASSIGNMENT AND THEN FETCH THE SAME ASSIGNMENT FROM THE SAVED_ASSIGNMENTS --> also not needed anymore

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
              }
            },
          ),
        ),
      ),
    );
  }
}
