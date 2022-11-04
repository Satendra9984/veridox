import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_screens/profile/profile_page.dart';
import '../app_models/assignment_model.dart';
import '../app_services/database/firestore_services.dart';
import 'assignments/assignment_list.dart';
import 'assignments/field_verifier_dashboard.dart';

class HomePage extends StatefulWidget {
  static String assignmentsHomePage = 'assignmentHomePage';
  final int? pageIndex;
  const HomePage({
    Key? key,
    this.pageIndex,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oldestFilter = false;

  // this variable will be used to control the hiding of the bottomNavigationBar
  // we will pass the reference to other screens also to control hiding/showing
  final PageController _pageController = PageController();

  // this variable will be use for pointing to the current selected screen in the bottomNavigationBar
  int currentItemSelected = 0;
  bool _isLoading = false;
  bool _isInit = false;

  // here is the list of all the screens whose icons are present in the bnb , will initialize when the page initializes
  late List<Widget> screens;

  @override
  void initState() {
    // we can not initialize firebase data here because it will not refresh until app is active
    // now initializing the screen when the home_screen created can't initialize before because we need _controller to be passed

    debugPrint('mew home page has made');
    screens = [
      FieldVerifierDashboard(),
      // AssignmentList(),
      // SavedAssignmentsPage(),
      // CompletedAssignmentsPage(),
      ProfilePage(),
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // _initLocationService();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // debugPrint('Pagecontroller is disposed\n');
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<List<Assignment>>(
          create: (context) => FirestoreServices.getAssignments(),
          initialData: const [],
        ),
      ],
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PageView(
                controller: _pageController,
                children: screens,
                onPageChanged: (currentScreen) {
                  setState(
                    () {
                      currentItemSelected = currentScreen;
                    },
                  );
                },
              ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          height: 50,
          child: Wrap(
            children: [
              BottomNavigationBar(
                currentIndex: currentItemSelected,
                // we have made it a variable so that selected item will be highlighted otherwise no means to notify
                selectedItemColor: Colors.green,
                unselectedItemColor: Colors.black,
                elevation: 15,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                    ),
                    label: 'Dashboard',
                  ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(
                  //     Icons.save_alt,
                  //   ),
                  //   label: 'Saved',
                  // ),
                  // BottomNavigationBarItem(
                  //   icon: Icon(
                  //     Icons.send,
                  //   ),
                  //   label: 'Completed',
                  // ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                    // backgroundColor: Colors.purple,
                    label: 'Profile',
                  ),
                ],
                onTap: (screen) {
                  setState(() {
                    _pageController.jumpToPage(screen);
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
