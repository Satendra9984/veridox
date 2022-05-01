import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Form extends StatefulWidget {
  final String caseId;

  final int pageNo;

  const Form({Key? key, required this.caseId, required this.pageNo})
      : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<Form> {
  List<Widget> _getScreens() {}

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
        children: [],
      ),
    );
  }
}

class FormPage extends StatefulWidget {
  final int num;
  const FormPage({Key? key, required this.num}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormPage> {
  // late List<Widget> pages = [
  //   FormPage(caseId: 'caseId', pageNo: 1),
  //   FormPage(caseId: 'caseId', pageNo: 2),
  // ];
  @override
  Widget build(BuildContext context) {
    return Text('page ${widget.num}');
  }
}
