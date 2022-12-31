import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:veridox/app_screens/bottom_nav_bar_screens/home_page.dart';
import 'package:veridox/app_screens/profile/send_request_screen.dart';
import 'package:veridox/app_utils/app_functions.dart';

import '../../app_widgets/default_text.dart';
import '../../app_widgets/profile_options.dart';
import '../pdfviewer.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key, required this.uid}) : super(key: key);
  final String uid;
  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen>
    with AutomaticKeepAliveClientMixin {
  String s = 'requested';

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>?> _setFieldVerifierRequestDetails() async {
    /// get request from add_requests

    DocumentSnapshot<Map<String, dynamic>> snap = await FirebaseFirestore
        .instance
        .collection('add_requests')
        .doc(widget.uid)
        .get();

    Map<String, dynamic>? req = snap.data();
    debugPrint('request data ${req}');
    if (req != null) {
      s = req['status'];
      s = s.toUpperCase();
      return req;
      //   /// now get request details from agency to showcase
      //   if (s != 'ACCEPTED') {
      //     DocumentSnapshot<Map<String, dynamic>> rawRequestDetails =
      //         await FirebaseFirestore.instance
      //             .collection('add_requests')
      //             .doc(widget.uid)
      //             .get();
      //
      //     Map<String, dynamic>? fullRequestDetails = rawRequestDetails.data();
      //     // debugPrint('fullDetails1 --> $fullRequestDetails');
      //
      //     return fullRequestDetails;
      //   }
      //   DocumentSnapshot<Map<String, dynamic>> rawRequestDetails =
      //       await FirebaseFirestore.instance
      //           .collection('field_verifier')
      //           .doc(widget.uid)
      //           .get()
      //           .catchError((error) {
      //     // debugPrint('error on rawrequest-> ${error}\n\n');
      //   });
      //   Map<String, dynamic>? fullRequestDetails = rawRequestDetails.data();
      //   debugPrint('fullDetails --> $fullRequestDetails');
      //   return fullRequestDetails;
    }
    return null;
  }

  Icon _getStatusIcon() {
    if (s == 'REQUESTED') {
      return Icon(
        Icons.pending_actions,
        color: Colors.orange,
        size: 25,
      );
    } else if (s == 'ACCEPTED') {
      return Icon(
        Icons.check_circle_outline_rounded,
        color: Colors.green,
        size: 25,
      );
    }
    return Icon(
      FontAwesomeIcons.exclamation,
      color: Colors.red,
      size: 25,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Container(
              alignment: Alignment.topLeft,
              color: Colors.white,
              margin: const EdgeInsets.only(
                  right: 8.0, left: 15, top: 5, bottom: 0),
              child: Image.asset(
                'assets/launcher_icons/veridocs_launcher_icon.jpeg',
                fit: BoxFit.contain,
                height: 50,
                width: 150,
              ),
            ),
            const SizedBox(height: 45),
            FutureBuilder(
              future: _setFieldVerifierRequestDetails(),
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snap.hasData && snap.data != null) {
                  Map<String, dynamic> data = snap.data as Map<String, dynamic>;
                  return Container(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Application Status',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          /// status
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      s,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    _getStatusIcon(),
                                  ],
                                ),
                                if (s == 'ACCEPTED')
                                  TextButton(
                                    onPressed: () async {
                                      /// delete request
                                      await FirebaseFirestore.instance
                                          .collection('add_requests')
                                          .doc(widget.uid)
                                          .delete()
                                          .then((value) {
                                        /// now navigate to HomePage
                                        navigatePushReplacement(
                                            context, HomePage());
                                      });
                                    },
                                    child: Text(
                                      'Dashboard',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                if (s == 'REJECTED')
                                  TextButton(
                                    onPressed: () async {
                                      /// delete request
                                      await FirebaseFirestore.instance
                                          .collection('add_requests')
                                          .doc(widget.uid)
                                          .delete()
                                          .then((value) {
                                        navigatePushReplacement(
                                            context, SendRequestScreen());
                                      });
                                    },
                                    child: Text(
                                      'BACK',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 30),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Applicant Details',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                                color: Colors.lightBlue,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          /// Application Details
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// FV name
                                HeadingWidgetForTextDisplay(heading: 'Name'),
                                CustomDefaultText(
                                    text: data['name'], password: false),
                                const SizedBox(height: 25),

                                /// FV email
                                HeadingWidgetForTextDisplay(
                                    heading: 'Email Address'),
                                CustomDefaultText(
                                    text: data['email'], password: false),
                                const SizedBox(height: 25),

                                /// agency name
                                HeadingWidgetForTextDisplay(
                                    heading: 'Agency Name'),
                                CustomDefaultText(
                                    text: data['agency_name'] ?? 'agency',
                                    password: false),
                                const SizedBox(height: 15),

                                const SizedBox(height: 10),
                              ],
                            ),
                          ),

                          /// show aadhar card
                          ProfileOptions(
                            onPress: () async {
                              String ref = await FirebaseStorage.instance
                                  .ref()
                                  .child(
                                      'aadhar/${FirebaseAuth.instance.currentUser!.uid}')
                                  .getDownloadURL();
                              // debugPrint('ref full path --> $ref\n');
                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PdfViewerPage(
                                      storageRef: ref,
                                      hintText: 'Aadhar Card',
                                    );
                                  },
                                ),
                              );
                            },
                            option: 'Aadhar Card',
                            valueIcon: Icon(
                              Icons.document_scanner_rounded,
                              color: Colors.green.shade900,
                            ),
                          ),

                          /// show pan card
                          ProfileOptions(
                            onPress: () async {
                              String ref = await FirebaseStorage.instance
                                  .ref()
                                  .child(
                                      'pan_card/${FirebaseAuth.instance.currentUser!.uid}')
                                  .getDownloadURL();

                              await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PdfViewerPage(
                                      storageRef: ref,
                                      hintText: 'Pan Card',
                                    );
                                  },
                                ),
                              );
                            },
                            option: 'Pan Card',
                            valueIcon: Icon(
                              Icons.document_scanner_rounded,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (snap.hasError) {
                  return Center(
                    child: Text('Some Error Occurred ${snap.error}'),
                  );
                } else if (snap.connectionState == ConnectionState.active) {
                  return Center(
                    child: Text('Some Error Occurred ${snap.error}'),
                  );
                } else {
                  return Center(
                    child: Text('Some Error Occurred'),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class HeadingWidgetForTextDisplay extends StatelessWidget {
  final String heading;
  const HeadingWidgetForTextDisplay({
    Key? key,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 0, bottom: 5),
      child: Text(
        heading,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
    );
  }
}
