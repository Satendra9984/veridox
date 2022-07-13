import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:veridox/app_models/assignment_model.dart';
import 'package:veridox/app_utils/app_constants.dart';
import 'package:veridox/app_widgets/modal_bottom_sheet.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
      child: GestureDetector(
        onTap: navigate,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kBRad)
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(17.0),
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
                            fontSize: 16,
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
                              TextStyle(fontSize: 13, color: Colors.grey.shade600),
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
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
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
                            Row(
                              children: [
                                Text(
                                  assignment.type,
                                  style: TextStyle(
                                    fontSize: 13,
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
                                fontSize: 13,
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
        ),
      ),
    );
  }
}
