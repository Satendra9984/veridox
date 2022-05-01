import 'package:flutter/material.dart';

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
