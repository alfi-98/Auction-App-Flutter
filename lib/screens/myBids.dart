import 'dart:math';

import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/dashBoard.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyBids extends StatefulWidget {
  static String id = 'my_bids';
  const MyBids({Key? key}) : super(key: key);

  @override
  _MyBids createState() => _MyBids();
}

class _MyBids extends State<MyBids> {
  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  var _random = new Random();
  List _bidList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    print(loggedInUser.displayName);
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("My Bids"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(
            height: 20,
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: _bidList.length,
              itemBuilder: (_, index) {
                final String productName = _bidList[index]["productName"];
                final String bidPlaced = _bidList[index]["bidAmount"];

                return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.pink[900],
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 150,
                              height: 55,
                              child: Text(
                                productName,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: 100,
                              height: 55,
                              child: Text(
                                "\$ $bidPlaced",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ));
              })
        ]),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Color(0xFF121212),
        child: Container(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HomePage.id);
              },
              icon: Icon(Icons.home),
              color: Colors.white,
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, CreateItem.id);
                },
                icon: Icon(Icons.add),
                color: Colors.white),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, DashBoard.id);
                },
                icon: Icon(Icons.dashboard),
                color: Colors.white),
          ]),
        ),
      ),
    );
  }

  getData() async {
    final user = _auth.currentUser;
    loggedInUser = user!;
    QuerySnapshot qn = await _firestore.collection('Bids').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (loggedInUser.displayName == qn.docs[i]["userName"])
          _bidList.add({
            "bidAmount": qn.docs[i]["bidAmount"],
            "productName": qn.docs[i]["productName"]
          });
      }
    });
  }
}
