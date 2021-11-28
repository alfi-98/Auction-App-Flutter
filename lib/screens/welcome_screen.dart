import 'package:auction_app/screens/auctionGallery.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    //GoogleSignInAccount? _currentUser;
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Scaffold(
      backgroundColor: Color(0xFF28282B),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(35),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Image.asset('images/buy.png'),
                    height: 60.0,
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    'Auction App',
                    style: TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            SizedBox(
              height: 8.0,
            ),
            SizedBox(
              height: 24.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
                elevation: 10.0,
                child: MaterialButton(
                  onPressed: user != null
                      ? null
                      : () async {
                          await _googleSignIn.signIn();
                          setState(() {});
                          Navigator.pushNamed(context, HomePage.id);
                        },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
