import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_screens/assignments/saved_assignments_page.dart';
import 'package:veridox/app_screens/login/login_page.dart';
import 'package:veridox/app_screens/profile/send_request_screen.dart';
import 'package:veridox/app_utils/app_functions.dart';
import '../assignments/assignment_detail_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late FirebaseAuth _auth;

  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    super.initState();
  }

  String _getEmail() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? email = user.email;

      return email ?? 'No registered email';
    }
    return 'No registered email';
  }

  String _getName() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String? name = user.displayName;

      return name ?? 'No registered name';
    }
    return 'No registered name';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      // height: 300,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
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
                      _getName(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      _getEmail(),
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    // TODO: navigate to the edit profile screen
                    Navigator.of(context)
                        .push(CupertinoPageRoute(builder: (context) {
                      return SendRequestScreen();
                    }));
                  },
                  child: const Text(
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
                  builder: (BuildContext context) => const AssignmentDetailPage(
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
                  builder: (BuildContext context) =>
                      const SavedAssignmentsPage(),
                ),
              );
            },
          ),
          ProfileOptions(
            option: 'Assignment Completed',
            onPress: () {
              // print('pushed');
              // Navigator.push(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (BuildContext context) =>
              //         const CompletedAssignemtsPage(),
              //   ),
              // );
            },
          ),
          Divider(
            thickness: 5,
            color: Colors.blueGrey[50],
          ),
          OutlinedButton(
            onPressed: () {
              // TODO: NAVIGATE TO DETAILS PAGE FOR PROFILE DETAILS
              _auth.signOut();
              navigatePush(context, const LogInPage());
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.black),
              minimumSize: const Size(300, 40),
            ),
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
          ),
        ],
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
