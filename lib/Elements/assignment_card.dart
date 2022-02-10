import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/models/assignment_model.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Consumer<AssignmentModel>(
          builder: (BuildContext context, assignment, Widget? child) => Column(
            children: [
              Text(assignment.caseId),
              Text(assignment.description),
              Text(assignment.address),
              Text(assignment.type),
            ],
          ),
        ),
      ),
    );
  }
}
