import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';

class Lab extends StatefulWidget {
  const Lab({Key? key}) : super(key: key);

  @override
  State<Lab> createState() => _LabState();
}

class _LabState extends State<Lab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await _showSubmitted();
            },
            child: Text('On Pressed'),
          ),
        ],
      ),
    );
  }

  Future<void> _showSubmitted() async {
    await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Future.delayed(
          Duration(seconds: 3),
        ),
        progress: Container(
          child: Icon(
            IconData(0xf635, fontFamily: 'MaterialIcons'),
            color: CupertinoColors.systemGreen,
            size: 50,
          ),
        ),
        message: Container(
          child: Text(
            'Submitted Successfully',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showNotSubmitted() async {
    await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Future.delayed(
          Duration(seconds: 3),
        ),
        progress: Container(
          child: Icon(
            IconData(0xe6cb, fontFamily: 'MaterialIcons'),
            color: CupertinoColors.systemRed,
            size: 50,
          ),
        ),
        message: Container(
          child: Text(
            'Something Went Wrong',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
