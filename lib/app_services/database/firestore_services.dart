import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app_models/assignment_model.dart';

class FirestoreServices {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  static Stream<List<Assignment>> getAssignments() {
    final uid = _auth.currentUser!.uid;
    return _firestore
        .collection('field_verifier').doc(uid).collection('assignments')
        .snapshots().map(
          (snapshot) => snapshot.docs.map(
                (doc) => Assignment.fromJson(doc.data(), doc.id),).toList(),);
  }

  /// Below two functions are used for getting complete assignment from firebase
  static Future<Map<String, dynamic>?> getAssignmentById(String id) async {
    final snapshot = await _firestore.collection('assignments').doc(id).get();
    debugPrint('Assignment-$id: ${snapshot.data()}');
    return snapshot.data();
  }

  static Future<Map<String, dynamic>?> getFormDataById(String id) async {
    final snapshot = await _firestore
        .collection('assignments')
        .doc(id)
        .collection('form_data')
        .doc('data')
        .get();
    return snapshot.data();
  }

  static Future<void> updateStatus(
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

  static Future<List<Map<String, dynamic>>> getAgencyList() async {
    final QuerySnapshot<Map<String, dynamic>> fList =
        await _firestore.collection('agency').get();

    final docs = fList.docs;

    return docs.map((e) {
      var data = e.data();
      data['id'] = e.id;
      return data;
    }).toList();
  }

  static Future<void> sendJoinRequest(Map<String, dynamic> data, String fv, String agency) async {
    return await _firestore.collection('agency').doc(agency).collection('add_requests').doc(fv).set(data);
  }
}


// nZF37kTBVTMbAP452OUQ9ZKxIk32 --> subhadepp
