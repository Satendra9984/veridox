import 'package:flutter/cupertino.dart';

class FormPage extends StatefulWidget {
  final String caseId;

  final int pageNo;

  const FormPage({Key? key, required this.caseId, required this.pageNo}) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Form extends StatefulWidget {
  const Form({Key? key}) : super(key: key);

  @override
  State<Form> createState() => _FormState();
}

class _FormState extends State<Form> {
  late List<Widget> pages = [
    FormPage(caseId: 'caseId', pageNo: 1),
    FormPage(caseId: 'caseId', pageNo: 2),
  ];
  @override
  Widget build(BuildContext context) {
    return PageView(
      children: pages,
    );
  }
}

