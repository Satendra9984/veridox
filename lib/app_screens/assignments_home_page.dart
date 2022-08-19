import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_screens/completed_assignement_page.dart';
import 'package:veridox/app_screens/profile/profile_page.dart';
import 'package:veridox/app_screens/assignments/saved_assignments_page.dart';
import 'package:veridox/app_providers/assignment_provider.dart';
import 'assignments/assignment_list.dart';

enum FilterOptions {
  oldest,
  all,
}

class AssignmentsHomePage extends StatefulWidget {
  static String assignmentsHomePage = 'assignmentHomePage';
  final int? pageIndex;
  const AssignmentsHomePage({
    Key? key,
    this.pageIndex,
  }) : super(key: key);

  @override
  State<AssignmentsHomePage> createState() => _AssignmentsHomePageState();
}

class _AssignmentsHomePageState extends State<AssignmentsHomePage> {
  bool oldestFilter = false;

  // this variable will be used to control the hiding of the bottomNavigationBar
  // we will pass the reference to other screens also to control hiding/showing
  static final PageController _pageController = PageController();

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
    screens = const [
      AssignmentList(),
      SavedAssignmentsPage(),
      ProfilePage(),
      CompletedAssignemtsPage(),
    ];
    setState(() {
      _isInit = true;
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: first fetch the data from the firebase didChangeDependencies

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<AssignmentProvider>(context).fetchAndLoadData().then(
          (value) {
            setState(
              () {
                _isLoading = false;
              },
            );
          },
        );
      } catch (error) {
        debugPrint(error.toString());
        setState(() {
          _isLoading = false;
        });
      }
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

              // we have make it a variable so that selected item will be highlighted otherwise no means to notify
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black38,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.save_alt,
                  ),
                  label: 'Saved',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                  ),
                  // backgroundColor: Colors.purple,
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.send,
                  ),
                  label: 'Completed',
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
      // bottom navigation bar
    );
  }
}
