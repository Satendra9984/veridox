import 'package:flutter/material.dart';
import 'package:veridox/app_screens/assignments/approved_assignment_page.dart';
import 'package:veridox/app_screens/assignments/assignment_list.dart';
import 'package:veridox/app_screens/assignments/submitted_assignments_page.dart';
import 'package:veridox/app_screens/assignments/saved_assignments_page.dart';

class FieldVerifierDashboard extends StatefulWidget {
  const FieldVerifierDashboard({Key? key}) : super(key: key);

  @override
  State<FieldVerifierDashboard> createState() => _FieldVerifierDashboardState();
}

class _FieldVerifierDashboardState extends State<FieldVerifierDashboard>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  final Offset distance = const Offset(3.5, 3.5);
  final double blur = 5.0;
  late TabController _tabController;
  int _currentTabNumber = 0;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        shadowColor: Colors.lightBlueAccent.shade100.withOpacity(0.30),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Image.asset(
          'assets/launcher_icons/veridocs_launcher_icon.jpeg',
          fit: BoxFit.contain,
          height: 50,
          width: 150,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15),
          TabBar(
            controller: _tabController,
            onTap: (currentTab) {
              setState(() {
                _currentTabNumber = currentTab;
              });
            },
            unselectedLabelColor: Colors.grey.shade700,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(horizontal: 5),
            indicatorPadding: EdgeInsets.symmetric(vertical: 5),
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              gradient: LinearGradient(
                colors: [Colors.lightBlue, Colors.lightBlueAccent],
              ),
            ),
            padding: EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 5),
            tabs: [
              TabForDashboard(
                currentTabNumber: _currentTabNumber,
                label: 'Assigned',
                tabNumber: 0,
              ),
              TabForDashboard(
                currentTabNumber: _currentTabNumber,
                label: 'In-Progress',
                tabNumber: 1,
              ),
              TabForDashboard(
                currentTabNumber: _currentTabNumber,
                label: 'Submitted',
                tabNumber: 2,
              ),
              TabForDashboard(
                currentTabNumber: _currentTabNumber,
                label: 'Approved',
                tabNumber: 3,
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                AssignmentList(),
                SavedAssignmentsPage(),
                SubmittedAssignmentsPage(),
                ApprovedAssignmentsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class TabForDashboard extends StatelessWidget {
  final String label;
  final int currentTabNumber, tabNumber;
  const TabForDashboard({
    Key? key,
    required this.currentTabNumber,
    required this.tabNumber,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: currentTabNumber != tabNumber
              ? Colors.grey.shade300
              : Colors.transparent,
        ),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            '$label',
            style: TextStyle(
              color: currentTabNumber == tabNumber
                  ? Colors.white
                  : Colors.grey.shade900,
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
