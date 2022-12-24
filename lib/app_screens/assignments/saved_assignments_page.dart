import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veridox/app_models/saved_assignment_model.dart';
import 'package:veridox/app_screens/assignments/saved_assignment_list.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import '../../app_models/sorting_enums.dart';

class SavedAssignmentsPage extends StatefulWidget {
  const SavedAssignmentsPage({Key? key}) : super(key: key);
  @override
  State<SavedAssignmentsPage> createState() => _SavedAssignmentsPageState();
}

class _SavedAssignmentsPageState extends State<SavedAssignmentsPage> {
  // late SavedAssignmentProvider _provider;
  SavedAssignmentFilters _currentFilter = SavedAssignmentFilters.InProgress;
  List<SavedAssignment> _filteredList = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<List<SavedAssignment>> _setInitialSavedAssignmentsList() async {
    List<SavedAssignment> saveList = [];
    await FirestoreServices.getSavedAssignments().then((list) {
      if (list.isNotEmpty) {
        saveList = list.map((assignment) {
          return SavedAssignment.fromJson(assignment!, assignment['caseId']);
        }).toList();
        // return saveList;
      }
      // return [];
    });
    return saveList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _setInitialSavedAssignmentsList(),
        builder: (context, AsyncSnapshot<List<SavedAssignment>> form) {
          if (form.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (form.hasError) {
            return Center(
              child: Text('Something Went Wrong ${form.error}'),
            );
          } else {
            return SavedAssignmentList(
              savedAssList: form.data!,
              renewListAfter: () {
                setState(() {});
              },
            );
          }
        },
      ),
    );
  }

  void _setFilteredList() {
    // debugPrint('current filter -> $_currentFilter\n');
    List<SavedAssignment> _filtList = _filteredList;
    if (_currentFilter == SavedAssignmentFilters.InProgress) {
      _filteredList.sort((sa1, sa2) {
        if (sa1.status == 'in_progress') {
          return 1;
        }
        return 0;
      });
      _filteredList = _filtList;
    } else if (_currentFilter == SavedAssignmentFilters.ReAssigned) {
      _filteredList.sort((sa1, sa2) {
        if (sa1.status == 'in_progress') {
          return 0;
        }
        return 1;
      });
      _filteredList = _filtList;
    } else if (_currentFilter == SavedAssignmentFilters.NewestFirst) {
      _filtList.sort((first, second) {
        DateTime firstDate = DateFormat('dd/MM/yyyy').parse(first.assignedDate);
        DateTime secondDate =
            DateFormat('dd/MM/yyyy').parse(second.assignedDate);
        return firstDate.compareTo(secondDate);
      });
      _filteredList = _filtList;
    } else if (_currentFilter == SavedAssignmentFilters.OldestFirst) {
      _filtList.sort((first, second) {
        DateTime firstDate = DateFormat('dd/MM/yyyy').parse(first.assignedDate);
        DateTime secondDate =
            DateFormat('dd/MM/yyyy').parse(second.assignedDate);
        return secondDate.compareTo(firstDate);
      });
      _filteredList = _filtList;
    } else {
      _filteredList = _filtList;
    }
  }
}
