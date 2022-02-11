// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veridox/models/assignment_model.dart';

import 'assignment_list.dart';

enum FilterOptions {
  Oldest,
  All,
}

class AssignmentsHomePage extends StatefulWidget {
  static String assignmentsHomePage = 'assignmentHomePage';
  AssignmentsHomePage({Key? key}) : super(key: key);

  @override
  State<AssignmentsHomePage> createState() => _AssignmentsHomePageState();
}

class _AssignmentsHomePageState extends State<AssignmentsHomePage> {
  bool oldestFilter = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedOption) {
              // will do sorting
              // print(selectedOption);
              setState(() {
                if (selectedOption == FilterOptions.Oldest) {
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
                value: FilterOptions.Oldest,
              ),
              const PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          // PopupMenuButton(itemBuilder: (_) => []),
        ],
      ),
      body: AssignmentList(isOldFilterSelected: oldestFilter),
      // bottom navigation bar
    );
  }
}
