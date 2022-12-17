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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 9,
                        child: DetailTextStylesWidget(
                          icon: Icon(
                            Icons.numbers,
                            color: Colors.orange.shade300,
                            size: 18,
                          ),
                          heading: 'Id',
                          value: Text(
                            assignment.caseId,
                            style: _assignmentCardTextStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: CircleAvatar(
                          backgroundColor: getStatusColour(assignment.status),
                          radius: 9.0,
                        ),
                      ),
                    ],
                  ),
                ),
                DetailTextStylesWidget(
                  icon: Icon(
                    Icons.person,
                    color: Colors.grey.shade600,
                    // size: 16,
                  ),
                  heading: 'Name',
                  value: Text(
                    assignment.name,
                    style: _assignmentCardTextStyle,
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
                    style: _assignmentCardTextStyle,
                  ),
                ),
                // const SizedBox(height: 5),
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: DetailTextStylesWidget(
                          icon: const Icon(
                            Icons.document_scanner_rounded,
                            // color: Colors.greenAccent,
                          ),
                          heading: 'type',
                          value: Text(
                            assignment.type,
                            style: _assignmentCardTextStyle,
                          ),
                        ),
                      ),
                      Expanded(
                        child: DetailTextStylesWidget(
                          icon: Icon(
                            Icons.date_range_outlined,
                            color: Colors.blueAccent.shade100,
                          ),
                          heading: 'phone',
                          value: Text(
                            assignment.assignedDate,
                            style: _assignmentCardTextStyle,
                          ),
                        ),
                      ),
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

TextStyle _assignmentCardTextStyle = const TextStyle(
  fontSize: 15,
  fontStyle: FontStyle.normal,
  fontFamily: 'Roboto',
  fontWeight: FontWeight.w500,
);
