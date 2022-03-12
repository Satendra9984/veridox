import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/Elements/assignment_card.dart';
import 'package:veridox/models/assignment_model.dart';
import 'package:veridox/models/assignment_provider.dart';
import 'package:veridox/constants.dart';

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
    final List<AssignmentModel> assignmentList = assignmentsProv.tasks;

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
          // PopupMenuButton(itemBuilder: (_) => []),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshAssignments(context),
        child: ListView.builder(
          controller: widget.controller,
          itemCount: assignmentList.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: assignmentList[index],
            child: const AssignmentCard(),
          ),
        ),
      ),
    );
  }
}
