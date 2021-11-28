import 'package:auction_app/screens/auctionGallery.dart';
import 'package:auction_app/sideBar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id = 'home_page';

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF28282B),
        body: Stack(
          children: [
            SideBar(),
            AuctionGallery(),
          ],
        ));
  }
}
