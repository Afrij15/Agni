import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wasthu/Screens/Home/wrapper.dart';
import 'package:wasthu/Services/auth.dart';
import 'package:wasthu/Services/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //need for Firebase
  await Firebase.initializeApp(); //need for Firebase
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Userid?>.value(
      value: AuthService().user,
      initialData: Userid(uid: ''),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.lightBlue),
        debugShowCheckedModeBanner: true,
        home: Wrapper(),
      ),
    );
  }
}
