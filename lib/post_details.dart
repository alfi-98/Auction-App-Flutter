import 'package:auction_app/screens/auctionGallery.dart';
import 'package:flutter/material.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class ProductDetails extends StatefulWidget {
  var _post;
  ProductDetails(this._post);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _firestore = FirebaseFirestore.instance;

  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  late TextEditingController controller;
  String bid = '';
  String postId = '';
  List _bidList = [];

  //***************** */

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getData();
    //getCurrentUser();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    final String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);
    final String minBid = widget._post['minBid'];
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            // child: Container(
            //   height: size.height,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.green[500],
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://cdn.dribbble.com/users/2187949/screenshots/15647837/media/bb07b496fa56b9a95f88020ef018919c.png?compress=1&resize=400x300'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 200,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 60,
                                  width: 110,
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(25)),
                                      color: Colors.blue),
                                  child: Center(
                                    child: Text("\$$minBid",
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,
                                            fontFamily: "mont",
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ])
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 1000,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Time : $formattedDate",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                widget._post['productName'],
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget._post['productDescription'],
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          InkWell(
                            onTap: () async {
                              final bidAmount = await openBid();
                              if (bidAmount == null || bidAmount.isEmpty) {
                                return;
                              } else {
                                setState(() => this.bid = bidAmount);

                                final postId = widget._post['productID'];
                                final productName = widget._post['productName'];
                                final user = _auth.currentUser!;
                                loggedInUser = user;

                                _firestore.collection('Bids').add({
                                  'bidAmount': bid,
                                  'postId': postId,
                                  'userName': loggedInUser.displayName,
                                  'productName': productName
                                });

                                Get.snackbar(
                                  "Bid Placed",
                                  "You Have Successfully Placed a Bid",
                                  snackPosition: SnackPosition.TOP,
                                );
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            super.widget));
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 10),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  color: Colors.green),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Place a Bid!",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                            physics: ClampingScrollPhysics(),
                            child: Column(
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: _bidList.length,
                                    itemBuilder: (_, index) {
                                      final String name =
                                          _bidList[index]["userName"];
                                      final String bidPlaced =
                                          _bidList[index]["bidAmount"];

                                      return Card(
                                          elevation: 5,
                                          child: Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(10),
                                                  width: 100,
                                                  height: 55,
                                                  child: Text(
                                                    name,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ));
                                    })
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String?> openBid() => showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("Place a Bid"),
            content: TextField(
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'biding amount',
              ),
              controller: controller,
            ),
            actions: [
              TextButton(
                onPressed: submit,
                child: Text('Submit'),
              ),
            ],
          ));

  void submit() {
    Navigator.of(context).pop(controller.text);
  }

  getData() async {
    final postId = widget._post['productID'];
    QuerySnapshot qn = await _firestore.collection('Bids').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        if (postId == qn.docs[i]["postId"]) {
          _bidList.add({
            "bidAmount": qn.docs[i]["bidAmount"],
            "userName": qn.docs[i]["userName"],
          });
        } else {
          print("Not found");
          //elseCall();
        }
      }
    });
  }
}
