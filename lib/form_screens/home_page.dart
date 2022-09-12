import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/app_api_collection.dart';

import '../form_widgets/initial_form_page.dart';

class FormHomePage extends StatefulWidget {
  final String formId;
  const FormHomePage({
    required this.formId,
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //
        // body:
        FutureBuilder(
      future: AppApiCollection.getForm(widget.formId),
      builder: (context, AsyncSnapshot<Map<String, dynamic>?> form) {
        var snapshot = form.data;
        print(snapshot);
        if (form.connectionState == ConnectionState.waiting) {
          // debugPrint('fine 63');
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (form.hasData && snapshot != null) {
          // debugPrint('fine 67');
          final data = Map<String, dynamic>.from(snapshot);

          debugPrint('new data --> ${data.toString()}');
          // debugPrint('data type for page --> ${data.runtimeType}');

          return InitialFormPageView(pagesData: data);
        } else if (snapshot == null) {
          // debugPrint('fine 75');
          return const Center(
            child: Text('Form will be displayed here'),
          );
        } else {
          // debugPrint('fine 80');
          return const Center(
            child: Text('Data not loaded'),
          );
        }
      },
      // ),
    );
  }
}
