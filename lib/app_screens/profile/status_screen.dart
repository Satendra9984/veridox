import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key,
    required this.uid}) : super(key: key);
  final String uid;
  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  String s = 'requested';

  Stream<String> statusStream(String uid) {
    return FirebaseFirestore.instance.collection('add_requests').doc(uid).snapshots()
        .map((snap) => snap.get('status').toString());
  }

  @override
  void initState() {
    statusStream(widget.uid).listen((status) {
      setState(() {
        s = status;
      });
      if (status == 'accepted') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Agency has accepted your request')));
      } else if (status == 'rejected') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Agency has rejected your request')));
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Status'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Column(
              children: [
                Icon(s == 'requested' ? Icons.pending_actions_rounded
                    : s == 'accepted' ? Icons.done : Icons.cancel),
                Text(s)
              ],
            ),
          )
        ],
      ),
    );
  }
}
