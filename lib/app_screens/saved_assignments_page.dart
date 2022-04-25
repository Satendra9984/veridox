import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_widgets/assignment_card.dart';
import '../app_providers/saved_assignment_provider.dart';


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
          itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
            value: savedAssignmentList[index],
            child: AssignmentCard(
              popUpMenu: PopupMenuButton(
                itemBuilder: (_) => [
                  // PopupMenuItem(
                  //   child: Text('Save Task'),
                  //   value: 0,
                  //   onTap: () {
                  //     assignmentProvider.addSaveAssignment(savedAssignmentList[index].caseId);
                  //   },
                  // ),
                  PopupMenuItem(
                    child: Text('Remove'),
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
      ),
    );
  }
}
