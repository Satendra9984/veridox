import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/app_api_collection.dart';
import 'package:veridox/app_services/database/firestore_services.dart';

import 'initial_form_page.dart';

class FormHomePage extends StatefulWidget {
  final String caseId;
  const FormHomePage({
    required this.caseId,
    Key? key,
  }) : super(key: key);

  @override
  State<FormHomePage> createState() => _FormHomePageState();
}

class _FormHomePageState extends State<FormHomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void deactivate() {
    _pageController.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: FirestoreServices.getFormDataById(widget.caseId),
        builder: (context, AsyncSnapshot<Map<String, dynamic>?> form) {
          var snapshot = form.data;
          // print(snapshot);
          if (form.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (form.hasData && snapshot != null) {
            final data = Map<String, dynamic>.from(snapshot);

            // debugPrint('form data --> ${data.toString()}');

            return InitialFormPageView(caseId: widget.caseId, pagesData: data);
          } else if (snapshot == null) {
            return const Center(
              child: Text('Form will be displayed here'),
            );
          } else {
            return const Center(
              child: Text('Data not loaded'),
            );
          }
        },
      ),
    );
  }
}
