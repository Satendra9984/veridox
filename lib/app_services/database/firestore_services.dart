import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app_models/assignment_model.dart';

class FirestoreServices {
  static final _firestore = FirebaseFirestore.instance;

  static Stream<List<Assignment>> getAssignments() {
    final _auth = FirebaseAuth.instance;
    final uid = _auth.currentUser!.uid;
    debugPrint('uid --> ${uid}');
    debugPrint('getAssignments called again\n');
    return _firestore
        .collection('field_verifier')
        .doc(uid)
        .collection('assignments')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              debugPrint('ass id --> ${doc.id}');
              return Assignment.fromJson(doc.data(), doc.id);
            },
          ).toList(),
        );
  }

  /// Below two functions are used for getting complete assignment from firebase
  static Future<Map<String, dynamic>?> getAssignmentById(String id) async {
    final snapshot = await _firestore.collection('assignments').doc(id).get();
    debugPrint('Assignment-$id: ${snapshot.data()}');
    return snapshot.data();
  }

  static Future<bool> checkIfFvExists(String uid) async {
    final snapshot = await _firestore.collection('field_verifier').get();
    return snapshot.docs
        .where((element) => element.id == uid)
        .toList()
        .isNotEmpty;
  }

  static Future<bool> checkIfRequested(String uid) async {
    final snap = await _firestore.collection('add_requests').get();

    return snap.docs.where((element) => element.id == uid).toList().isNotEmpty;
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
      final _auth = FirebaseAuth.instance;
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
      debugPrint('agency --> ${e.id}\n');
      data['id'] = e.id;
      return data;
    }).toList();
  }

  static Future<List<Map<String, dynamic>>> getAgencyDemo() async {
    final DocumentSnapshot<Map<String, dynamic>> fList =
        await _firestore.collection('agency').doc('sBPZoR1xfEQtYlHk2riF').get();

    List<Map<String, dynamic>> agencyList = [];
    debugPrint(fList.data()!.toString());

    agencyList.add(
      fList.data() ??
          {
            "address": " Tollygunge, Kolkata",
            "agency_name": "XPert Investigation",
          },
    );
    agencyList[0]['id'] = fList.id;
    return agencyList;
  }

  static Future<void> sendJoinRequest(
      Map<String, dynamic> data, String fv, String agency) async {
    await _firestore
        .collection('agency')
        .doc(agency)
        .collection('add_requests')
        .doc(fv)
        .set(data)
        .whenComplete(() async {
      await _firestore.collection('add_requests').doc(fv).set({
        'agency': agency,
        'status': 'requested',
      });
    });
  }
}

// nZF37kTBVTMbAP452OUQ9ZKxIk32 --> subhadepp
