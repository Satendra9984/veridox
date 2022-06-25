import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_models/saved_assignment_model.dart';
import '../app_providers/saved_assignment_provider.dart';
import '../app_utils/app_functions.dart';
import 'detail_text.dart';

class SavedAssignmentCard extends StatelessWidget {
  final Offset distance = const Offset(3.5, 3.5);
  final double blur = 5.0;

  // final Widget popUpMenu;
  final SavedAssignment assignment;
  final Function() navigate;
  const SavedAssignmentCard({
    Key? key,
    required this.navigate,
    // required this.popUpMenu,
    required this.assignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigate,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade300,
            width: 0.7,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: blur,
              offset: -distance,
              color: Colors.white10,
              // inset: isPressed,
            ),
            BoxShadow(
              blurRadius: blur,
              offset: distance,
              color: const Color(0xFFA7A9AF),
              // inset: isPressed,
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DetailTextStylesWidget(
                      heading: 'Name', value: assignment.name.toString()),
                  DetailTextStylesWidget(
                      heading: 'CaseId      ',
                      value: assignment.caseId.toString()),
                  DetailTextStylesWidget(
                      heading: 'phone', value: assignment.phone.toString()),
                  DetailTextStylesWidget(
                      heading: 'Address    ',
                      value: assignment.address.toString()),
                  DetailTextStylesWidget(
                      heading: 'Type', value: assignment.type.toString()),
                  DetailTextStylesWidget(
                      heading: 'Assigned At',
                      value: assignment.assignedDate.toString()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PopupMenuButton(
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 0,
                        onTap: () {
                          // TODO: DeletingSavedAssignments
                          Provider.of<SavedAssignmentProvider>(context,
                                  listen: false)
                              .removeFromSaveAssignments(assignment.caseId);
                        },
                        child: const Text('Delete Task'),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 8,
                    backgroundColor: getStatusColour(assignment.status),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
