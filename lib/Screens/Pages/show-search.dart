import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/Screens/Pages/show-product.dart';
import 'package:wasthu/shared/loading.dart';

class ShowSearch extends StatelessWidget {
  final String searchKey;

  ShowSearch(this.searchKey);

  @override
  Widget build(BuildContext context) {
    final Query<Map<String, dynamic>> collectionReference = FirebaseFirestore
        .instance
        .collection('products')
        .orderBy('ProductName')
        .startAt([searchKey]).endAt([searchKey + '\uf8ff']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Showing Results for ' + searchKey),
      ),
      backgroundColor: Colors.grey[200],
      body: StreamBuilder(
          stream: collectionReference.snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  //  scrollDirection: Axis.horizontal,
                  // padding: EdgeInsets.only(left: 16, right: 6),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final e = snapshot.data!.docs[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowProduct(e.id),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0, 0),
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  offset: const Offset(0, 2),
                                  blurRadius: 10.0),
                            ],
                          ),
                          child: Column(
                            // mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                flex: 4,
                                child: Center(
                                  child: Hero(
                                    tag: "tagHero",
                                    child: Image(
                                      image: NetworkImage(e['FileImage']),
                                      fit: BoxFit.scaleDown,
                                      // height: getProportionateScreenHeight(150),
                                    ),
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 3,
                                child: Container(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            e['ProductName'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black,
                                                fontSize: 25),
                                            maxLines: 2,
                                          ),
                                        ),
                                        Container(
                                          // margin: EdgeInsets.only(top: 10, bottom: 5),
                                          child: Text(
                                            e['Price'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                color: Colors.redAccent,
                                                fontSize: 19),
                                            maxLines: 1,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber[400],
                                              size: 17,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber[400],
                                              size: 17,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber[400],
                                              size: 17,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.amber[400],
                                              size: 17,
                                            ),
                                          ],
                                        )

                                        /*Text(
                                        "s",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black54,
                                            fontSize: 10),
                                        maxLines: 1,
                                      )*/
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );

                    //    return Center(child: Text('hi'));
                  });
            }
            return Loading();
          }),
    );
  }
}
