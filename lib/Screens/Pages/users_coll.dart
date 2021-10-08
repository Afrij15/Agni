import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:wasthu/modals/snap.dart';

class UserColl extends StatefulWidget {
  const UserColl({Key? key}) : super(key: key);

  @override
  _UserCollState createState() => _UserCollState();
}

class _UserCollState extends State<UserColl> {
  @override
  Widget build(BuildContext context) {
    final usersd = Provider.of<List<WasthUser>>(context);
    //print(users.docs
    // );
    usersd.forEach((usersd) {
      print(usersd.email);
      print(usersd.name);
    });
    return Container();
  }
}
