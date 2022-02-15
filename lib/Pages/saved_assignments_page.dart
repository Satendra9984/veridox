import 'package:flutter/material.dart';

class SavedAssignmentsPage extends StatefulWidget {
  final ScrollController controller;
  const SavedAssignmentsPage({Key? key, required this.controller})
      : super(key: key);

  @override
  State<SavedAssignmentsPage> createState() => _SavedAssignmentsPageState();
}

class _SavedAssignmentsPageState extends State<SavedAssignmentsPage> {
  @override
  void initState() {
    super.initState();
    print('save init');
  }

  @override
  void dispose() {
    super.dispose();
    print('save dis');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Text('Saved Pages\n'),
        ),
      ),
    );
  }
}
