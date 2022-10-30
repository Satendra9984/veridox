import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:veridox/app_screens/assignments/assignment_list.dart';
import 'package:veridox/app_screens/assignments/saved_assignments_page.dart';
import 'package:veridox/app_utils/app_functions.dart';

import '../../app_widgets/custom_app_bar.dart';
import '../../app_widgets/profile_options.dart';

class FieldVerifierDashboard extends StatefulWidget {
  const FieldVerifierDashboard({Key? key}) : super(key: key);

  @override
  State<FieldVerifierDashboard> createState() => _FieldVerifierDashboardState();
}

class _FieldVerifierDashboardState extends State<FieldVerifierDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: const EdgeInsets.only(right: 8.0, left: 0, top: 4, bottom: 4),
          child: Image.asset(
            'assets/launcher_icons/veridocs_launcher_icon.jpeg',
            fit: BoxFit.contain,
            height: 84,
            width: 124,
          ),
        ),
        leadingWidth: 134,
        title: Text(
          'DashBoard',
          style: const TextStyle(
            color: Color(0XFF0e4a86),
            fontSize: 18,
          ),
        ),
        // backgroundColor: const Color(0xFFecf8ff),
        backgroundColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //  ProfileOptions(
            //   option: 'Assignment History',
            //   onPress: () {
            //     Navigator.push(
            //       context,
            //       CupertinoPageRoute(
            //         builder: (BuildContext context) =>
            //             const AssignmentDetailPage(
            //           caseId: '',
            //         ),
            //       ),
            //     );
            //   },
            //   valueIcon: Icon(
            //     Icons.history_edu,
            //     color: Colors.brown.shade600,
            //   ),
            // ),
            ProfileOptions(
              option: 'In Progress Assignments',
              onPress: () {
                navigatePush(context, SavedAssignmentsPage());
              },
              valueIcon: Icon(
                Icons.save_as,
                color: Colors.deepOrangeAccent,
              ),
            ),
            ProfileOptions(
              option: 'Assignment Completed',
              onPress: () {
                // TODO: COMPLETED ASSIGNMENTS
              },
              valueIcon: Icon(
                FontAwesomeIcons.check,
                color: Colors.green.shade900,
              ),
            ),

            const SizedBox(height: 30),

            AssignmentList(),
          ],
        ),
      ),
    );
  }
}
