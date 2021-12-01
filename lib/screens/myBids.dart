import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/dashBoard.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:flutter/material.dart';

class MyBids extends StatefulWidget {
  static String id = 'my_bids';
  const MyBids({Key? key}) : super(key: key);

  @override
  _MyBids createState() => _MyBids();
}

class _MyBids extends State<MyBids> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
