import 'package:flutter/material.dart';
import 'package:veridox/app_models/assignment_model.dart';

import '../app_utils/app_functions.dart';
import 'detail_text.dart';

class AssignmentCard extends StatelessWidget {
  final Offset distance = const Offset(3.5, 3.5);
  final double blur = 5.0;

  final Widget popUpMenu;
  final Assignment assignment;
  final Function() navigate;
  const AssignmentCard(
      {Key? key,
      required this.navigate,
      required this.popUpMenu,
      required this.assignment})
      : super(key: key);

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
                      heading: 'CreatedAt',
                      value: assignment.assignedDate.toString()),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  popUpMenu,
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
