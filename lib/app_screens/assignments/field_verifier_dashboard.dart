import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:veridox/app_screens/assignments/assignment_list.dart';
import 'package:veridox/app_screens/assignments/completed_assignments_page.dart';
import 'package:veridox/app_screens/assignments/saved_assignments_page.dart';

class FieldVerifierDashboard extends StatefulWidget {
  const FieldVerifierDashboard({Key? key}) : super(key: key);

  @override
  State<FieldVerifierDashboard> createState() => _FieldVerifierDashboardState();
}

class _FieldVerifierDashboardState extends State<FieldVerifierDashboard>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabNumber = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose]
    _tabController.removeListener(() {});
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
        centerTitle: true,
        title: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(right: 8.0, left: 0, top: 4, bottom: 4),
          child: Image.asset(
            'assets/launcher_icons/veridocs_launcher_icon.jpeg',
            fit: BoxFit.contain,
            height: 84,
            width: 124,
          ),
        ),
        leadingWidth: 134,
        backgroundColor: Colors.white,
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: Column(
        children: [
          Card(
            margin:
                const EdgeInsets.only(left: 15, right: 15, bottom: 0, top: 0),
            elevation: 0,
            child: TabBar(
              controller: _tabController,
              onTap: (currentTab) {
                setState(() {
                  _currentTabNumber = currentTab;
                });
              },
              unselectedLabelColor: Colors.grey.shade700,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.white,
                gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.lightBlueAccent]),
              ),
              tabs: [
                Tab(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(color: Colors.blueAccent, width: 1.5)
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: Colors.grey,
                      // border: Border.all(color: Colors.blueAccent, width: 1.5),
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
                    // margin: EdgeInsets.all(5),
                    // padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // border: Border.all(color: Colors.blueAccent, width: 1.5),
                      color: _currentTabNumber != 2
                          ? Colors.grey.shade300
                          : Colors.transparent,
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
              padding: EdgeInsets.only(bottom: 5, left: 15, right: 15, top: 5),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                AssignmentList(),
                SavedAssignmentsPage(),
                CompletedAssignmentsPage(),
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
