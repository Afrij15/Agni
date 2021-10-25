import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink[100],
          title: Text('Cart'),
          actions: <Widget>[
          new Icon(
            Icons.cart,
            color: Colors.white,
          )
        ]
        ),
        body: Center(
          child: Text('Cart Empty, Please Load More'),
        ));
  }
}
