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
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Text('Saved Pages\n'),
      ),
    );
  }
}
