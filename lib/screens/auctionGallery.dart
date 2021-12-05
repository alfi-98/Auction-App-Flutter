
import 'package:auction_app/itemCard.dart';
import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/dashBoard.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';

class AuctionGallery extends StatefulWidget {
  static String id = 'auction_gallery';
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
                        width: 90,
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
                //FetchPosts(),
                ItemCard(),
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
                          Navigator.pushNamed(context, DashBoard.id);
                        },
                        icon: Icon(Icons.dashboard),
                        color: Colors.white),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
