import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../app_models/assignment_model.dart';

class FirestoreServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<Assignment>> getAssignments() {
    final _uid = _auth.currentUser!.uid;
    print(_uid);

    return _firestore
        .collection('fv')
        .doc('nZF37kTBVTMbAP452OUQ9ZKxIk32')
        // .where('fv', isEqualTo: 'Satendra Pal')
        .collection('assignments')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Assignment(
                  address: doc['address'],
                  caseId: doc.id,
                  description: doc['description'],
                  type: doc['type'],
                  assignedDate: DateTime.parse(
                    // converting server timeStamps in DateTime format
                    doc['assignedDate'].toDate().toString(),
                  ),
                ),
              )
              .toList(),
        );
  }
}
