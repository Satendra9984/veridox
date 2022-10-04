import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_widgets/assignment_card.dart';
import 'package:veridox/app_models/assignment_model.dart';
import 'package:veridox/app_providers/assignment_provider.dart';
import '../../app_widgets/custom_app_bar.dart';
import 'assignment_detail_page.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList({Key? key}) : super(key: key);
  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  bool oldestFilter = false;

  Future<void> _refreshAssignments(BuildContext context) async {
    await Provider.of<AssignmentProvider>(context, listen: false)
        .fetchAndLoadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
        label: 'Assignments',
      ),
      // for the refreshing the assignments list
      body: RefreshIndicator(
        onRefresh: () => _refreshAssignments(context),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0XFFf0f5ff), Colors.white],
            ),
          ),
          child: Consumer<List<Assignment>>(
            builder: (context, list, widget) {
              if (list.length == 0) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: Text(
                    'You do not have any assignments yet,'
                    '\ncontact your agency for more details',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                );
              }

              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (ctxt, index) {
                  // print(list[index]);
                  return AssignmentCard(
                    navigate: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AssignmentDetailPage(caseId: list[index].caseId),
                        ),
                      );
                    },
                    assignment: list[index],
                    popUpMenu: PopupMenuButton(
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: 0,
                          onTap: () async {
                            // TODO: SAVING ASSIGNMENTS
                            // await Provider.of<SavedAssignmentProvider>(context,
                            //         listen: false)
                            //     .addSavedAssignment(
                            //   list[index].caseId,
                            // );
                          },
                          child: const Text('Reject Task'),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
