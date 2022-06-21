import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  final _firestore = FirebaseFirestore.instance;
  // this variable will be used to control the hiding of the bottomNavigationBar
  // we will pass the reference to other screens also to control hiding/showing
  static final ScrollController _controller = ScrollController();
  static final PageController _pageController = PageController();
  bool bottomNavigationBarHide = false;
  // this variable will be use for pointing to the current selected screen in the bottomNavigationBar
  int currentItemSelected = 0;
  bool _isLoading = false;
  bool _isInit = false;
  // here is the list of all the screens whose icons are present in the bnb , will initialize when the page initializes
  late List<Widget> screens;

  @override
  void initState() {
    // we can not initialize firebase data here because it will not refresh until app is active
    _controller.addListener(listen);
    // now initializing the screen when the home_screen created can't initialize before because we need _controller to be passed
    screens = [
      const AssignmentList(),
      const SavedAssignmentsPage(),
      const ProfilePage(),
      const CompletedAssignemtsPage(),
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
    // print('home page disposed');
    _controller.removeListener(listen);
    _controller.dispose();
    super.dispose();
  }

// this function will listen for all the changes in the _controller and notify to bottomNavigationBar to hide/show
  void listen() {
    final direction = _controller.position.userScrollDirection;
    setState(
      () {
        if (direction == ScrollDirection.forward) {
          bottomNavigationBarHide = false;
        } else if (direction == ScrollDirection.reverse) {
          bottomNavigationBarHide = true;
        }
      },
    );
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
      bottomNavigationBar: AnimatedContainer(
        decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        duration: const Duration(milliseconds: 100),
        // the main trick behind the hiding of the bnb we just reduced the height of it when required
        height: !bottomNavigationBarHide ? 50 : 0,
        child: Wrap(
          // for no overflow of bnb
          children: [
            BottomNavigationBar(
              currentIndex:
                  currentItemSelected, // we have make it a variable so that selected item will be highlighted otherwise no means to notify
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black38,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  label: 'Home',
                  // backgroundColor: Colors
                  //     .purple, // this is the background colour of whole navBar if this icon is selected
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
                // print('$screen selected');
                // here we will notify all listeners which are dependent on the current selected item eg., selectedItemColor in bnb
                setState(
                  () {
                    _pageController.jumpToPage(screen);
                  },
                );
              },
            ),
          ],
        ),
      ),
      // bottom navigation bar
    );
  }
}
