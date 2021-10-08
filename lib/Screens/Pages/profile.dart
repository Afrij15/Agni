import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/Profile_Pages/check.dart';
import 'package:wasthu/Profile_Pages/notification.dart';
import 'package:wasthu/Profile_Pages/order_history.dart';
import 'package:wasthu/Profile_Pages/promotion.dart';
import 'package:wasthu/Profile_Pages/settings.dart';
import 'package:wasthu/Screens/Pages/home1.dart';

import 'package:wasthu/Services/auth.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //To retrieve the Userid
  User? user;
  Future<void> getUserData() async {
    User userData = await FirebaseAuth.instance.currentUser!;
    setState(() {
      user = userData;
      print(userData.uid);
      var id = userData.uid;
    });
  }
///////////////////////////////////////

  Future<String>? _title;
  @override
  void initState() {
    getUserData().then((value) => _title = _getAppBarNameWidget());
    // print(_getAppBarNameWidget());
    // _title = _getAppBarNameWidget();
    super.initState();
  }

//To retrieve the name from firestore
  Future<String> _getAppBarNameWidget() async =>
      await FirebaseFirestore.instance
          .collection('customer')
          .doc(user!.uid)
          .get()
          .then((DocumentSnapshot ds) async {
        var name = ds['name'];
        return name;
      });

  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 8.0, 0, 8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/person.png'),
            backgroundColor: Colors.white,
            radius: 10,
          ),
        ),
        title: FutureBuilder(
            future: _title,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              return Text(
                '${snapshot.data}',
                style: TextStyle(color: Colors.black),
              );
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            child: IconButton(
              color: Colors.grey,
              icon: const Icon(Icons.logout),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.location_pin),
              title: Text('Shipping Address'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('Order History'),
              onTap: () => orderHistory(context),
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Track Orders'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.celebration),
              title: Text('Promotions'),
              onTap: () => promotion(context),
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Notification'),
              onTap: () => notification(context),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => settings(context),
            ),
          ],
        ),
      ),
    );
  }

  void settings(BuildContext ctx) {
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return Settingsuser(user!.uid);
        },
      ),
    );
  }
}

void orderHistory(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return Orders();
      },
    ),
  );
}

void promotion(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return Promotion();
      },
    ),
  );
}

void notification(BuildContext ctx) {
  Navigator.of(ctx).push(
    MaterialPageRoute(
      builder: (_) {
        return Notifications();
      },
    ),
  );
}
