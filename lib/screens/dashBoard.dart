import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  static String id = 'dashboard';
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoard createState() => _DashBoard();
}

class _DashBoard extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
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
}
