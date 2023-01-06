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
    with TickerProviderStateMixin {
  final Offset distance = const Offset(3.5, 3.5);
  final double blur = 5.0;
  late PageController _pageController;
  int _currentTabNumber = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
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
        children: [
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TabForDashboard(
                currentTabNumber: _currentTabNumber,
                label: 'Assigned',
                tabNumber: 0,
                onPressed: () {
                  setState(() {
                    _currentTabNumber = 0;
                  });
                  _pageController.jumpToPage(0);
                },
              ),
              TabForDashboard(
                currentTabNumber: _currentTabNumber,
                label: 'In-Progress',
                tabNumber: 1,
                onPressed: () {
                  setState(() {
                    _currentTabNumber = 1;
                  });
                  _pageController.jumpToPage(1);
                },
              ),
              TabForDashboard(
                currentTabNumber: _currentTabNumber,
                label: 'Submitted',
                tabNumber: 2,
                onPressed: () {
                  setState(() {
                    _currentTabNumber = 2;
                  });
                  _pageController.jumpToPage(2);
                },
              ),
              TabForDashboard(
                currentTabNumber: _currentTabNumber,
                label: 'Approved',
                tabNumber: 3,
                onPressed: () {
                  setState(() {
                    _currentTabNumber = 3;
                  });
                  _pageController.jumpToPage(3);
                },
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                const AssignmentList(),
                const SavedAssignmentsPage(),
                SubmittedAssignmentsPage(),
                ApprovedAssignmentsPage(),
              ],
              onPageChanged: (int pageNumber) {
                setState(() {
                  _currentTabNumber = pageNumber;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // bool get wantKeepAlive => true;
}

class TabForDashboard extends StatelessWidget {
  final String label;
  final int currentTabNumber, tabNumber;
  final Function() onPressed;
  const TabForDashboard({
    Key? key,
    required this.currentTabNumber,
    required this.tabNumber,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 40,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: currentTabNumber != tabNumber
              ? Colors.grey.shade300
              : Colors.blue,
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
            softWrap: true,
          ),
        ),
      ),
    );
  }
}
