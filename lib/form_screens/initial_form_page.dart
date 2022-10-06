import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_providers/form_provider.dart';
import 'package:veridox/form_screens/form_submit_screen.dart';
import 'form_page.dart';

class InitialFormPageView extends StatefulWidget {
  final Map<String, dynamic> pagesData;
  final String caseId;
  InitialFormPageView({
    Key? key,
    required this.pagesData,
    required this.caseId,
  }) : super(key: key);

  @override
  State<InitialFormPageView> createState() => _InitialFormPageViewState();
}

class _InitialFormPageViewState extends State<InitialFormPageView> {
  late final PageController _pageController;

  late FormProvider _formProvider = Provider.of(context);

  void initialize() async {
    _formProvider.setAssignmentId = widget.caseId;
    await _formProvider.initializeResponse();
  }

  @override
  void initState() {
    initialize();
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

  List<Widget> _getFormPages(Map<String, dynamic> form) {
    List<Widget> screen = [];

    List<dynamic>? pageData = widget.pagesData['data'];
    if (pageData == null) {
      return screen;
    }
    for (int i = 0; i < pageData.length; i++) {
      screen.add(
        FormPage(
          provider: _formProvider,
          singlePageData: pageData[i],
          currentPage: i,
          totalPages: pageData.length + 1,
          pageController: _pageController,
        ),
      );
    }
    screen.add(
      FormSubmitPage(
        provider: _formProvider,
        currentPage: pageData.length,
        pageController: _pageController,
        totalPages: pageData.length + 1,
      ),
    );
    return screen;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: _getFormPages(widget.pagesData),
      onPageChanged: (currentPage) {
        debugPrint('page changed --> $currentPage}');
      },
    );
  }
}
