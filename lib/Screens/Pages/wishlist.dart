import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wasthu/Screens/Pages/show-product.dart';

class Wishlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ///Userid retriueving
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user!.uid;

    final Query<Map<String, dynamic>> collectionReference = FirebaseFirestore
        .instance
        .collection('wishlist')
        .where('cid', isEqualTo: myUid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        title: Text('Wishlist'),
      ),
      body: StreamBuilder(
        stream: collectionReference.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data!.docs
                  .map(
                    (e) => Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowProduct(e['pid']),
                            ),
                          );
                        },
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                            e['FileImage'],
                          ),
                        ),
                        title: Text(
                          e['orderproduct'],
                          style: TextStyle(fontFamily: 'Poppins'),
                        ),
                        subtitle: Text(
                          e['price'],
                          style: TextStyle(color: Colors.black54),
                        ),
                        /* trailing: Text(
                          e['Status'],
                          style: TextStyle(color: Colors.green),
                        ),*/
                        trailing: IconButton(
                          color: Colors.red,
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            FirebaseFirestore.instance
                                .collection('wishlist')
                                .doc(e.id)
                                .delete()
                                .then((value) =>
                                    Fluttertoast.showToast(msg: 'Deleted'));
                          },
                        ),
                        //isThreeLine: true,
                      ),
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
