import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_screens/completed_assignement_page.dart';
import 'package:veridox/app_screens/asignments/saved_assignments_page.dart';

import '../asignments/assignment_detail_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'My Account',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Container(
          color: Colors.white,
          // height: 300,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),

          child: Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                color: Colors.blueGrey[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/images/doc_image.png',
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Satendra Pal',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'satyendrapal123@gmail.com',
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          '1234567890',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        // TODO: navigate to the edit profile screen
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ProfileOptions(
                option: 'Assignment History',
                onPress: () {
                  // print('pushed');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) => AssignmentDetailPage(
                        caseId: '',
                      ),
                    ),
                  );
                },
              ),
              ProfileOptions(
                option: 'Saved Assignment',
                onPress: () {
                  // print('pushed');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) => SavedAssignmentsPage(
                        controller: ScrollController(),
                      ),
                    ),
                  );
                },
              ),
              ProfileOptions(
                option: 'Assignment Completed',
                onPress: () {
                  // print('pushed');
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) =>
                          CompletedAssignemtsPage(),
                    ),
                  );
                },
              ),
              Divider(
                thickness: 5,
                color: Colors.blueGrey[50],
              ),
              OutlinedButton(
                onPressed: () {
                  // TODO: NAVIGATE TO DETAILS PAGE FOR PROFILE DETAILS
                },
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black),
                  minimumSize: Size(300, 40),
                ),
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOptions extends StatefulWidget {
  final String option;
  final void Function() onPress;
  const ProfileOptions({
    Key? key,
    required this.onPress,
    required this.option,
  }) : super(key: key);

  @override
  State<ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<ProfileOptions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.option,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
          IconButton(
            onPressed: widget.onPress,
            splashColor: Colors.red,
            splashRadius: 40,
            icon: const Icon(Icons.arrow_forward_ios_outlined),
          ),
        ],
      ),
    );
  }
}
