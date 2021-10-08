import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/Screens/Pages/categories.dart';
import 'package:wasthu/Screens/Pages/home.dart';
import 'package:wasthu/Screens/Pages/profile.dart';
import 'package:wasthu/Screens/Pages/wishlist.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  var _page = 0;
  final pages = [Home(), Categories(), Wishlist(), Profile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 0,
        color: Colors.pink.shade300,
        backgroundColor: Colors.transparent,
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(Icons.category, size: 30, color: Colors.white),
          Icon(Icons.favorite, size: 30, color: Colors.white),
          Icon(Icons.person, size: 30, color: Colors.white),
        ],
        //    animationDuration: Duration(milliseconds: 300),
        //    animationCurve: Curves.bounceInOut,
        onTap: (index) {
          //Handle button tap
          setState(() {
            _page = index;
          });
        },
      ),
      body: pages[_page],
    );
  }
}
