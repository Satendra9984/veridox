// import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_screens/assignment_detail_page.dart';
import 'package:veridox/app_models/assignment_model.dart';

import '../app_utils/constants.dart';
import '../app_providers/assignment_provider.dart';

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
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/doc_image.png',
                    height: 80,
                    width: 80,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailTextStylesWidget(
                          heading: 'CaseId      ',
                          value: assignment.caseId.toString()),
                      DetailTextStylesWidget(
                          heading: 'Description',
                          value: assignment.description.toString()),
                      DetailTextStylesWidget(
                          heading: 'Address    ',
                          value: assignment.address.toString()),
                      DetailTextStylesWidget(
                          heading: 'Type          ',
                          value: assignment.type.toString()),
                      DetailTextStylesWidget(
                          heading: 'CreatedAt',
                          value: assignment.assignedDate.toString()),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //
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
      ),
    );
  }
}

class DetailTextStylesWidget extends StatelessWidget {
  final String heading, value;
  const DetailTextStylesWidget({
    Key? key,
    required this.value,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
