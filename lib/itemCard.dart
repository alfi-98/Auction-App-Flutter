import 'dart:math';

import 'package:auction_app/screens/auction_page.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatefulWidget {
  const ItemCard({Key? key}) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
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
                        onPressed: () {
                          Navigator.pushNamed(context, AuctionPage.id);
                        },
                      )
                    ],
                  ),
                ),
              ])),
            ],
          ),
        ));
  }
}
