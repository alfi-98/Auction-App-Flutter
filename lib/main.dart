import 'package:auction_app/screens/auctionGallery.dart';
import 'package:auction_app/screens/auction_page.dart';
import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/dashBoard.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:auction_app/screens/myBids.dart';
import 'package:auction_app/screens/my_posts.dart';
import 'package:auction_app/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.black54),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        HomePage.id: (context) => HomePage(),
        CreateItem.id: (context) => CreateItem(),
        MyPosts.id: (context) => MyPosts(),
        DashBoard.id: (context) => DashBoard(),
        MyBids.id: (context) => MyBids(),
        AuctionPage.id: (context) => AuctionPage(),
      },
    );
  }
}
