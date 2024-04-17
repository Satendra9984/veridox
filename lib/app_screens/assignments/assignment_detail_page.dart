import 'package:flutter/material.dart' hide Form;
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_widgets/row_detail_text.dart';
import 'package:veridox/form_screens/form_home_page.dart';
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
  /// for the application details segregation
  Map<String, dynamic> _applicantDetails = {},
      _coapplicantDetails = {},
      _otherDetails = {};

  /// getting data to display in detailsPage
  Future<void> _setAssignmentDetails() async {
    final res = await FirestoreServices.getAssignmentById(widget.caseId);
    Map<String, dynamic> data = Map<String, dynamic>.from(res!);
    // debugPrint('details $data');

    _setModifiedData(data);
    // set agency name
    final agency = await FirestoreServices.getAgency(_otherDetails['Agency']);
    debugPrint('Agency Id in details page -> ${_otherDetails['Agency']}\n\n');
    _otherDetails['Agency_Id'] = _otherDetails['Agency'];
    _otherDetails['Agency'] = agency['agency_name'];
  }

  /// modifying keys of assignment in Proper Notation for display purpose
  void _setModifiedData(Map<String, dynamic> data) {
    // setting applicant data details
    Map<String, dynamic> modifiedDataApplicant = {
      'Case Number': widget.caseId,
      'Name': data['applicant_name'],
      'Phone': data['applicant_phone'],
      'City': data['applicant_city'],
      'PinCode': data['applicant_pincode'],
      'PostOffice': data['applicant_post_office'],
      'State': data['applicant_state'],
    };
    _applicantDetails = modifiedDataApplicant;
    // debugPrint('modified data --> $modifiedDataApplicant\n\n');

    // setting coapplicant data details
    Map<String, dynamic> modifiedDataCoApplicant = {
      'Name': data['coapplicant_name'],
      'Phone': data['coapplicant_phone'],
      'City': data['coapplicant_city'],
      'PinCode': data['coapplicant_pincode'],
      'PostOffice': data['coapplicant_post_office'],
      'State': data['coapplicant_state'],
    };
    _coapplicantDetails = modifiedDataCoApplicant;
    // debugPrint('modified data --> $modifiedDataCoApplicant\n\n');

    // setting other details
    Map<String, dynamic> modifiedOtherDetails = {
      'Assigned Date': data['assigned_at'],
      'Application Type': data['document_type'],
      'Status': data['status'],
      'Agency': data['agency'],
    };
    _otherDetails = modifiedOtherDetails;
    // debugPrint('modified data --> $modifiedOtherDetails\n\n');
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignment Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: FutureBuilder(
            future: _setAssignmentDetails(),
            builder: (context, AsyncSnapshot<void> snapshot) {
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
                /// data is available to display
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Applicant Details
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Applicant Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._applicantDetails.keys
                        .map(
                          (value) => Container(
                            margin: const EdgeInsets.only(left: 20),
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: RowDetailsText(
                              heading: value,
                              value: _applicantDetails[value].toString(),
                            ),
                          ),
                        )
                        .toList(),
                    const SizedBox(height: 20),

                    /// Co-Applicant Details
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Co-Applicant Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._coapplicantDetails.keys
                        .map(
                          (value) => Container(
                            margin: const EdgeInsets.only(left: 20),
                            padding: const EdgeInsets.symmetric(vertical: 2.5),
                            child: RowDetailsText(
                              heading: value,
                              value: _coapplicantDetails[value].toString(),
                            ),
                          ),
                        )
                        .toList(),
                    const SizedBox(height: 20),

                    /// other details
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Other Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ..._otherDetails.keys
                        .map(
                          (value) => Container(
                            margin: const EdgeInsets.only(left: 20),
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: RowDetailsText(
                              heading: value,
                              value: _otherDetails[value].toString(),
                            ),
                          ),
                        )
                        .toList(),

                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 25.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (_otherDetails['Status'] == 'assigned')
                            ElevatedButton(
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(10),
                              ),
                              onPressed: () async {
                                /// adding assignment in savedAssignmentList/local database
                                await FirestoreServices.updateAssignmentStatus(
                                  status: 'in_progress',
                                  caseId: widget.caseId,
                                  agencyId: _otherDetails['Agency_Id'],
                                ).then((value) {
                                  navigatePushReplacement(
                                    context,
                                    FormHomePage(caseId: widget.caseId),
                                  );
                                }).catchError((error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text('Something went wrong')),
                                  );
                                });
                              },
                              child: const Text(
                                'Proceed for Verification',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                        ],
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
