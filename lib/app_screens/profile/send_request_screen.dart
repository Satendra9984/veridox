import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veridox/app_providers/send_request_provider.dart';
import 'package:veridox/app_screens/profile/status_screen.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_widgets/custom_drop_down.dart';
import 'package:veridox/app_widgets/file_upload_button.dart';
import 'package:veridox/app_widgets/text_input.dart';
import 'package:veridox/app_widgets/submit_button.dart';
import '../../app_utils/app_functions.dart';
import '../login/login_page.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({Key? key}) : super(key: key);

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  late FirebaseAuth _auth;
  late SendRequestProvider _provider;
  String dropDown = 'Select your agency';

  @override
  void initState() {
    super.initState();
    _auth = FirebaseAuth.instance;
    _provider = SendRequestProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        margin: const EdgeInsets.all(15),
        child: SubmitButton(
          icon: const Icon(
            Icons.send,
            size: 15,
          ),
          text: 'Send Request',
          onPress: () async {
            debugPrint('submit before');

            /// validating and sending request
            await _validateAndSendRequest();
            debugPrint('submit after');

            // Navigator.pop(context);
          },
        ),
      ),
      body: Container(
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
            child: Form(
              key: _provider.getFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Send Request',
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.lightBlue),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'To the agency you want to join',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  /// name
                  CustomTextInput(
                    password: false,
                    controller: _provider.getNameCtrl,
                    text: 'Name',
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  /// email
                  CustomTextInput(
                    controller: _provider.getEmailCtrl,
                    text: 'Email',
                    password: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!value.isEmail) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  FutureBuilder(
                    future: FirestoreServices.getAgencyList(),
                    builder: (context,
                        AsyncSnapshot<List<Map<String, dynamic>>>? list) {
                      List<Map<String, dynamic>>? data = list?.data;
                      if (data == null) {
                        return const Text('');
                      }

                      return CustomDropDownButton(
                        list: data
                            .map(
                              (e) => e['agency_name'].toString(),
                            )
                            .toList(),
                        onChanged: (int value) {
                          dropDown = data[value]['agency_name'];
                          _provider.dropDown = dropDown;
                          _provider.agencyUid = data[value]['id'];
                          // debugPrint('${data[value]['id']}\n');
                          // debugPrint('${data[value]['agency_name']}\n');
                        },
                        hintText: 'Select Agency',
                      );
                    },
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  FileUploadButton(
                    text: 'Aadhar Card',
                    location:
                        'aadhar/${FirebaseAuth.instance.currentUser!.uid}',
                    cntrl: _provider.getAadharRef,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  FileUploadButton(
                    text: 'Pan Card',
                    location:
                        'pan_card/${FirebaseAuth.instance.currentUser!.uid}',
                    cntrl: _provider.getPanRef,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validateAndSendRequest() async {
    if (_provider.getFormKey.currentState != null &&
        _provider.getFormKey.currentState!.validate()) {
      await _provider.submit(context).then(
            (value) => {
              Navigator.of(context).pushReplacement(
                CupertinoPageRoute(
                  builder: (context) {
                    return StatusScreen(
                        uid: FirebaseAuth.instance.currentUser!.uid);
                  },
                ),
              ),
            },
          );
    }
  }
}
