import 'package:auction_app/screens/auctionGallery.dart';
import 'package:auction_app/sideBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static String id = 'home_page';

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  // final _auth = FirebaseAuth.instance;
  // late User loggedInUser;

  // void initState() {
  //   super.initState();

  //   getCurrentUser();
  // }

  // void getCurrentUser() async {
  //   try {
  //     final user = await _auth.currentUser!;
  //     if (user != null) {
  //       loggedInUser = user;
  //       print(loggedInUser.email);
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

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
