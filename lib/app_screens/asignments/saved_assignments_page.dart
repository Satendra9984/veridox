import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_models/assignment_model.dart';
import 'package:veridox/app_widgets/assignment_card.dart';
import '../../app_providers/saved_assignment_provider.dart';
import '../../templates/page_0.dart';

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
    final assignmentProvider = Provider.of<SavedAssignmentProvider>(context);
    final savedAssignmentList = assignmentProvider.savedAssignments;

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
          itemBuilder: (ctx, index) => AssignmentCard(
            navigate: () {
              // TODO: PASS THE JSON DATA TO THE Page0()
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => const Page0(),
                ),
              );
            },
            assignment: Assignment(
              address: savedAssignmentList[index].address,
              caseId: savedAssignmentList[index].caseId,
              // description: savedAssignmentList[index].description,
              type: savedAssignmentList[index].type,
              status: savedAssignmentList[index].status,
              assignedDate: savedAssignmentList[index].assignedDate.toString(),
              phone: '', name: '',
            ),
            popUpMenu: PopupMenuButton(
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: const Text('Remove'),
                  value: 1,
                  onTap: () {
                    assignmentProvider.removeFromSaveAssignments(
                        savedAssignmentList[index].caseId);
                  },
                ),
                const PopupMenuItem(
                  child: Text('item3'),
                  value: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
