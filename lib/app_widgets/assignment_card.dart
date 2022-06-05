// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_screens/asignments/assignment_detail_page.dart';
import 'package:veridox/app_models/assignment_model.dart';

import '../app_utils/app_constants.dart';
import '../app_providers/assignment_provider.dart';
import 'detail_text.dart';

class AssignmentCard extends StatelessWidget {
  final Widget popUpMenu;
  final Assignment assignment;
  final Function() navigate;
  const AssignmentCard(
      {Key? key,
      required this.navigate,
      required this.popUpMenu,
      required this.assignment})
      : super(key: key);

  Color getStatusColour(String status) {
    if (status == 'completed') {
      return CupertinoColors.activeGreen;
    } else if (status == 'working') {
      return Colors.deepOrange;
    } else if (status == 'pending') {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          // () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (ctx) => const AssignmentDetailPage(),
          //     ),
          //   );
          // }
          navigate,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: const Offset(0.0, 2.5), //(x,y)
              blurRadius: 3.5,
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
