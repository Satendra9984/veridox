import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_models/saved_assignment_model.dart';
import '../../app_models/assignment_model.dart';

class FirestoreServices {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<Assignment>> getAssignments() {
    final _uid = _auth.currentUser!.uid;
    return _firestore
        .collection('field_verifier')
        .doc(_uid)
        // .doc('nZF37kTBVTMbAP452OUQ9ZKxIk32')
        .collection('assignments')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Assignment.fromJson(doc.data(), doc.id),
              )
              .toList(),
        );
  }

  /// Below two functions are used for getting complete assignment from firebase
  Future<Map<String, dynamic>?> getAssignmentById(String id) async {
    final snapshot = await _firestore.collection('assignments').doc(id).get();
    debugPrint('Assignment-$id: ${snapshot.data()}');
    return snapshot.data();
  }

  Future<Map<String, dynamic>?> getFormDataById(String id) async {
    final snapshot = await _firestore
        .collection('assignments')
        .doc(id)
        .collection('form_data')
        .doc('data')
        .get();
    return snapshot.data();
  }

  Future<void> updateStatus(
      {required String caseId, required String status}) async {
    try {
      await _firestore
          .collection('assignments')
          .doc(caseId)
          .update({'status': status});
      await _firestore
          .collection('field_verifier')
          .doc(_auth.currentUser!.uid)
          .collection('assignments')
          .doc(caseId)
          .update({'status': status});
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  Future<List<Map<String, dynamic>>> getAgencyList() async {
    final QuerySnapshot<Map<String, dynamic>> fList =
        await _firestore.collection('agency').get();

    final docs = fList.docs;

    return docs.map((e) {
      var data = e.data();
      data['id'] = e.id;
      return data;
    }).toList();
  }
}
// nZF37kTBVTMbAP452OUQ9ZKxIk32 --> subhadepp
