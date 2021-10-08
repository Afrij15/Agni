import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wasthu/Screens/Pages/buynow.dart';
import 'package:wasthu/Services/auth.dart';
import 'package:wasthu/modals/cart_controller.dart';
import 'package:wasthu/shared/loading.dart';

class ShowProduct extends StatefulWidget {
  final String documentId;

  ShowProduct(this.documentId);

  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  Icon fab = Icon(
    Icons.favorite_border,
  );

  int fabIconNumber = 0;
  int _quantity = 1;
  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decreamentQuantity() {
    setState(() {
      if (_quantity > 1) {
        _quantity--;
      } else {
        _quantity = 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ///Userid retriueving
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final myUid = user!.uid;

    CollectionReference users =
        FirebaseFirestore.instance.collection('products');
    bool selected = true;
    //  final cartController = Get.put(CartController());
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

        //  if (snapshot.connectionState == ConnectionState.done) {
        Map<String, dynamic> data =
            snapshot.data!.data() as Map<String, dynamic>;

        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.grey[300],
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Image(
                          image: NetworkImage(
                            "${data['FileImage']}",
                          ),
                          height: 200,
                          width: double.infinity,
                        ),
                      ),
                      Positioned(
                        right: 20,
                        top: 10,
                        child: IconButton(
                          color: Colors.pink[300],
                          icon: fab,
                          onPressed: () {
                            setState(() {
                              if (fabIconNumber == 0) {
                                fab = Icon(
                                  Icons.favorite,
                                );
                                fabIconNumber = 1;
                                FirebaseFirestore.instance
                                    .collection('wishlist')
                                    .doc(widget.documentId)
                                    .set({
                                  "orderproduct": "${data['ProductName']}",
                                  "pid": widget.documentId,
                                  "price": "${data['Price']}",
                                  "Status": "${data['Status']}",
                                  "FileImage": "${data['FileImage']}",
                                  "cid": myUid,
                                });
                                Fluttertoast.showToast(
                                    msg: 'Added to Wishlist');
                              } else {
                                fab = Icon(Icons.favorite_border);
                                fabIconNumber = 0;
                                FirebaseFirestore.instance
                                    .collection('wishlist')
                                    .doc(widget.documentId)
                                    .delete()
                                    .then((value) => Fluttertoast.showToast(
                                        msg: 'Removed Wishlist'));
                              }
                            });
                          },
                          //    size: 30,
                        ),
                        /*     onPressed: () {
                            
                              FirebaseFirestore.instance
                                  .collection('wishlist')
                                  .doc()
                                  .set({
                                "orderproduct": "${data['ProductName']}",
                                "pid": widget.documentId,
                                "price": "${data['Price']}",
                                "Status": "${data['Status']}",
                                "FileImage": "${data['FileImage']}",
                                "cid": myUid,
                              });
                              Fluttertoast.showToast(msg: 'Added to Wishlist');
                            },
                          ),*/
                      ),
                      Positioned(
                        left: 10,
                        top: 10,
                        child: IconButton(
                          color: Colors.black,
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 30,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "${data['ProductName']}",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 25,
                          color: Colors.red[500],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Rs. ${data['Price']}",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          "${data['Description']}",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      color: Colors.pink[300],
                      icon: const Icon(Icons.remove),
                      onPressed: _decreamentQuantity,
                    ),
                    Text('$_quantity'),
                    IconButton(
                      color: Colors.pink[300],
                      icon: const Icon(Icons.add),
                      onPressed: _incrementQuantity,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey[300],
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Color",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Status",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${data['Color']}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${data['Category']}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${data['Status']}",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.add_shopping_cart),
                        label: Text('Add to Cart'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange[500],
                          textStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BuyNow(widget.documentId, _quantity),
                            ),
                          );
                        },
                        icon: Icon(Icons.arrow_forward),
                        label: Text('Buy Now'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[500],
                          textStyle: TextStyle(fontSize: 14),
                        ),
                      ),
                    )),
                  ],
                )
              ],
            ),
          ),
        );
        //  }

        //   return Loading();
      },
    );
  }
}
