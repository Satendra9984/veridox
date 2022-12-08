import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_models/sorting_enums.dart';
import 'package:veridox/app_widgets/assignment_card.dart';
import 'package:veridox/app_models/assignment_model.dart';
import 'package:veridox/app_providers/assignment_provider.dart';
import 'assignment_detail_page.dart';

class AssignmentList extends StatefulWidget {
  const AssignmentList({Key? key}) : super(key: key);
  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  AssignmentFilters _currentFilter = AssignmentFilters.All;
  List<Assignment> _filteredList = [];

  Future<void> _refreshAssignments(BuildContext context) async {
    await Provider.of<AssignmentProvider>(context, listen: false)
        .fetchAndLoadData();
  }

  void _setFilteredList(List<Assignment> list) {
    // debugPrint('current filter -> $_currentFilter\n');
    final List<Assignment> _filtList = list;
    if (_currentFilter == AssignmentFilters.NewestToOldest) {
      _filtList.sort((first, second) {
        DateTime firstDate = DateFormat('dd/MM/yyyy').parse(first.assignedDate);
        DateTime secondDate =
            DateFormat('dd/MM/yyyy').parse(second.assignedDate);
        return secondDate.compareTo(firstDate);
      });
      _filteredList = _filtList;
    } else if (_currentFilter == AssignmentFilters.OldestToNewest) {
      _filtList.sort((first, second) {
        DateTime firstDate = DateFormat('dd/MM/yyyy').parse(first.assignedDate);
        DateTime secondDate =
            DateFormat('dd/MM/yyyy').parse(second.assignedDate);
        return firstDate.compareTo(secondDate);
      });
      _filteredList = _filtList;
    } else if (_currentFilter == AssignmentFilters.NewAssignments) {
      _filteredList = _filtList.where((element) {
        return element.status == ('assigned');
      }).toList();
    } else if (_currentFilter == AssignmentFilters.CompletedAssignments) {
      _filteredList = _filtList.where((element) {
        return element.status == ('completed');
      }).toList();
    } else if (_currentFilter == AssignmentFilters.InProgress) {
      _filteredList = _filtList.where((element) {
        return element.status == ('working');
      }).toList();
    } else if (_currentFilter == AssignmentFilters.PendingVerification) {
      _filteredList = _filtList.where((element) {
        return element.status == ('pending_verification');
      }).toList();
    } else {
      _filteredList = list;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [Color(0XFFf0f5ff), Colors.white],
        ),
      ),
      child: Consumer<List<Assignment>>(
        builder: (context, list, widget) {
          _setFilteredList(list);
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
                            PopupMenuButton<AssignmentFilters>(
                              initialValue: _currentFilter,
                              onSelected: (filter) {
                                setState(() {
                                  _currentFilter = filter;
                                  _setFilteredList(list);
                                });
                              },
                              itemBuilder: (context) {
                                return <PopupMenuEntry<AssignmentFilters>>[
                                  PopupMenuItem(
                                      child: Text(
                                        'Newest First',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value: AssignmentFilters.NewestToOldest),
                                  PopupMenuItem(
                                      child: Text(
                                        'Oldest First',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value: AssignmentFilters.OldestToNewest),
                                  PopupMenuItem(
                                      child: Text(
                                        'InProgress',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value: AssignmentFilters.InProgress),
                                  PopupMenuItem(
                                      child: Text(
                                        'Active Only',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value: AssignmentFilters.NewAssignments),
                                  PopupMenuItem(
                                      child: Text(
                                        'Completed Only',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value: AssignmentFilters
                                          .CompletedAssignments),
                                  PopupMenuItem(
                                      child: Text(
                                        'All',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      value: AssignmentFilters.All),
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
                      return AssignmentCard(
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
