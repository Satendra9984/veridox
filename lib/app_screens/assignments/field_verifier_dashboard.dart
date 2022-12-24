import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_screens/assignments/assignment_list.dart';
import 'package:veridox/app_screens/assignments/completed_assignments_page.dart';
import 'package:veridox/app_screens/assignments/my_assignments.dart';
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
    _tabController = TabController(length: 3, vsync: this);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 25),
          Container(
            alignment: Alignment.topLeft,
            margin:
                const EdgeInsets.only(right: 8.0, left: 15, top: 5, bottom: 10),
            child: Image.asset(
              'assets/launcher_icons/veridocs_launcher_icon.jpeg',
              fit: BoxFit.contain,
              height: 50,
              width: 150,
            ),
          ),
          Divider(
            thickness: 2.0,
          ),
          Card(
            margin:
                const EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 0),
            elevation: 0.0,
            child: TabBar(
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
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                gradient: LinearGradient(
                  colors: [Colors.lightBlue, Colors.lightBlueAccent],
                ),
              ),
              padding: EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 5),
              tabs: [
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: _currentTabNumber != 0
                          ? Colors.grey.shade300
                          : Colors.transparent,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Assigned',
                        style: TextStyle(
                          color: _currentTabNumber == 0
                              ? Colors.white
                              : Colors.grey.shade900,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: _currentTabNumber != 1
                          ? Colors.grey.shade300
                          : Colors.transparent,
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'In Progress',
                        style: TextStyle(
                          color: _currentTabNumber == 1
                              ? Colors.white
                              : Colors.grey.shade900,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: _currentTabNumber != 2
                          ? Colors.grey.shade300
                          : Colors.transparent,
                      // boxShadow: [
                      // BoxShadow(
                      //   blurRadius: blur,
                      //   offset: -distance,
                      //   color: Colors.black,
                      //   // inset: isPressed,
                      // ),
                      // BoxShadow(
                      //   blurRadius: blur,
                      //   offset: distance,
                      //   // color: const Color(0xFFA7A9AF),
                      //   color: Colors.black,
                      // ),
                      // ],
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Completed',
                        style: TextStyle(
                          color: _currentTabNumber == 2
                              ? Colors.white
                              : Colors.grey.shade900,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                AssignmentList(),
                SavedAssignmentsPage(),
                SubmittedAssignmentsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
