import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_models/saved_assignment_model.dart';
import '../app_providers/saved_assignment_provider.dart';
import '../app_utils/app_functions.dart';
import 'detail_text.dart';

class SavedAssignmentCard extends StatelessWidget {
  final Offset distance = const Offset(3.5, 3.5);
  final double blur = 5.0;

  final SavedAssignment assignment;
  final Function() navigate;
  Function()? onDoubleTap;
  SavedAssignmentCard({
    Key? key,
    required this.navigate,
    required this.assignment,
    this.onDoubleTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigate,
      onDoubleTap: onDoubleTap,
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
        margin: const EdgeInsets.only(top: 3, bottom: 3, left: 15, right: 6),
        padding: const EdgeInsets.all(15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DetailTextStylesWidget(
                    icon: Icon(
                      Icons.numbers,
                      color: Colors.orange.shade300,
                      size: 18,
                    ),
                    heading: 'Id',
                    value: Text(
                      assignment.caseId,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  DetailTextStylesWidget(
                    icon: Icon(
                      Icons.person,
                      color: Colors.blue.shade300,
                    ),
                    heading: 'Name',
                    value: Text(
                      assignment.applicant_name,
                      style: const TextStyle(
                        fontSize: 15,
                      ),
                    ),
                  ),
                  DetailTextStylesWidget(
                    icon: Icon(
                      Icons.phone,
                      color: Colors.green.shade300,
                    ),
                    heading: 'phone',
                    value: Text(
                      assignment.applicant_phone,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  DetailTextStylesWidget(
                      icon: Icon(
                        Icons.list_alt,
                        color: Colors.grey.shade500,
                        size: 20,
                      ),
                      heading: 'type',
                      value: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                assignment.type,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                              // const SizedBox(width: 30),
                            ],
                          ),

                          // const SizedBox(width: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: Colors.grey.shade500,
                                size: 20,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                assignment.assignedDate,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          )
                        ],
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 9,
                    backgroundColor: getStatusColour(assignment.status),
                  ),
                  // PopupMenuButton(
                  //   itemBuilder: (_) => [
                  //     PopupMenuItem(
                  //       value: 0,
                  //       onTap: () async {
                  //         /// DeletingSavedAssignments
                  //       },
                  //       child: const Text(
                  //         'Delete Task',
                  //         style: TextStyle(
                  //           fontSize: 18,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //         textAlign: TextAlign.center,
                  //       ),
                  //     ),
                  //   ],
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(15),
                  //   ),
                  //   // padding: const EdgeInsets.all(5),
                  //   color: Colors.red.shade100,
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
