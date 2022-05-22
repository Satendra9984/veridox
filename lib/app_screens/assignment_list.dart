import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_providers/saved_assignment_provider.dart';
import 'package:veridox/app_widgets/assignment_card.dart';
import 'package:veridox/app_models/assignment_model.dart';
import 'package:veridox/app_providers/assignment_provider.dart';
import 'package:veridox/app_utils/constants.dart';

import 'assignment_detail_page.dart';

class AssignmentList extends StatefulWidget {
  final ScrollController controller;
  const AssignmentList({Key? key, required this.controller}) : super(key: key);
  static String assignmentListPage = 'assignmentListPage';

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
    // final assignmentsProv =
    //     Provider.of<AssignmentProvider>(context, listen: false);
    // final List<Assignment> assignmentList = assignmentsProv.tasks;
    // print(assignmentList[0].type);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        backgroundColor: Colors.red[500]?.withOpacity(1),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedOption) {
              // will do sorting
              // print(selectedOption);
              setState(() {
                if (selectedOption == FilterOptions.oldest) {
                  oldestFilter = true;
                } else {
                  oldestFilter = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Old to New'),
                value: FilterOptions.oldest,
              ),
              const PopupMenuItem(
                child: Text('Activity wise'),
                value: FilterOptions.oldest,
              ),
              const PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.all,
              ),
            ],
          ),
        ],
      ),
      // for the refreshing the assignments list
      body: RefreshIndicator(
        onRefresh: () => _refreshAssignments(context),
        child: Consumer<List<Assignment>>(
          builder: (context, list, widget) {
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                // print(list[index]);
                return AssignmentCard(
                  navigate: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) =>
                            AssignmentDetailPage(caseId: list[index].caseId),
                      ),
                    );
                  },
                  assignment: list[index],
                  popUpMenu: PopupMenuButton(
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        child: const Text('Save Task'),
                        value: 0,
                        onTap: () {
                          // TODO: SAVING ASSIGNMENTS
                          Provider.of<SavedAssignmentProvider>(context,
                                  listen: false)
                              .addSaveAssignments(
                            list[index].caseId,
                          );
                        },
                      ),
                      const PopupMenuItem(
                        child: Text('item3'),
                        value: 2,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
