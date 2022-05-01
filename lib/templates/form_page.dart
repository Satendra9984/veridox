import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  final int num;
  final Map<String, dynamic> pageData;
  const FormPage({Key? key, required this.num, required this.pageData})
      : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Text('page ${widget.num}');
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
