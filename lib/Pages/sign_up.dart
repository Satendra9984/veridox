import 'package:flutter/material.dart';
import 'package:veridox/Elements/submit_button.dart';
import 'package:veridox/Elements/text_input.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
                margin: const EdgeInsets.all(30.0),
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 0,
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 19,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(9.0),
                  gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0XFFC925E3),
                        Color(0XFF256CBF),
                      ]),
                ),
                child: Column(
                  children: [
                    const CustomTextInput(text: "Phone Number", keyboardType: TextInputType.number, password: false),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomTextInput(text: "Email", keyboardType: TextInputType.emailAddress, password: false),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomTextInput(text: "Create Password", keyboardType: TextInputType.text, password: true),
                    const SizedBox(
                      height: 30,
                    ),
                    const CustomTextInput(text: "Confirm Password", keyboardType: TextInputType.text, password: true),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 7),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              primary: Colors.transparent,
                              onPrimary: Colors.white70,
                              shadowColor: Colors.transparent,
                            ),
                            child: const Text("Already have an account", style: TextStyle(color: Colors.white),),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20,),
                    const SubmitButton(text: 'Sign Up'),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }
}
