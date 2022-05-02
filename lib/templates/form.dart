import 'package:flutter/material.dart';
import 'package:veridox/templates/form_page.dart';

import '../app_models/saved_assignment_model.dart';

class Form extends StatefulWidget {
  final SavedAssignment saveAssignment;

  const Form({Key? key, required this.saveAssignment}) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  // for start making forms
  late final Map<String, dynamic> _formData;

  @override
  void initState() {
    super.initState();
    _formData = _formData = widget.saveAssignment.formData;
  }

  List<Widget> _getScreens() {
    List<Widget> screen = [];
    final List<Map<String, dynamic>> jsonPageData =
        _formData['pages'] as List<Map<String, dynamic>>;

    for (int i = 0; i < jsonPageData.length; i++) {
      screen.add(
        FormPage(
          formIdInSp: _formData['id'].toString(),
          pageData: jsonPageData[i],
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
        onPageChanged: (currentScreen) {
          setState(
            () {
              currentItemSelected = currentScreen;
            },
          );
        },
        children: _getScreens(),
      ),
    );
  }
}
