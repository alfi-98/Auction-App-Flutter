import 'dart:math';

import 'package:auction_app/screens/auction_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection("posts");

  late User loggedInUser;
  late String minBidData;
  //late String timeStamp;
  late String description;
  DateTime now = DateTime.now();

  List _post = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firebaseFirestore.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            print(snapshot.data);
            return SingleChildScrollView(
              //physics: const AlwaysScrollableScrollPhysics(),
              physics: ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              // shrinkWrap: true,
              child: Column(
                children: [
                  ...snapshot.data!.docs
                      .map((QueryDocumentSnapshot<Object?> data) {
                    minBidData = data.get('minBid');
                    description = data.get('productDescription');
                    //timeStamp = data.get('dateTime');

                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(30),
                        elevation: 6.0,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF0d324d),
                                Color(0xFF7f5a83),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            //color: Colors.primaries[_random.nextInt(Colors.primaries.length)]
                            //  [_random.nextInt(9) * 100],
                            color: Colors.black,
                          ),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "\$$minBidData",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'sans-serif',
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  "Time : ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'sans-serif',
                                      fontWeight: FontWeight.bold),
                                ),
                                trailing: Icon(Icons.bookmark_border_rounded),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    image: const DecorationImage(
                                      image: NetworkImage(
                                          'https://source.unsplash.com/random/800x600?house'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                    color: Colors.green,
                                  ),
                                  height: 200.0,
                                ),
                              ),
                              Container(
                                  child: Column(children: [
                                Container(
                                  padding: EdgeInsets.all(16.0),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    description,
                                    style: TextStyle(
                                        fontFamily: 'sans-serif',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(20)),
                                    color: Colors.white,
                                  ),
                                  child: ButtonBar(
                                    children: [
                                      TextButton(
                                        child: const Text(
                                          'Place a Bid!',
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: 'sans-serif',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, AuctionPage.id);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ])),
                            ],
                          ),
                        ));
                  })
                ],
              ),
            );
          }
        });
  }

  // void initState() {
  //   super.initState();
  //   getData();
  // }

  // void getData() async {
  //   try {
  //     final user = _auth.currentUser!;
  //     loggedInUser = user;
  //     StreamBuilder<QuerySnapshot>(
  //       stream: _firestore
  //           .collection('posts').doc(FirebaseAuth.instance.currentUser!.email)
  //           .snapshots(),
  //       builder: (BuildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (snapshot.hasData) {
  //           ...snapshot.data!.docs.map((QueryDocumentSnapshot<Object?> data){
  //           final dataB = snapshot.data!.docs;
  //           List<Text> cardWidget = [];
  //           for (var message in dataB) {
  //             minBidData = dataB.data['minBid'];
  //           }
  //           };
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  // var heading = '\$$minBidData';
  // var subheading = 'time : $now';
  // var cardImage =
  //     NetworkImage('https://source.unsplash.com/random/800x600?house');
  // var supportingText = description;
  // final _random = Random();
  //   return Card(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       ),
  //       margin: EdgeInsets.all(30),
  //       elevation: 6.0,
  //       child: Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           gradient: LinearGradient(
  //             colors: [
  //               Color(0xFF0d324d),
  //               Color(0xFF7f5a83),
  //             ],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //           //color: Colors.primaries[_random.nextInt(Colors.primaries.length)]
  //           //  [_random.nextInt(9) * 100],
  //           color: Colors.black,
  //         ),
  //         child: Column(
  //           children: [
  //             ListTile(
  //               title: Text(
  //                 heading,
  //                 style: TextStyle(
  //                     fontSize: 30,
  //                     fontFamily: 'sans-serif',
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               subtitle: Text(
  //                 subheading,
  //                 style: TextStyle(
  //                     fontSize: 20,
  //                     fontFamily: 'sans-serif',
  //                     fontWeight: FontWeight.bold),
  //               ),
  //               trailing: Icon(Icons.bookmark_border_rounded),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                   image: const DecorationImage(
  //                     image: NetworkImage(
  //                         'https://source.unsplash.com/random/800x600?house'),
  //                     fit: BoxFit.cover,
  //                   ),
  //                   borderRadius: BorderRadius.circular(10.0),
  //                   color: Colors.green,
  //                 ),
  //                 height: 200.0,
  //               ),
  //             ),
  //             Container(
  //                 child: Column(children: [
  //               Container(
  //                 padding: EdgeInsets.all(16.0),
  //                 alignment: Alignment.centerLeft,
  //                 child: Text(
  //                   supportingText,
  //                   style: TextStyle(
  //                       fontFamily: 'sans-serif', fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.only(
  //                       bottomRight: Radius.circular(20),
  //                       bottomLeft: Radius.circular(20)),
  //                   color: Colors.white,
  //                 ),
  //                 child: ButtonBar(
  //                   children: [
  //                     TextButton(
  //                       child: const Text(
  //                         'Place a Bid!',
  //                         style: TextStyle(
  //                             fontSize: 30,
  //                             fontFamily: 'sans-serif',
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       onPressed: () {
  //                         Navigator.pushNamed(context, AuctionPage.id);
  //                       },
  //                     )
  //                   ],
  //                 ),
  //               ),
  //             ])),
  //           ],
  //         ),
  //       ));
  // }

}
