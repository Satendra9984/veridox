import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/Elements/assignment_card.dart';
import 'package:veridox/Pages/assignments_home_page.dart';
import 'package:veridox/models/assignment_provider.dart';

import '../models/saved_assignment_provider.dart';

class SavedAssignmentsPage extends StatefulWidget {
  final ScrollController controller;
  const SavedAssignmentsPage({Key? key, required this.controller})
      : super(key: key);
  // SavedAssignmentsPage({key? key, this.controller}): super(key: key);
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
    final assignmentProvider = Provider.of<AssignmentProvider>(context);
    final savedAssignmentList = assignmentProvider.savedAssignment;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Saved Assignment',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          controller: widget.controller,
          itemCount: savedAssignmentList.length,
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: savedAssignmentList[index],
            child: AssignmentCard(),
          ),
        ),
      ),
    );
  }
}
