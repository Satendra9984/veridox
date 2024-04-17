import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:veridox/app_models/sorting_enums.dart';
import '../../app_models/saved_assignment_model.dart';
import '../../app_widgets/saved_assignment_card.dart';

class ApprovedAssignmentList extends StatefulWidget {
  final List<DocumentSnapshot> savedAssList;
  const ApprovedAssignmentList({
    Key? key,
    required this.savedAssList,
  }) : super(key: key);
  @override
  State<ApprovedAssignmentList> createState() => _ApprovedAssignmentListState();
}

class _ApprovedAssignmentListState extends State<ApprovedAssignmentList> {
  SavedAssignmentFilters _currentFilter = SavedAssignmentFilters.InProgress;
  List<DocumentSnapshot> _filteredListSnap = [];
  List<SavedAssignment> _filteredList = [];
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    /// initializing list
    _inititalData();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  void _inititalData() {
    for (var doc in widget.savedAssList) {
      if (doc.data() != null) {
        Map<String, dynamic>? docdata = doc.data() as Map<String, dynamic>?;
        if (docdata != null) {
          _filteredList.add(SavedAssignment.fromJson(docdata, doc.id));
          _filteredListSnap.add(doc);
        }
      }
    }
  }

  Future<void> _scrollListener() async {
    // debugPrint('controller-> ${_controller.position}');
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      // debugPrint('fetchList-> called');
      await _fetchNextInList();
    }
  }

  Future<void> _fetchNextInList() async {
    try {
      await FirebaseFirestore.instance
          .collection('field_verifier')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('assignments')
          .where('status', isEqualTo: 'approved')
          .startAfterDocument(_filteredListSnap[_filteredListSnap.length - 1])
          .limit(5)
          .get()
          .then((value) {
        List<DocumentSnapshot>? snapList = value.docs;
        if (snapList != null && snapList.isNotEmpty) {
          for (var doc in snapList) {
            Map<String, dynamic>? docdata = doc.data() as Map<String, dynamic>?;
            if (docdata != null) {
              _filteredList.add(SavedAssignment.fromJson(docdata, doc.id));
              _filteredListSnap.add(doc);
              // debugPrint('docId added-> ${doc.id}');
            }
          }
          setState(() {
            _filteredList;
          });
        }
      });
    } catch (error) {}
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
        controller: _controller,
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
                          'Approved Assignments',
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 25),
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
            const SizedBox(height: 10),
            if (_filteredList.length == 0)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Text(
                  'You do not have any approved assignments yet.'
                  '  Contact your agency for more details',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_filteredList.length > 0)
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                // controller: _controller,
                shrinkWrap: true,
                itemCount: _filteredList.length,
                itemBuilder: (context, index) {
                  return SavedAssignmentCard(
                    navigate: () {},
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
