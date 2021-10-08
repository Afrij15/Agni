import 'package:flutter/material.dart';
import 'package:wasthu/Screens/Pages/home.dart';
import 'package:wasthu/main.dart';

class OrderSuccess extends StatelessWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: Colors.green[800],
              ),
              child: Icon(
                Icons.done,
                size: 70,
                color: Colors.white,
              ),
            ),
            Text(
              "Order Success",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Text('Go to Home'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.pink[300],
                textStyle: TextStyle(fontSize: 14),
              ),
            )
          ],
        ),
      ),
    );
  }
}
