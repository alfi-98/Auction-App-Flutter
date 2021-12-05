import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class DashBoard extends StatefulWidget {
  static String id = 'dashboard';
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  late int totalPosts = 0;
  late int totalBids = 0;
  late int bidsCompleted = 0;
  late int totalValue = 0;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _random = new Random();
    print(MediaQuery.of(context).size.width);

    return Scaffold(
        backgroundColor: Color(0xFF121212),
        appBar: AppBar(
          title: Text("DashBoard"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 380,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 150,
                                height: 70,
                                child: Text(
                                  'Total Posts',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 100,
                                height: 55,
                                child: Text(
                                  totalPosts.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFcc2200),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 380,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 150,
                                height: 70,
                                child: Text(
                                  'Total Bids Running',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 100,
                                height: 55,
                                child: Text(
                                  totalBids.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blueAccent),
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 380,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 150,
                                height: 70,
                                child: Text(
                                  'Total Bids Completed',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 100,
                                height: 55,
                                child: Text(
                                  bidsCompleted.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.blueAccent),

                        // color: Colors.primaries[
                        //         _random.nextInt(Colors.primaries.length)]
                        //     [_random.nextInt(9) * 100],
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 380,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 150,
                                height: 70,
                                child: Text(
                                  'Total Value',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: 100,
                                height: 55,
                                child: Text(
                                  totalValue.toString(),
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xFFa21146),
                      ),
                    ),
                  )
                ]),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Color(0xFF28282B),
          child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
        ));
  }

  getData() async {
    final user = _auth.currentUser;
    loggedInUser = user!;
    QuerySnapshot totalPs = await _firestore.collection('gallery_posts').get();
    QuerySnapshot totalB = await _firestore.collection('Bids').get();
    setState(() {
      totalPosts = totalPs.size;
      totalBids = totalB.size;

      for (int i = 0; i < totalB.docs.length; i++) {
        totalValue = totalValue + int.parse(totalB.docs[i]["bidAmount"]);
      }
    });
  }
}
