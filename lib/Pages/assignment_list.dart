import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/Elements/assignment_card.dart';
import 'package:veridox/models/assignment_model.dart';
import 'package:veridox/models/assignment_provider.dart';

class AssignmentList extends StatelessWidget {
  final bool isOldFilterSelected;
  AssignmentList({Key? key, required this.isOldFilterSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assignmentsProv = Provider.of<AssignmentProvider>(context);
    final List<AssignmentModel> assignmentList = isOldFilterSelected
        ? assignmentsProv.oldFirstTasks
        : assignmentsProv.tasks;

    return ListView.builder(
      itemCount: assignmentList.length,
      padding: const EdgeInsets.all(10),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: assignmentList[index],
        child: AssignmentCard(),
      ),
    );
  }
}
