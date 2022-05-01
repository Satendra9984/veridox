import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/templates/form_page.dart';

import '../app_models/saved_assignment_model.dart';

class Form extends StatefulWidget {
  final SavedAssignment saveAssignment;

  final int pageNo;

  const Form({Key? key, required this.saveAssignment, required this.pageNo})
      : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  List<Widget> _getScreens() {
    List<Widget> screen = [];
    final List<Map<String, dynamic>> jsonPageData =
        widget.saveAssignment.formData['pages'] as List<Map<String, dynamic>>;

    int num = 0;
    for (int i = 0; i < jsonPageData.length; i++) {
      screen.add(
        FormPage(
          num: i,
        ),
      );
    }
    return screen;
  }

  int currentItemSelected = 0;
  final PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form page'),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (num) {
          setState(() {
            // _pageController.jumpToPage(num);
            currentItemSelected = num;
          });
        },
        children: _getScreens(),
      ),
    );
  }
}
