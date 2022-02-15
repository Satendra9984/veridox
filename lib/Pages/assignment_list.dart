import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/Elements/assignment_card.dart';
import 'package:veridox/models/assignment_model.dart';
import 'package:veridox/models/assignment_provider.dart';
import 'package:veridox/constants.dart';

class AssignmentList extends StatefulWidget {
  static String assignmentListPage = 'assignmentListPage';
  // final bool isOldFilterSelected;
  ScrollController controller;
  AssignmentList({Key? key, required this.controller}) : super(key: key);

  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  bool oldestFilter = false;

  @override
  void initState() {
    super.initState();
    print('ass list init');
  }

  @override
  void dispose() {
    super.dispose();
    print('ass list disposed');
  }

  @override
  Widget build(BuildContext context) {
    final assignmentsProv = Provider.of<AssignmentProvider>(context);
    final List<AssignmentModel> assignmentList = assignmentsProv.tasks;
    //     : assignmentsProv.tasks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        backgroundColor: Colors.green,
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
                child: Text('Activity wise'),
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
      body: ListView.builder(
        controller: widget.controller,
        itemCount: assignmentList.length,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) => ChangeNotifierProvider.value(
          value: assignmentList[index],
          child: AssignmentCard(),
        ),
      ),
    );
  }
}
