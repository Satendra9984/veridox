import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.white,
        shadowColor: Colors.lightBlueAccent.shade100.withOpacity(0.30),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Image.asset(
          'assets/launcher_icons/veridocs_launcher_icon.jpeg',
          fit: BoxFit.contain,
          height: 50,
          width: 150,
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: 15),
          Text(
            'Notification',
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
