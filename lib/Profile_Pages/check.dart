import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/shared/constants.dart';
import 'package:wasthu/shared/loading.dart';

class GetUserName extends StatefulWidget {
  final String documentId;

  GetUserName(this.documentId);

  @override
  _GetUserNameState createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  @override
  Widget build(BuildContext context) {
    CollectionReference users =
        FirebaseFirestore.instance.collection('customer');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.pink[100],
              title: Text('Wishlist'),
            ),
            body: ListView(
              children: const <Widget>[
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/item1.png',
                      ),
                    ),
                    title: Text(
                      'Ladies Top',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    subtitle: Text(
                      'Rs. 3500',
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Text(
                      'In Stock',
                      style: TextStyle(color: Colors.green),
                    ),
                    // trailing: Icon(Icons.more_vert),
                    //isThreeLine: true,
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(
                        'assets/item2.png',
                      ),
                    ),
                    title: Text(
                      'Ladies Top',
                      style: TextStyle(fontFamily: 'Poppins'),
                    ),
                    subtitle: Text(
                      'Rs. 3500',
                      style: TextStyle(color: Colors.black54),
                    ),
                    trailing: Text(
                      'Out of Stock',
                      style: TextStyle(color: Colors.red),
                    ),
                    //isThreeLine: true,
                  ),
                ),
              ],
            ),
          );
        }

        return Loading();
      },
    );
  }
}
