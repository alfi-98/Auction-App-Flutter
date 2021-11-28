import 'package:auction_app/options_sidebar.dart';
import 'package:auction_app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  //GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Container(
      color: Colors.black,
      child: Padding(
        padding: EdgeInsets.only(top: 50, left: 40, bottom: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    radius: 80,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    //user!.displayName ?? ''
                    "",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    //user.email
                    "",
                    style: TextStyle(color: Colors.black, fontSize: 30),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  OptionBar(
                      icon: Icons.dashboard,
                      text: "dashboard",
                      onTap: () {},
                      sizeFont: 22),
                  SizedBox(
                    height: 50,
                  ),
                  OptionBar(
                      icon: Icons.home,
                      text: "Gallery",
                      onTap: () {},
                      sizeFont: 22),
                  SizedBox(
                    height: 50,
                  ),
                  OptionBar(
                      icon: Icons.account_circle_rounded,
                      text: "My post items",
                      onTap: () {},
                      sizeFont: 22),
                  SizedBox(
                    height: 50,
                  ),
                  OptionBar(
                      icon: Icons.account_circle_rounded,
                      text: "My post items",
                      onTap: () {},
                      sizeFont: 22),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}