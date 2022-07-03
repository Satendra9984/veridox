import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:veridox/app_models/assignment_model.dart';
import 'package:veridox/app_widgets/modal_bottom_sheet.dart';
import '../app_utils/app_functions.dart';
import 'detail_text.dart';

class AssignmentCard extends StatelessWidget {
  final Offset distance = const Offset(5.5, 6.5);
  final double blur = 8.0;

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
            width: 1.5,
          ),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              blurRadius: blur,
              offset: -distance,
              color: Colors.white30,
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
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      FontAwesomeIcons.userTie,
                      color: Colors.black,
                      size: 16,
                    ),
                    heading: 'Name',
                    value: Text(
                      assignment.name,
                      style: const TextStyle(
                        fontSize: 18,
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
                      style:
                          TextStyle(fontSize: 17, color: Colors.grey.shade600),
                    ),
                  ),
                  DetailTextStylesWidget(
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.orangeAccent,
                      size: 18,
                    ),
                    heading: 'Id',
                    value: Text(
                      assignment.caseId,
                      style: const TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  DetailTextStylesWidget(
                    icon: Icon(
                      FontAwesomeIcons.fileLines,
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
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  DetailTextStylesWidget(
                    heading: 'Address',
                    value: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Colors.lightBlue,
                          size: 18,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          assignment.address,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (ctx) => const CustomBottomSheet(),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                  );
                },
                icon: const Icon(Icons.more_vert),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
