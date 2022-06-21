import 'package:flutter/material.dart';
import 'package:veridox/templates/form_page.dart';

import '../app_models/saved_assignment_model.dart';

class FormTemplate extends StatefulWidget {
  final SavedAssignment saveAssignment;

  const FormTemplate({Key? key, required this.saveAssignment})
      : super(key: key);

  @override
  State<FormTemplate> createState() => _FormTemplateState();
}

class _FormTemplateState extends State<FormTemplate> {
  /// for start making forms
  late final Map<String, dynamic> _formData;

  @override
  void initState() {
    super.initState();
    _formData = widget.saveAssignment.formData!;
  }

  List<Widget> _getScreens() {
    List<Widget> screen = [];
    final List<Map<String, dynamic>> jsonPageData =
        List<Map<String, dynamic>>.from(_formData["pages"]);

    for (int i = 1; i < jsonPageData.length; i++) {
      screen.add(
        FormPage(
          formIdInSp: widget.saveAssignment.caseId,
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
