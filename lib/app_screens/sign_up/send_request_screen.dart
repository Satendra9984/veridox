import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_widgets/custom_drop_down.dart';
import 'package:veridox/app_widgets/form_text_input.dart';
import 'package:veridox/app_widgets/submit_button.dart';
import 'package:veridox/app_widgets/text_input.dart';

class SendRequestScreen extends StatefulWidget {
  const SendRequestScreen({Key? key}) : super(key: key);

  @override
  State<SendRequestScreen> createState() => _SendRequestScreenState();
}

class _SendRequestScreenState extends State<SendRequestScreen> {
  final GlobalKey _key = GlobalKey();
  // final FirestoreServices _firestoreServices = FirestoreServices();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String dropDown = 'select options';

  @override
  void initState() {
    // TODO: implement initState
    debugPrint('sendrequest screen\n\n');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFffffff),
        appBar: AppBar(
          title: const Text('Send Request'),
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9.0),
          ),
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
                    /// name
                    FormTextInput(
                      controller: _nameController,
                      label: 'Name',
                      hintText: 'veridocs',
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    /// phone
                    FormTextInput(
                      controller: _phoneController,
                      label: 'Phone Number',
                      hintText: '9988776655',
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    /// email
                    FormTextInput(
                      controller: _emailController,
                      label: 'Email',
                      hintText: 'veridocs@gmail.com',
                    ),
                    const SizedBox(
                      height: 15,
                    ),

                    /// pan
                    /// aadhar
                    /// profile photo
                    /// address

                    FutureBuilder(
                        future: FirestoreServices().getAgencyList(),
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
                                debugPrint('$dropDown\n');
                              });
                        }),

                    const SizedBox(
                      height: 20,
                    ),

                    SubmitButton(
                      text: 'Submit',
                      onPress: () {},
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

// #f0f5ff
