import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/modals/snap.dart';

class DatabaseService {
  final String uid;

  DatabaseService({
    required this.uid,
  });
  //collection reference
  final CollectionReference customerCollection =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(
      String name, String email, String address, String mobile) async {
    return await customerCollection.doc(uid).set(
        {'name': name, 'email': email, 'address': address, 'mobile': mobile});
  }

//wasthUser list from snapshop
  List<WasthUser> _wasthUserListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //print(doc.data);
      return WasthUser(name: doc['name'] ?? '', email: doc['email'] ?? '');
    }).toList();
  }

// get Users Stream
  Stream<List<WasthUser>> get users {
    return customerCollection.snapshots().map((_wasthUserListFromSnapshot));
  }
}
