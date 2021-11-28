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
        color: Color(0xFF28282B),
        borderRadius:
            isDrawerOpen ? BorderRadius.circular(40) : BorderRadius.circular(0),
      ),
      child: SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xFF28282B),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Text(
                      'Auction Gallery',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.none),
                    ),
                    Container()
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
