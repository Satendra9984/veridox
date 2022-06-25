import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_providers/auth_provider.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import 'package:veridox/app_widgets/submit_button.dart';
import 'package:veridox/app_widgets/text_input.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  late String id;
  final SPServices prefs = SPServices();

  late CustomAuthProvider _provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _provider = Provider.of<CustomAuthProvider>(context);
    super.didChangeDependencies();
  }

  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0XFFf0f5ff),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.all(15),
          child: _provider.isLoading ? SubmitButton(
            color: Colors.blueGrey,
            text: 'Sending',
              onPress: () {}, loading: const SizedBox(
              height: 17, width: 17,
                child: CircularProgressIndicator(color: Colors.white,)),
          ) : SubmitButton(
            text: 'Send OTP',
            onPress: () {
              _provider.setPhoneNumber(_phoneController.text);
              _provider.signInWithPhone(context);
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
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text(
                          'Verify Phone Number',
                          style: TextStyle(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF0e4a86)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'To use the application',
                          style: TextStyle(fontSize: 27),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      CustomTextInput(
                          controller: _phoneController,
                          text: "Phone Number",
                          keyboardType: TextInputType.number,
                          password: false),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
