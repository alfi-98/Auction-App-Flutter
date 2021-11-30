import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:auction_app/screens/my_posts.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AuctionGallery extends StatefulWidget {
  const AuctionGallery({Key? key}) : super(key: key);

  @override
  _AuctionGallery createState() => _AuctionGallery();
}

class _AuctionGallery extends State<AuctionGallery> {
  double xOffset = 0;
  double yOffset = 0;
  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(isDrawerOpen ? 0.90 : 1.00),
      //..rotateZ(isDrawerOpen ? pi / 20 : 0),
      decoration: BoxDecoration(
        color: Color(0xFF121212),
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: SafeArea(
        child: Scaffold(
            backgroundColor: Color(0xFF121212),
            body: SingleChildScrollView(
              clipBehavior: Clip.hardEdge,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          child: Icon(Icons.menu),
                          onTap: () {
                            if (isDrawerOpen) {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                isDrawerOpen = false;
                              });
                            } else {
                              setState(() {
                                xOffset = size.width - 120;
                                yOffset = size.height / 5;
                                isDrawerOpen = true;
                              });
                            }
                          },
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Center(
                          child: Text(
                            'Auction Gallery',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  itemCard(),
                  itemCard(),
                  itemCard(),
                  itemCard(),
                  itemCard(),
                  itemCard()
                ],
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              elevation: 0,
              color: Color(0xFF121212),
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
                            Navigator.pushNamed(context, MyPosts.id);
                          },
                          icon: Icon(Icons.account_circle_rounded),
                          color: Colors.white),
                    ]),
              ),
            )),
      ),
    );
  }
}

Card itemCard() {
  var heading = '\$23';
  var subheading = 'time : ';
  var cardImage =
      NetworkImage('https://source.unsplash.com/random/800x600?house');
  var supportingText = 'Product Description......';
  final _random = Random();
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
                heading,
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'sans-serif',
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                subheading,
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
                  supportingText,
                  style: TextStyle(
                      fontFamily: 'sans-serif', fontWeight: FontWeight.bold),
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
                      onPressed: () {/* ... */},
                    )
                  ],
                ),
              ),
            ])),
          ],
        ),
      ));
}
