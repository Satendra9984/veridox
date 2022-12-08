import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:veridox/app_models/assignment_model.dart';
import 'package:veridox/app_utils/app_constants.dart';
import 'package:veridox/app_utils/app_functions.dart';
import 'package:veridox/app_widgets/modal_bottom_sheet.dart';
import 'detail_text.dart';

class AssignmentCard extends StatelessWidget {
  final Offset distance = const Offset(5.5, 6.5);
  final double blur = 8.0;

  // final Widget popUpMenu;
  final Assignment assignment;
  final Function() navigate;

  const AssignmentCard(
      {Key? key,
      required this.navigate,
      // required this.popUpMenu,
      required this.assignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint('card assignment --> ${assignment.caseId}\n');
    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(kBRad + 5)),
        border: Border.all(
          color: Colors.grey.shade200,
          width: 1.8,
        ),
      ),
      child: GestureDetector(
        onTap: navigate,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBRad),
          ),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(17.0),
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
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      DetailTextStylesWidget(
                        icon: Icon(
                          Icons.person,
                          color: Colors.blue.shade300,
                          // size: 16,
                        ),
                        heading: 'Name',
                        value: Text(
                          assignment.name,
                          style: const TextStyle(
                            fontSize: 14,
                            // color: Colors.
                          ),
                        ),
                      ),
                      DetailTextStylesWidget(
                        icon: const Icon(
                          Icons.phone,
                          color: Colors.greenAccent,
                        ),
                        heading: 'phone',
                        value: Text(
                          assignment.phone,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      DetailTextStylesWidget(
                        icon: Icon(
                          FontAwesomeIcons.fileLines,
                          color: Colors.grey.shade500,
                          size: 18,
                        ),
                        heading: 'type',
                        value: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  const SizedBox(width: 3),
                                  Text(
                                    assignment.type,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    color: Colors.grey.shade500,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 3),
                                  Text(
                                    assignment.assignedDate,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundColor: getStatusColour(assignment.status),
                        radius: 9.0,
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //     showModalBottomSheet(
                      //       context: context,
                      //       builder: (ctx) => const CustomBottomSheet(),
                      //       shape: const RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.only(
                      //               topLeft: Radius.circular(20),
                      //               topRight: Radius.circular(20))),
                      //     );
                      //   },
                      //   icon: const Icon(Icons.more_vert),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
