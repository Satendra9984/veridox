import 'package:flutter/material.dart';

class MyAssignments extends StatelessWidget {
  const MyAssignments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 25),
          Row(
            children: [
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(
                    right: 8.0, left: 15, top: 5, bottom: 10),
                child: Image.asset(
                  'assets/launcher_icons/veridocs_launcher_icon.jpeg',
                  fit: BoxFit.contain,
                  height: 50,
                  width: 150,
                ),
              ),
            ],
          ),
          Text(
            'My Assignments',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
