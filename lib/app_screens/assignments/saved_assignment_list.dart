import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veridox/app_models/sorting_enums.dart';
import 'package:veridox/app_screens/assignments/assignment_detail_page.dart';
import 'package:veridox/app_utils/app_functions.dart';
import 'package:veridox/form_screens/home_page.dart';
import '../../app_models/saved_assignment_model.dart';
import '../../app_widgets/saved_assignment_card.dart';

class SavedAssignmentList extends StatefulWidget {
  final List<SavedAssignment> savedAssList;
  final Function() renewListAfter;
  const SavedAssignmentList({
    Key? key,
    required this.savedAssList,
    required this.renewListAfter,
  }) : super(key: key);
  @override
  State<SavedAssignmentList> createState() => _SavedAssignmentListState();
}

class _SavedAssignmentListState extends State<SavedAssignmentList> {
  SavedAssignmentFilters _currentFilter = SavedAssignmentFilters.InProgress;
  List<SavedAssignment> _filteredList = [];

  @override
  void initState() {
    /// initializing list
    _filteredList = widget.savedAssList;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
        return secondDate.compareTo(firstDate);
      });
      _filteredList = _filtList;
    } else if (_currentFilter == SavedAssignmentFilters.OldestFirst) {
      _filtList.sort((first, second) {
        DateTime firstDate = DateFormat('dd/MM/yyyy').parse(first.assignedDate);
        DateTime secondDate =
            DateFormat('dd/MM/yyyy').parse(second.assignedDate);
        return firstDate.compareTo(secondDate);
      });
      _filteredList = _filtList;
    } else {
      _filteredList = _filtList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 15, left: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 8,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Saved Assignments',
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 45),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PopupMenuButton<SavedAssignmentFilters>(
                          initialValue: _currentFilter,
                          onSelected: (filter) {
                            setState(() {
                              _currentFilter = filter;
                              _setFilteredList();
                            });
                          },
                          itemBuilder: (context) {
                            return <PopupMenuEntry<SavedAssignmentFilters>>[
                              PopupMenuItem(
                                  child: Text(
                                    'In-Progress First',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  value: SavedAssignmentFilters.InProgress),
                              PopupMenuItem(
                                child: Text(
                                  'ReAssigned First',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: SavedAssignmentFilters.ReAssigned,
                              ),
                              PopupMenuItem(
                                child: Text(
                                  'Newest First',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: SavedAssignmentFilters.NewestFirst,
                              ),
                              PopupMenuItem(
                                child: Text(
                                  'Oldest First',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                value: SavedAssignmentFilters.OldestFirst,
                              ),
                            ];
                          },
                          icon: Icon(Icons.more_horiz),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 15,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 10),
            if (_filteredList.length == 0)
              Container(
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
              ),
            if (_filteredList.length > 0)
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _filteredList.length,
                itemBuilder: (context, index) {
                  return SavedAssignmentCard(
                    onDoubleTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AssignmentDetailPage(
                            caseId: _filteredList[index].caseId,
                          ),
                        ),
                      );
                    },
                    navigate: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormHomePage(
                            caseId: _filteredList[index].caseId,
                          ),
                        ),
                      ).then((submitted) {
                        if (submitted != null && submitted == true) {}
                        widget.renewListAfter();
                      });
                    },
                    assignment: _filteredList[index],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
