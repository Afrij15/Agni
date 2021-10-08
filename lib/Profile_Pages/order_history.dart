import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

///Userid retriueving
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final myUid = user!.uid;

final Query<Map<String, dynamic>> collectionReference = FirebaseFirestore
    .instance
    .collection('orders')
    .where('cid', isEqualTo: myUid);

class _OrdersState extends State<Orders> {
  List<Widget> _tabs = [
    StreamBuilder(
      stream: collectionReference.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs.map(
              (e) {
                String price = (e['Price']).toString();
                return Card(
                  child: ListTile(
                    onTap: () {
                      /*     Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ShowProduct(e['pid']),
                            ),
                          );*/
                    },
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        e['FileImage'],
                      ),
                    ),
                    title: Text(
                      e['ProductName'],
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    subtitle: Text(
                      price,
                      style: TextStyle(color: Colors.black54),
                    ),

                    // trailing: Icon(Icons.more_vert),
                    //isThreeLine: true,
                  ),
                );
              },
            ).toList(),
          );
        }
        return Center(child: Text('Empty'));
      },
    ),
    Center(child: Text('hi'))
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[700],
          title: Text('Orders'),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text('Ongoing Orders'),
              ),
              Tab(
                child: Text('Past Orders'),
              ),
            ],
          ),
        ),
        body: TabBarView(children: _tabs),
      ),
    );
  }
}
