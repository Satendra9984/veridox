import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../app_models/saved_assignment_model.dart';

class FirestoreServices {
  static final _firestore = FirebaseFirestore.instance;

  static Future<List<Map<String, dynamic>>> getAllAssignments() async {
    final _auth = FirebaseAuth.instance;
    final uid = _auth.currentUser!.uid;
    List<Map<String, dynamic>> list = [];
    try {
      await _firestore
          .collection('field_verifier')
          .doc(uid)
          .collection('assignments')
          .get()
          .then((lists) {
        lists.docs.forEach((elementQuery) {
          var element = elementQuery.data();
          element['caseId'] = elementQuery.id;
          list.add(element);
        });
      });
    } catch (error) {
      debugPrint('$error in getAllAssignments');
    }
    return list;
  }

  static Stream<List<SavedAssignment>> getAssignedAssignments() {
    final _auth = FirebaseAuth.instance;
    final uid = _auth.currentUser!.uid;
    // debugPrint('uid --> $uid\n\n');
    return _firestore
        .collection('field_verifier')
        .doc(uid)
        .collection('assignments')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map(
            (doc) {
              Map<String, dynamic> docData = doc.data();
              docData['caseId'] = doc.id;
              return SavedAssignment.fromJson(docData, doc.id);
            },
          ).toList(),
        );
  }

  /// get saved assignments list
  static Future<List<Map<String, dynamic>>?> getAssignmentsByStatus(
      {required String filter1, String? filter2}) async {
    final _auth = FirebaseAuth.instance;
    final uid = _auth.currentUser!.uid;
    List<Map<String, dynamic>> list = [];
    await _firestore
        .collection('field_verifier')
        .doc(uid)
        .collection('assignments')
        .where('status', isEqualTo: filter1)
        .get()
        .then((lists) async {
      if (lists.docs.isNotEmpty) {
        lists.docs.forEach((elementQuery) {
          var element = elementQuery.data();
          element['caseId'] = elementQuery.id;
          list.add(element);
        });
        if (filter2 != null) {
          await _firestore
              .collection('field_verifier')
              .doc(uid)
              .collection('assignments')
              .where('status', isEqualTo: filter2)
              .get()
              .then((lists) {
            if (lists.docs.isNotEmpty) {
              lists.docs.forEach((elementQuery) {
                var element = elementQuery.data();
                element['caseId'] = elementQuery.id;
                list.add(element);
              });
            }
          });
        }
      }
    }).catchError((error) {
      debugPrint('Saved assignment error: $error');
    });
    // debugPrint('status-> $filter1, list-> $list');
    return list;
  }

  /// Below two functions are used for getting complete assignment from firebase
  static Future<Map<String, dynamic>?> getAssignmentById(String id) async {
    final snapshot = await _firestore.collection('assignments').doc(id).get();
    // debugPrint(
    //     'Assignment got from assignmen collection -- > $id: \n${snapshot.data()}\n\n');
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
    final snap = await _firestore.collection('add_requests').doc(uid).get();
    if (snap.data() == null) {
      return false;
    }

    return snap.data()!.isNotEmpty;
  }

  static Future<Map<String, dynamic>?> getRequestStatus(String uid) async {
    final snap = await _firestore.collection('add_requests').doc(uid).get();
    return snap.data();
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

  static Future<void> updateAssignmentStatus(
      {required String caseId,
      required String status,
      required String agencyId}) async {
    try {
      final _auth = FirebaseAuth.instance;
      // update in assignments collection
      await _firestore
          .collection('assignments')
          .doc(caseId)
          .update({'status': status});
      // update in field_verifier's assignments collection
      await _firestore
          .collection('field_verifier')
          .doc(_auth.currentUser!.uid)
          .collection('assignments')
          .doc(caseId)
          .update({'status': status});
      // update in the agency's assignment collection
      debugPrint('$agencyId status : $status');
      await _firestore
          .collection('agency')
          .doc(agencyId)
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
      // debugPrint('agency --> ${e.id}\n');
      data['id'] = e.id;
      return data;
    }).toList();
  }

  static Future<Map<String, dynamic>> getAgency(String agencyId) async {
    final DocumentSnapshot<Map<String, dynamic>> fList =
        await _firestore.collection('agency').doc(agencyId).get();

    return fList.data()!;
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
      data['agency'] = agency;
      data['status'] = 'requested';
      await _firestore.collection('add_requests').doc(fv).set(data);
    });
  }

  static Future<void> deleteRequest(String uid) async {
    await _firestore.collection('add_request').doc(uid).delete();
  }

  static Future<void> updateDatabase(
      {required Map<String, dynamic> data,
      required String collection,
      required String docId}) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      return;
    }
  }

  static Future<Map<String, dynamic>?> getFieldVerifierData(
      {required String userId}) async {
    try {
      DocumentSnapshot user =
          await _firestore.collection('field_verifier').doc(userId).get();
      return user.data() as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }
}

// nZF37kTBVTMbAP452OUQ9ZKxIk32 --> subhadepp
