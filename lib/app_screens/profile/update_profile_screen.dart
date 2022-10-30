import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veridox/app_providers/send_request_provider.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_widgets/basic_details.dart';
import 'package:veridox/app_widgets/custom_drop_down.dart';
import 'package:veridox/app_widgets/default_text.dart';
import 'package:veridox/app_widgets/file_upload_button.dart';
import 'package:veridox/app_widgets/profile_options.dart';
import 'package:veridox/app_widgets/text_input.dart';
import 'package:veridox/app_widgets/submit_button.dart';
import '../../app_utils/app_functions.dart';
import '../home_page.dart';
import '../login/login_page.dart';
import '../pdfviewer.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late FirebaseAuth _auth;
  late SendRequestProvider _provider;
  String dropDown = 'Select your agency';

  Map<String, dynamic>? _fieldVerifierDetails;

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _provider = SendRequestProvider();
  }

  Future<Map<String, dynamic>?> _setFieldVerifierDetailsDetails() async {
    try {
      _fieldVerifierDetails = await FirestoreServices.getFieldVerifierData(
          userId: _auth.currentUser!.uid);
      debugPrint('field_verifier --> $_fieldVerifierDetails\n');
      return _fieldVerifierDetails;
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 134,
        leading: Container(
          margin:
              const EdgeInsets.only(right: 8.0, left: 15, top: 4, bottom: 4),
          child: Image.asset(
            'assets/launcher_icons/veridocs_launcher_icon.jpeg',
            fit: BoxFit.contain,
            height: 84,
            width: 134,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        FirebaseAuth.instance.currentUser!.phoneNumber
                            .toString(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                    ],
                  ),
                  onTap: () async {
                    await _auth.signOut();
                    navigatePushReplacement(context, const LogInPage());
                  },
                ),
              ];
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0XFFf0f5ff),
      body: FutureBuilder(
          future: _setFieldVerifierDetailsDetails(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasData) {
              Map<String, dynamic> data = snap.data as Map<String, dynamic>;
              return Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0XFFf0f5ff), Colors.white],
                  ),
                ),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  // physics: NeverScrollableScrollPhysics(),
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
                            'Profile Details',
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustomDefaultText(text: data['name'], password: false),
                        const SizedBox(height: 10),
                        CustomDefaultText(text: data['email'], password: false),
                        const SizedBox(height: 10),
                        CustomDefaultText(
                            text: data['agency_name'] ?? 'agency',
                            password: false),
                        const SizedBox(height: 10),

                        /// TODO: SHOW AADHAR BUTTON
                        // ElevatedButton(
                        //   onPressed: () async {
                        //     await Navigator.of(context).push(
                        //       MaterialPageRoute(
                        //         builder: (context) {
                        //           return PdfViewerPage(
                        //             storageRef:
                        //                 'aadhar/${FirebaseAuth.instance.currentUser!.uid}',
                        //             hintText: 'Aadhar Card',
                        //           );
                        //         },
                        //       ),
                        //     );
                        //   },
                        //   child: Center(
                        //     child: Text('Aadhar'),
                        //   ),
                        //   style: ElevatedButton.styleFrom(
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //   ),
                        // ),

                        const SizedBox(height: 10),
                        ProfileOptions(
                          onPress: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return PdfViewerPage(
                                    storageRef:
                                        'aadhar/${FirebaseAuth.instance.currentUser!.uid}',
                                    hintText: 'Pan Card',
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
                        ProfileOptions(
                          onPress: () async {
                            await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return PdfViewerPage(
                                    storageRef:
                                        'pan_card/${FirebaseAuth.instance.currentUser!.uid}',
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
                ),
              );
            } else {
              return Center(
                child: Text('Some Error Occurred'),
              );
            }
          }),
    );
  }
}
