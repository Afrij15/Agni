import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Userid retriueving
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user!.uid;
    final Query<Map<String, dynamic>> collectionReference = FirebaseFirestore
        .instance
        .collection('notifications')
        .where('cid', isEqualTo: myUid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text('Notifications'),
      ),
      body: StreamBuilder(
        stream: collectionReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs
                  .map(
                    (e) => ListTile(
                      title: Text(e['notification']),
                      subtitle: Text(e['details']),
                    ),
                  )
                  .toList(),
            );
          }
          return Center(child: Text('Empty'));
        },
      ),
    );
  }
}
