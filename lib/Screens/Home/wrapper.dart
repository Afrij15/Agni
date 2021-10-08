import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasthu/Screens/Authenticate/authenticate.dart';
import 'package:wasthu/Screens/Pages/home.dart';
import 'package:wasthu/Screens/Pages/navbar.dart';

import 'package:wasthu/Services/user.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userid?>(context);
    //print(user);

    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Navbar();
    }
  }
}
