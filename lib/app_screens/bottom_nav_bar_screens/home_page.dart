import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_screens/bottom_nav_bar_screens/my_assignments.dart';
import 'package:veridox/app_screens/bottom_nav_bar_screens/profile_page.dart';
import '../../app_models/saved_assignment_model.dart';
import '../../app_services/database/firestore_services.dart';
import '../assignments/field_verifier_dashboard.dart';
import 'notifications_page.dart';

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

  // here is the list of all the screens whose icons are present in the bnb , will initialize when the page initializes
  late List<Widget> screens;

  @override
  void initState() {
    // we can not initialize firebase data here because it will not refresh until app is active
    // now initializing the screen when the home_screen created can't initialize before because we need _controller to be passed

    // debugPrint('mew home page has made');
    screens = [
      FieldVerifierDashboard(),
      MyAssignmentsPage(),
      NotificationPage(),
      ProfilePage(),
    ];
    super.initState();
  }

  @override
  void didChangeDependencies() {
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
        StreamProvider<List<SavedAssignment>>(
          create: (context) => FirestoreServices.getAssignedAssignments(),
          initialData: const [],
        ),
      ],
      child: Scaffold(
        // backgroundColor: Colors.orange,
        extendBody: true,
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : PageView(
                physics: NeverScrollableScrollPhysics(),
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
          decoration: BoxDecoration(
            // color: Colors.red,
            border: Border.all(
              color: Colors.blue.shade100,
              width: 1.9,
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: ClipRRect(
            // height: 50,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            child: BottomNavigationBar(
              currentIndex: currentItemSelected,
              // we have made it a variable so that selected item will be highlighted otherwise no means to notify
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.black,
              // backgroundColor: Colors.red,
              elevation: 15,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.list,
                  ),
                  label: 'MyAssignment',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.notifications_none_outlined,
                  ),
                  label: 'Notification',
                ),
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
          ),
        ),
      ),
    );
  }
}
