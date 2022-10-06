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
                mainAxisSize: MainAxisSize.min,
                children: [
                  DetailTextStylesWidget(
                      icon: const Icon(
                        Icons.info,
                        color: Colors.orange,
                        size: 18,
                      ),
                      heading: 'Id',
                      value: Text(
                        assignment.caseId,
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                        ),
                      )),
                  DetailTextStylesWidget(
                      icon: const Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      heading: 'Name',
                      value: Text(
                        assignment.applicant_name,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )),
                  DetailTextStylesWidget(
                      icon: const Icon(
                        Icons.phone,
                        color: Colors.greenAccent,
                      ),
                      heading: 'phone',
                      value: Text(
                        assignment.applicant_phone,
                        style: const TextStyle(fontSize: 17),
                      )),
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
                  // DetailTextStylesWidget(
                  //   heading: 'Address',
                  //   value: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       const Icon(
                  //         Icons.location_on,
                  //         color: Colors.lightBlue,
                  //         size: 18,
                  //       ),
                  //       const SizedBox(width: 3),
                  //       Text(
                  //         assignment.applicant_address,
                  //         style: const TextStyle(
                  //           fontSize: 15,
                  //           color: Colors.lightBlue,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
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
                          debugPrint(
                              'deleting caseId --> ${assignment.caseId}\n\n');
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
