import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_screens/completed_assignement_page.dart';
import 'package:veridox/app_screens/profile_page.dart';
import 'package:veridox/app_screens/saved_assignments_page.dart';
import 'package:veridox/app_providers/assignment_provider.dart';
import 'assignment_list.dart';

enum FilterOptions {
  oldest,
  all,
}

class AssignmentsHomePage extends StatefulWidget {
  static String assignmentsHomePage = 'assignmentHomePage';
  const AssignmentsHomePage({Key? key}) : super(key: key);

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
      AssignmentList(controller: _controller),
      SavedAssignmentsPage(controller: _controller),
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
    // agency: eklavya, sataksh
    // TODO: first fetch the data from the firebase didChangeDependencies

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        Provider.of<AssignmentProvider>(context, listen: false)
            .fetchAndLoadData()
            .then(
          (value) {
            setState(
              () {
                _isLoading = false;
              },
            );
          },
        );
      } catch (error) {
        print(error);
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
    // printFirestore();
    // print('Assignment home screen');
    return Scaffold(
      // this widget will keep all the screen under the same state of this home_page so that no data will be loosen
      // body: IndexedStack(
      //   index: currentItemSelected,
      //   children: screens,
      // ),
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
// final snap = await _firestore
//     .collection('fv')
//     .where('name', isEqualTo: 'Shubhadeep Chowdhary')
//     .get();
// final nasimDoc = snap.docs
//     .firstWhere((element) => element['name'] == 'Shubhadeep Chowdhary');
// await _firestore.collection('fv').doc(nasimDoc.id).update(
//   {
//     'date_of_birth': '01/10/2001',
//   },
// );

//     .add({
//   'address': 'kalyani west bengal',
//   'agency': 'veridox',
//   'date_of_birth': 'OOOOOOO',
//   'date_of_joinig': '01/10/2021',
//   'name': 'Nasim Shah',
//   'phone': '8768715527',
//
// final docList = _firestore.collection('assignments').get();
// List<QueryDocumentSnapshot> document = snap.docs;
// for (var di in document) {
//   print(di.data());
// }

//void printFirestore() async {
//   final proProv = Provider.of<AssignmentProvider>(context);
//   final user = Provider.of<User?>(context);
//   print(' id in home page -->  ${user?.uid}');
// address: '26A Iiit kalyani, West Bengal',
// caseId: 'sbi123456',
// description: 'description',
// type: 'Home Loan',
// status: Status.completed),

// final snap = await _firestore
//     .collection('fv')
//     .doc('Gmq48PNnK4hNgeEAUOdt')
//     .collection('assignments')
//     .add(
//   {
//     'agency': 'veridox',
//     'fv': 'shubhadeep chowdhary',
//     'address': '26A Iiit kalyani, West Bengal',
//     'description': 'description',
//     'type': 'ass.type',
//     'status': 'ass.status.toString()',
//   },
// );

// for (var ass in proProv.tasks) {
//   String id;
//   var timestamp = Timestamp.now();
//   await _firestore.collection('assignments').add(
//     {
//       'agency': 'veridox',
//       'fv': 'shubhadeep chowdhary',
//       'address': '26A Iiit kalyani, West Bengal',
//       'description': ass.description,
//       'type': ass.type,
//       'status': ass.status.toString(),
//     },
//   ).then(
//     (value) => {
//       id = value.id,
//     },
//   );
//   // adding in agency using this id
// }
// final da = await _firestore.collection('assignments').doc().delete();
// final addAssWithServerTimeStamp = await _firestore.collection('assignments').doc(FieldValue.serverTimestamp().toString())

// await _firestore
//     .collection('fv')
//     .doc('nZF37kTBVTMbAP452OUQ9ZKxIk32')
//     .delete();

// DONE: fetch Satendra Pal fv data form firestore
// final list = await _firestore
//     .collection('assignments')
//     // .where('fv', isEqualTo: 'Satendra Pal')
//     .get()
//     .then(
//   (value) async {
//     final doc = value.docs;
//     for (var ed in doc) {
//       await _firestore
//           .collection('assignments')
//           .doc(ed.id)
//           .update({'current_location': 'current_location'});
//     }
//   },
// );
// final list = await _firestore
//     .collection('assignments')
//     .where('fv', isEqualTo: 'nasim shah')
//     .get()
//     .then(
//   (value) async {
//     final doc = value.docs;
//     for (var ev in doc) {
// print('${ev.data()}\n\n');
// final newData =
//     ev.data().update('fv', (value) => 'Shubhadeep chowdhary');
// await _firestore.collection('assignments').doc(ev.id).delete();
// {
//   'address': ev['address'],
//   'agency': 'reignsys',
//   'fv': 'nasim shah',
//   'status': ev['status'],
//   'type': ev['type'],
//   'uid': 'nZF37kTBVTMbAP452OUQ9ZKxIk32',
// },

// }
// },
// );
//}
// _firestore.collection('agency').doc('5auCzgbq6HLOcPZuD2E5').delete();
//     .doc('')
// .set({
//   'address': 'lko, it part',
//   'agency_name': 'eklavya',
//   'owner_name': 'shani',
//   'phone': 7791824894,
// });

// _firestore.collection('fv').doc('r3vs22ORZVaDY4P2mbx2gR7v5583').set({
//   'address': 'lucknow',
//   'agency': 'eklavya',
//   'current_location': const GeoPoint(0, 0),
//   'date_of_birth': '27/6/2001',
//   'date_of_joining': '03/05/2020',
//   'name': 'ankit mishra',
//   'phone': 8726452456,
// });
// _firestore
//     .collection('assignments')
// // .where('current_location', isEqualTo: 'current_location')
// .get()
//     .then((value) {
// print(value.docs);
// final dataa = value.docs;
// for (var data in dataa) {
// _firestore.collection('assignments').add(data.data());
// _firestore
// .collection('assignments')
// .doc(data.id)
// .update({'description': 'description'});
// }
// });
