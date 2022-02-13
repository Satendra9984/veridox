// import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:veridox/models/assignment_model.dart';
import 'package:veridox/models/assignment_provider.dart';

import '../Elements/assignment_card.dart';
import 'assignment_list.dart';

enum FilterOptions {
  Oldest,
  All,
}

class AssignmentsHomePage extends StatefulWidget {
  static String assignmentsHomePage = 'assignmentHomePage';
  const AssignmentsHomePage({Key? key}) : super(key: key);

  @override
  State<AssignmentsHomePage> createState() => _AssignmentsHomePageState();
}

class _AssignmentsHomePageState extends State<AssignmentsHomePage> {
  bool oldestFilter = false;
  late ScrollController _controller;
  bool bottomNavigationBarHide = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(listen);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(listen);
    super.dispose();
  }

  void listen() {
    final direction = _controller.position.userScrollDirection;
    setState(() {
      if (direction == ScrollDirection.forward) {
        bottomNavigationBarHide = false;
      } else if (direction == ScrollDirection.reverse) {
        bottomNavigationBarHide = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignments'),
        backgroundColor: Colors.green,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedOption) {
              // will do sorting
              // print(selectedOption);
              setState(() {
                if (selectedOption == FilterOptions.Oldest) {
                  oldestFilter = true;
                } else {
                  oldestFilter = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Old to New'),
                value: FilterOptions.Oldest,
              ),
              const PopupMenuItem(
                child: Text('Activity wise'),
                value: FilterOptions.Oldest,
              ),
              const PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          // PopupMenuButton(itemBuilder: (_) => []),
        ],
      ),

      body: Consumer<AssignmentProvider>(
        builder: (ctx, assignmentProv, child) => ListView.builder(
          controller: _controller,
          itemCount: assignmentProv.tasks.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: assignmentProv.tasks[index],
            child: const AssignmentCard(),
          ),
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: !bottomNavigationBarHide ? 50 : 0,
        child: Wrap(
          children: [
            BottomNavigationBar(
              // landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.green,
              selectedItemColor: Colors.black87,
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
                  // backgroundColor: Colors.purple,
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    // color: Colors.purple,
                  ),
                  // backgroundColor: Colors.purple,
                  label: 'Profile',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.send,
                    // color: Colors.purple,
                  ),
                  label: 'Completed',
                  // backgroundColor: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
      // bottom navigation bar
    );
  }
}
