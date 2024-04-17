import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_models/sorting_enums.dart';
import '../../app_models/saved_assignment_model.dart';
import '../../app_widgets/saved_assignment_card.dart';
import 'assignment_detail_page.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList({Key? key}) : super(key: key);
  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  SavedAssignmentFilters _currentFilter = SavedAssignmentFilters.NewestFirst;
  List<SavedAssignment> _filteredList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setFilteredList(List<SavedAssignment> list) {
    final List<SavedAssignment> _filtList = list.where((element) {
      return element.status == 'assigned';
    }).toList();
    if (_currentFilter == SavedAssignmentFilters.NewestFirst) {
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
      _filteredList = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0XFFf0f5ff), Colors.white],
        ),
      ),
      child: Consumer<List<SavedAssignment>>(
        builder: (context, list, widget) {
          _setFilteredList(
              list.where((element) => element.status == 'assigned').toList());
          return SingleChildScrollView(
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
                              'Assignments',
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
                                  _setFilteredList(list);
                                });
                              },
                              itemBuilder: (context) {
                                return <PopupMenuEntry<SavedAssignmentFilters>>[
                                  PopupMenuItem(
                                      child: Text(
                                        'Newest First',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value:
                                          SavedAssignmentFilters.NewestFirst),
                                  PopupMenuItem(
                                      child: Text(
                                        'Oldest First',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value:
                                          SavedAssignmentFilters.OldestFirst),
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
                const SizedBox(height: 10),
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
                        navigate: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssignmentDetailPage(
                                caseId: _filteredList[index].caseId,
                              ),
                            ),
                          );
                        },
                        assignment: _filteredList[index],
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
