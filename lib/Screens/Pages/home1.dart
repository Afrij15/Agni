import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/Profile_Pages/cart.dart';
import 'package:wasthu/Profile_Pages/notification.dart';
import 'package:wasthu/Screens/Pages/search.dart';
import 'package:wasthu/shared/loading.dart';

class Home1 extends StatelessWidget {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Search()),
                          );
                        },
                        child: Row(
                          children: [
                            Icon(Icons.search),
                            SizedBox(),
                            Text(
                              'Search',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 15),
                            )
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shape: StadiumBorder(),
                            primary: Colors.pink[200]),
                      ),
                    ),
                    IconButton(
                      color: Colors.pink[300],
                      icon: const Icon(Icons.notifications),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Notifications(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      color: Colors.pink[300],
                      icon: const Icon(Icons.shopping_bag),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Cart(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              CarouselSlider(
                items: [
                  //1st Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage("assets/Car1.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  //2nd Image of Slider
                  Container(
                    margin: EdgeInsets.all(6.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: AssetImage("assets/Car2.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],

                //Slider Container properties
                options: CarouselOptions(
                  height: 180.0,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
              SizedBox(
                height: 8.0,
              ),
              //Latest Arrivals Card Section
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 8.0),
                child: Text(
                  "Latest Arrivals",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.pink[500],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 190,
                child: StreamBuilder(
                    stream: collectionReference.snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: EdgeInsets.only(left: 16, right: 6),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final e = snapshot.data!.docs[index];

                              return Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 199,
                                width: 344,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Positioned(
                                        child: Image(
                                          image: AssetImage(
                                            'assets/item1.png',
                                          ),
                                          height: 200,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      top: 10,
                                      child: Text(
                                        e['name'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 25,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Positioned(
                                      right: 50,
                                      top: 85,
                                      child: Container(
                                        padding: EdgeInsets.all(8.0),
                                        color: Colors.pink[300],
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 20,
                                      bottom: 10,
                                      child: Text(
                                        e['price'],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 30,
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ],
                                ),
                              );

                              //    return Center(child: Text('hi'));
                            });
                      }
                      return Center(child: Text('Empty'));
                    }),
              ),
              //Top Trending Card Section
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 8.0),
                child: Text(
                  " Top Trending ",
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: Colors.pink[500],
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                height: 190,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: 16, right: 6),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(right: 10),
                          height: 199,
                          width: 344,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Positioned(
                                  child: Image(
                                    image: AssetImage(
                                      'assets/item2.png',
                                    ),
                                    height: 200,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 20,
                                top: 10,
                                child: Text(
                                  'Ladies Top',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                right: 50,
                                top: 85,
                                child: Container(
                                  padding: EdgeInsets.all(8.0),
                                  color: Colors.pink[300],
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 20,
                                bottom: 10,
                                child: Text(
                                  'Rs.3500',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 30,
                                      fontFamily: 'Poppins'),
                                ),
                              ),
                            ],
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _renderCard(String name, String price, String image) {
    return Card(
      child: Column(
        children: [
          Image(
            image: AssetImage('assets/Car1.jpeg'),
            width: double.infinity,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            'Calvin Frock',
            style: TextStyle(
                color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Rs.4500',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
