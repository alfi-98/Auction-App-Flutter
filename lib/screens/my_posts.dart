import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/dashBoard.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyPosts extends StatefulWidget {
  static String id = 'my_posts';
  const MyPosts({Key? key}) : super(key: key);

  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Posts"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user-posts")
              .doc(_auth.currentUser!.email)
              .collection('posts')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.data!.docs.isEmpty) {
              return Center(child: Center(child: Text("No Posts Yet")));
            }

            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (_, index) {
                  DocumentSnapshot _documentSnapshot =
                      snapshot.data!.docs[index];

                  final minBid = _documentSnapshot['minBid'];
                  final description = _documentSnapshot['productDescription'];
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
                                "\$$minBid",
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
                                        print('object');
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
                });
          },
        ),
      ),
      backgroundColor: Color(0xFF202020),
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
}
