import 'package:auction_app/post_details.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  final itemSize = 100.0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  late User loggedInUser;

  DateTime now = DateTime.now();

  List _post = [];

  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      //physics: BouncingScrollPhysics(),
      //physics: const AlwaysScrollableScrollPhysics(),
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      // shrinkWrap: true,
      child: Column(
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _post.length,
              itemBuilder: (_, index) {
                final String minBidData = _post[index]["minBid"];
                final String description = _post[index]["productDescription"];
                // final String userName = _post[index]["userName"];
                DateTime now = DateTime.now();
                final String formattedDate =
                    DateFormat('yyyy-MM-dd – kk:mm').format(now);

                return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.all(30),
                    elevation: 6.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        // gradient: LinearGradient(
                        //   colors: [
                        //     Color(0xFF0d324d),
                        //     Color(0xFF7f5a83),
                        //   ],
                        //   begin: Alignment.topLeft,
                        //   end: Alignment.bottomRight,
                        // ),
                        //color: Colors.primaries[_random.nextInt(Colors.primaries.length)]
                        //  [_random.nextInt(9) * 100],
                        color: Color(0xFF7a6c62),
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
                              "Time : $formattedDate",
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
                                      'https://cdn.dribbble.com/users/2187949/screenshots/15647837/media/bb07b496fa56b9a95f88020ef018919c.png?compress=1&resize=400x300'),
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
                                //border: Border.all(color: Colors.grey),
                                color: Color(0xFF2e2e2e),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                ProductDetails(_post[index])),
                                      );

                                      // Navigator.pushNamed(
                                      //     context, AuctionPage.id);
                                    },
                                  )
                                ],
                              ),
                            ),
                          ])),
                        ],
                      ),
                    ));
              }),
        ],
      ),
    );
  }

  getData() async {
    QuerySnapshot qn = await _firestore.collection('gallery_posts').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        _post.add({
          "minBid": qn.docs[i]["minBid"],
          "productDescription": qn.docs[i]["productDescription"],
          "productName": qn.docs[i]["productName"],
          "productPhoto": qn.docs[i]["productPhoto"],
          "productID": qn.docs[i].id
          // "userName": qn.docs[i]["userName"],
        });
      }
    });
  }
}
