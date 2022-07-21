import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_providers/send_request_provider.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_widgets/custom_drop_down.dart';
import 'package:veridox/app_widgets/file_upload_button.dart';
import 'package:veridox/app_widgets/text_input.dart';
import 'package:veridox/app_widgets/submit_button.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({Key? key}) : super(key: key);

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  final GlobalKey _key = GlobalKey();
  late SendRequestProvider _provider;
  String dropDown = 'Select your agency';

  @override
  void initState() {
    super.initState();
    _provider = SendRequestProvider();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
            onPress: () {},
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0XFFf0f5ff), Colors.white])),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: _key,
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
                                fontSize: 60,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'To the agency you want to join',
                            style: TextStyle(fontSize: 23),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 60,
                    ),

                    /// name
                    CustomTextInput(
                      password: false,
                      controller: _provider.getNameCtrl,
                      text: 'Name',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    /// phone
                    CustomTextInput(
                      password: false,
                      controller: _provider.getPhoneCtrl,
                      text: 'Phone Number',
                      keyboardType: TextInputType.phone,
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
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    /// pan
                    /// aadhar
                    /// profile photo
                    /// address

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
                                _provider.agencyUid = data[value]['id'];
                                debugPrint('$dropDown\n');
                              });
                        }),

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
                      cntrl: _provider.getPhoneCtrl,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
