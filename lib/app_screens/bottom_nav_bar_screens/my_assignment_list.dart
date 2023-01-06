import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../app_models/saved_assignment_model.dart';
import '../../app_models/sorting_enums.dart';
import '../../app_widgets/saved_assignment_card.dart';

class MyAssignmentList extends StatefulWidget {
  final List<SavedAssignment> savedAssList;
  const MyAssignmentList({
    Key? key,
    required this.savedAssList,
  }) : super(key: key);
  @override
  State<MyAssignmentList> createState() => _MyAssignmentListState();
}

class _MyAssignmentListState extends State<MyAssignmentList> {
  List<SavedAssignment> _filteredList = [];
  List<String> _filterList = [];
  Map<String, dynamic> _filters = {};

  @override
  void initState() {
    /// initializing list
    _filteredList = widget.savedAssList;
    super.initState();
  }

  void _setFilterListByDate(MyAssignmentListFilters _currentFilter,
      {bool haveToInitializeList = false}) {
    if (_currentFilter == MyAssignmentListFilters.All) {
      _filteredList = widget.savedAssList;
      _filters.clear();
      return;
    }
    if (_filters.containsKey('by_date') &&
        _currentFilter != MyAssignmentListFilters.Month) {
      _filters.remove('by_date');
    }

    if (haveToInitializeList) {
      _filteredList = widget.savedAssList;
      if (_filters.containsKey('by_status')) {
        _filterListByStatus(_filters['by_status']);
      }
      if (_filters.containsKey('by_type')) {
        _filterListByType(_filters['by_type']);
      }
      if (_filters.containsKey('by_month')) {
        _filterListByMonth(_filters['by_month']);
      }
    }

    List<SavedAssignment> _filtList = _filteredList;

    if (_currentFilter == MyAssignmentListFilters.NewestFirst) {
      _filtList.sort((first, second) {
        DateTime firstDate = DateFormat('dd/MM/yyyy').parse(first.assignedDate);
        DateTime secondDate =
            DateFormat('dd/MM/yyyy').parse(second.assignedDate);
        return secondDate.compareTo(firstDate);
      });
      _filteredList = _filtList;
    } else if (_currentFilter == MyAssignmentListFilters.OldestFirst) {
      _filtList.sort((first, second) {
        DateTime firstDate = DateFormat('dd/MM/yyyy').parse(first.assignedDate);
        DateTime secondDate =
            DateFormat('dd/MM/yyyy').parse(second.assignedDate);
        return firstDate.compareTo(secondDate);
      });
      _filteredList = _filtList;
    } else if (_currentFilter == MyAssignmentListFilters.Month) {
      _showDateTimePicker();
    }
    if (_currentFilter != MyAssignmentListFilters.Month) {
      _filters['by_date'] = _currentFilter;
    }
  }

  void _filterListByMonth(String month, {bool haveToInitializeList = false}) {
    if (_filters.containsKey('by_month')) {
      _filters.remove('by_month');
    }
    if (haveToInitializeList) {
      _filteredList = widget.savedAssList;
      if (_filters.containsKey('by_status')) {
        _filterListByStatus(_filters['by_status']);
      }
      if (_filters.containsKey('by_date')) {
        _setFilterListByDate(_filters['by_date']);
      }
      if (_filters.containsKey('by_type')) {
        _filterListByType(_filters['by_type']);
      }
    }

    List<SavedAssignment> _filtList = _filteredList;

    _filteredList = _filtList.where((assignment) {
      String date = assignment.assignedDate;
      List<String> listOfDate = date.split("/");
      // debugPrint('listMonth-> ${listOfDate[1]}, month-> $month');
      return listOfDate[1] == month;
    }).toList();
    // setState(() {
    _filteredList;
    _filters['by_month'] = month;
    // });
  }

  void _filterListByType(MyAssignmentListFilters _currentFilter,
      {bool haveToInitializeList = false}) {
    if (_filters.containsKey('by_type')) {
      _filters.remove('by_type');
    }
    if (haveToInitializeList) {
      _filteredList = widget.savedAssList;

      if (_filters.containsKey('by_status')) {
        _filterListByStatus(_filters['by_status']);
      }
      if (_filters.containsKey('by_date')) {
        _setFilterListByDate(_filters['by_date']);
      }
      if (_filters.containsKey('by_month')) {
        _filterListByMonth(_filters['by_month']);
      }
    }

    List<SavedAssignment> _filtList = _filteredList;

    if (_currentFilter == MyAssignmentListFilters.CustomerVerification) {
      _filtList = _filteredList.where((element) {
        return element.type == 'Customer Verification';
      }).toList();
    } else if (_currentFilter ==
        MyAssignmentListFilters.DeathClaimVerificationForm) {
      _filtList = _filteredList.where((element) {
        return element.type == 'Death Certificate';
      }).toList();
    } else if (_currentFilter ==
        MyAssignmentListFilters.PersonalLoanVerificationForm) {
      _filtList = _filteredList.where((element) {
        return element.type == 'Personal Loan';
      }).toList();
    } else if (_currentFilter ==
        MyAssignmentListFilters.PayoutVerificationVerificationForm) {
      _filtList = _filteredList.where((element) {
        return element.type == 'Payout Verification';
      }).toList();
    }
    _filteredList = _filtList;
    _filters['by_type'] = _currentFilter;
    debugPrint(_currentFilter.toString());
    debugPrint(_filters.toString());
  }

  void _filterListByStatus(MyAssignmentListFilters _currentFilter,
      {bool haveToInitializeList = false}) {
    if (_filters.containsKey('by_status')) {
      _filters.remove('by_status');
    }
    if (haveToInitializeList) {
      _filteredList = widget.savedAssList;

      if (_filters.containsKey('by_type')) {
        _filterListByType(_filters['by_type']);
      }
      if (_filters.containsKey('by_date')) {
        _setFilterListByDate(_filters['by_date']);
      }
      if (_filters.containsKey('by_month')) {
        _filterListByMonth(_filters['by_month']);
      }
    }

    List<SavedAssignment> _filtList = _filteredList;

    if (_currentFilter == MyAssignmentListFilters.Assigned) {
      _filtList = _filteredList
          .where((element) => element.status == 'assigned')
          .toList();
    } else if (_currentFilter == MyAssignmentListFilters.ReAssigned) {
      _filtList = _filteredList
          .where((element) => element.status == 'reassigned')
          .toList();
    } else if (_currentFilter == MyAssignmentListFilters.InProgress) {
      _filtList = _filteredList
          .where((element) => element.status == 'in_progress')
          .toList();
    } else if (_currentFilter == MyAssignmentListFilters.Submitted) {
      _filtList = _filteredList
          .where((element) => element.status == 'submitted')
          .toList();
    } else if (_currentFilter == MyAssignmentListFilters.Completed) {
      _filtList = _filteredList
          .where((element) => element.status == 'completed')
          .toList();
    }
    _filteredList = _filtList;
    _filters['by_status'] = _currentFilter;
  }

  void _showDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    ).then((value) {
      if (value != null) {
        String selectedMonth = value.month.toString();
        debugPrint('date -> $selectedMonth');
        _filterListByMonth(selectedMonth);
      }
    });
  }

  void _addFilterToFilterList(MyAssignmentListFilters filter) {
    if (filter == MyAssignmentListFilters.All) {
      _filterList.clear();
      return;
    }
  }

  final Offset distance = const Offset(2.5, 2.5);
  final double blur = 2.5;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 15),

            /// FILTER OPTIONS
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton<MyAssignmentListFilters>(
                        onSelected: (filter) {
                          setState(() {
                            _filterListByStatus(filter,
                                haveToInitializeList: true);
                            _addFilterToFilterList(filter);
                          });
                        },
                        itemBuilder: (context) {
                          return <PopupMenuEntry<MyAssignmentListFilters>>[
                            PopupMenuItem(
                              child: Text(
                                'Assigned',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters.Assigned,
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Re-Assigned',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters.ReAssigned,
                            ),
                            PopupMenuItem(
                              child: Text(
                                'In-Progress',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters.InProgress,
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Submitted',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters.Submitted,
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Completed',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters.Completed,
                            ),
                          ];
                        },
                        child: Text(
                          'Filter By Status',
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15,
                      ),
                      Icon(Icons.arrow_drop_down_outlined),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton<MyAssignmentListFilters>(
                        // initialValue: _currentFilter,
                        onSelected: (filter) {
                          setState(() {
                            _filterListByType(filter,
                                haveToInitializeList: true);
                            _addFilterToFilterList(filter);
                          });
                        },
                        itemBuilder: (context) {
                          return <PopupMenuEntry<MyAssignmentListFilters>>[
                            PopupMenuItem(
                              child: Text(
                                'Death Claim',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters
                                  .DeathClaimVerificationForm,
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Payout Verification',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters
                                  .PayoutVerificationVerificationForm,
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Personal Loan',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters
                                  .PersonalLoanVerificationForm,
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Customer Verification',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value:
                                  MyAssignmentListFilters.CustomerVerification,
                            ),
                          ];
                        },
                        child: Text(
                          'Filter By Type',
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15,
                      ),
                      Icon(Icons.arrow_drop_down_outlined),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PopupMenuButton<MyAssignmentListFilters>(
                        // initialValue: _currentFilter,
                        onSelected: (filter) {
                          setState(() {
                            _setFilterListByDate(filter,
                                haveToInitializeList: true);
                            _addFilterToFilterList(filter);
                          });
                        },
                        itemBuilder: (context) {
                          return <PopupMenuEntry<MyAssignmentListFilters>>[
                            PopupMenuItem(
                              child: Text(
                                'Newest First',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters.NewestFirst,
                            ),
                            PopupMenuItem(
                              child: Text(
                                'Oldest First',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              value: MyAssignmentListFilters.OldestFirst,
                            ),
                            PopupMenuItem(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Month',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      // color: Colors.purple,
                                    ),
                                  ),
                                ],
                              ),
                              value: MyAssignmentListFilters.Month,
                            ),
                          ];
                        },
                        child: Text(
                          'Filter By Date',
                          style: TextStyle(
                            color: Colors.blue.shade500,
                            fontSize: 17,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 15,
                      ),
                      Icon(Icons.arrow_drop_down_outlined),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          _setFilterListByDate(MyAssignmentListFilters.All,
                              haveToInitializeList: true);
                          _addFilterToFilterList(MyAssignmentListFilters.All);
                        });
                      },
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.blue.shade500,
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            /// SELECTED FILTERS
            if (_filters.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                itemCount: _filters.entries.length,
                itemBuilder: (context, index) {
                  // debugPrint(
                  //     'grid-> index-> $index, element-> ${_filterList[index]}');
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    padding:
                        EdgeInsets.symmetric(horizontal: 2.5, vertical: 1.5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.grey.shade100,
                      ),
                      borderRadius: BorderRadius.circular(50),
                      shape: BoxShape.rectangle,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: blur,
                          offset: -distance,
                          // color: Colors.grey.shade500,
                          color: Colors.white54,

                          // inset: isPressed,
                        ),
                        BoxShadow(
                          blurRadius: blur,
                          offset: distance,
                          // color: Colors.white54,
                          color: Colors.grey.shade400,
                        ),
                      ],
                    ),
                    child: Text(
                      getEnumString(index),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 6,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 5,
                ),
              ),

            // const SizedBox(height: 10),
            if (_filterList.isEmpty) SizedBox(height: 20),
            Center(
              child: Text(
                'Total Assignments: ${_filteredList.length}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey.shade800,
                ),
              ),
            ),

            if (_filteredList.length == 0)
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(15),
                alignment: Alignment.center,
                child: Text(
                  'No Assignments',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
            if (_filteredList.length > 0)
              ListView.builder(
                // itemExtent: ,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _filteredList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      SavedAssignmentCard(
                        navigate: () {},
                        assignment: _filteredList[index],
                      ),
                      SizedBox(height: 5),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  String getEnumString(int index) {
    String key = _filters.keys.elementAt(index);
    if (key == 'by_month') {
      return 'Month: ${_filters[key]}';
    }
    return _filters[key]
        .toString()
        .substring(24, _filters[key].toString().length);
  }
}
