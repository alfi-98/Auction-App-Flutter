import 'package:auction_app/screens/create_item.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:flutter/material.dart';

class MyPosts extends StatefulWidget {
  static String id = 'my_posts';
  const MyPosts({Key? key}) : super(key: key);

  @override
  _MyPostsState createState() => _MyPostsState();
}

class _MyPostsState extends State<MyPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                        Navigator.pushNamed(context, MyPosts.id);
                      },
                      icon: Icon(Icons.account_circle_rounded),
                      color: Colors.white),
                ]),
          ),
        ));
  }
}
