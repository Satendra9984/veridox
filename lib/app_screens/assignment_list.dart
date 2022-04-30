import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    final assignmentsProv = Provider.of<AssignmentProvider>(context);
    final List<Assignment> assignmentList = assignmentsProv.tasks;

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
      body: RefreshIndicator(
        onRefresh: () => _refreshAssignments(context),
        child: assignmentList.isEmpty
            ? const Center(
                child: Text('loading'),
              )
            : Consumer<List<Assignment>>(
                builder: (context, list, widget) {
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return AssignmentCard(
                        navigate: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => AssignmentDetailPage(
                                  caseId: list[index].caseId),
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

/*
* RefreshIndicator(
        onRefresh: () => _refreshAssignments(context),
        child: assignmentList.isEmpty
            ? const Center(
                child: Text('loading'),
              )
            : StreamBuilder<List<Assignment>>(
                stream: assignmentsProv.getAssignments(),
                builder: (context, snapshot) {
                  // print(snapshot.data);
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return AssignmentCard(
                        assignment: snapshot.data![index],
                        popUpMenu: PopupMenuButton(
                          itemBuilder: (_) => [
                            PopupMenuItem(
                              child: Text('Save Task'),
                              value: 0,
                              onTap: () {
                                assignmentsProv.addSaveAssignment(
                                    snapshot.data![index].caseId);
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
*
* */
