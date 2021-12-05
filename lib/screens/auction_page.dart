// import 'package:auction_app/screens/home_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:get/get_navigation/src/snackbar/snack.dart';

// class AuctionPage extends StatefulWidget {
//   static String id = 'auction_page';

//   @override
//   _AuctionPage createState() => _AuctionPage();
// }

// class _AuctionPage extends State<AuctionPage> {
//   CollectionReference _firebaseFirestore =
//       FirebaseFirestore.instance.collection("posts");
//   final _firestore = FirebaseFirestore.instance;
//   final _auth = FirebaseAuth.instance;
//   late User loggedInUser;

//   DateTime now = DateTime.now();

//   var heading = '\$23';
//   var subheading = 'time : ';
//   var cardImage =
//       NetworkImage('https://source.unsplash.com/random/800x600?house');
//   var supportingText = 'Product Description......';

//   List<Widget> itemsData = [];

//   late TextEditingController controller;
//   String bid = '';
//   String postId = '';

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   // void getPostsData() {

//   //   List<Widget> listItems = [];
//   //   responseList.forEach((post) {
//   //     listItems.add(Container(
//   //         height: 100,
//   //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//   //         decoration: BoxDecoration(
//   //             borderRadius: BorderRadius.all(Radius.circular(20.0)),
//   //             color: Colors.black,
//   //             boxShadow: [
//   //               BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
//   //             ]),
//   //         child: Padding(
//   //           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
//   //           child: Row(
//   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //             children: <Widget>[
//   //               Column(
//   //                 crossAxisAlignment: CrossAxisAlignment.start,
//   //                 children: <Widget>[
//   //                   Text(
//   //                     post["name"],
//   //                     style: const TextStyle(
//   //                         fontSize: 28,
//   //                         fontWeight: FontWeight.bold,
//   //                         color: Colors.white),
//   //                   ),
//   //                   Text(
//   //                     post["time"],
//   //                     style: const TextStyle(fontSize: 17, color: Colors.grey),
//   //                   ),
//   //                   SizedBox(
//   //                     height: 10,
//   //                   ),
//   //                 ],
//   //               ),
//   //               Text(
//   //                 "\$ ${post["price"]}",
//   //                 style: const TextStyle(
//   //                     fontSize: 25,
//   //                     color: Colors.white,
//   //                     fontWeight: FontWeight.bold),
//   //               )
//   //               // Container(
//   //               //   width: 10,
//   //               //   height: 10,
//   //               //   decoration: BoxDecoration(
//   //               //     shape: BoxShape.circle,
//   //               //     image: DecorationImage(
//   //               //         image: AssetImage('images/${post["image"]}'),
//   //               //         fit: BoxFit.fill),
//   //               //   ),
//   //               // )
//   //             ],
//   //           ),
//   //         )));
//   //   });
//   //   setState(() {
//   //     itemsData = listItems;
//   //   });
//   // }

//   @override
//   void initState() {
//     super.initState();
//     // getPostsData();
//     getPostId();
//     controller = TextEditingController();
//   }

//   void getCurrentUser() async {
//     try {
//       final user = _auth.currentUser!;
//       loggedInUser = user;

//       print(loggedInUser.email);
//       // userName = loggedInUser.displayName!;
//       // userEmail = loggedInUser.email!;
//       _firestore.collection('posts').add({
//         'userName': loggedInUser.displayName,
//         'userEmail': loggedInUser.email,
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   @override
//   void getPostId() {}

//   @override
//   Widget build(BuildContext context) {
//     //final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: [
//           SingleChildScrollView(
//             // child: Container(
//             //   height: size.height,
//             physics: BouncingScrollPhysics(),
//             scrollDirection: Axis.vertical,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(20),
//                   decoration: BoxDecoration(
//                     color: Colors.green[500],
//                     image: DecorationImage(
//                       image: NetworkImage(
//                           'https://source.unsplash.com/random/800x600?house'),
//                       fit: BoxFit.cover,
//                     ),
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(40),
//                         bottomRight: Radius.circular(40)),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           IconButton(
//                               onPressed: () {
//                                 Navigator.pushNamed(context, HomePage.id);
//                               },
//                               icon: Icon(
//                                 Icons.arrow_back,
//                                 color: Colors.white,
//                               )),
//                           IconButton(
//                               onPressed: () {},
//                               icon: Icon(
//                                 Icons.search,
//                                 color: Colors.white,
//                               ))
//                         ],
//                       ),
//                       SizedBox(
//                         height: 200,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   height: 20,
//                                 ),
//                                 Container(
//                                   height: 50,
//                                   width: 100,
//                                   decoration: BoxDecoration(
//                                       borderRadius:
//                                           BorderRadius.all(Radius.circular(25)),
//                                       color: Colors.blue),
//                                   child: Center(
//                                     child: Text(heading,
//                                         style: TextStyle(
//                                             fontSize: 35,
//                                             color: Colors.white,
//                                             fontFamily: "mont",
//                                             fontWeight: FontWeight.bold)),
//                                   ),
//                                 ),
//                               ])
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 15,
//                 ),
//                 Container(
//                   height: 1000,
//                   padding: EdgeInsets.symmetric(horizontal: 10),
//                   child: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             supportingText,
//                             style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Divider(
//                         color: Colors.grey,
//                       ),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text(
//                             subheading,
//                             style: TextStyle(
//                                 fontSize: 23,
//                                 fontWeight: FontWeight.w700,
//                                 color: Colors.white),
//                           ),
//                           SizedBox(
//                             width: 40,
//                           ),
//                           InkWell(
//                             onTap: () async {
//                               final bidAmount = await openBid();
//                               if (bidAmount == null || bidAmount.isEmpty) {
//                                 return;
//                               } else {
//                                 setState(() => this.bid = bidAmount);
//                                 Get.snackbar(
//                                   "Bid Placed",
//                                   "You Have Successfully Placed a Bid",
//                                   snackPosition: SnackPosition.TOP,
//                                 );
//                               }
//                             },
//                             child: Container(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 30, vertical: 10),
//                               decoration: BoxDecoration(
//                                   borderRadius:
//                                       BorderRadius.all(Radius.circular(25)),
//                                   color: Colors.green),
//                               child: Center(
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       "Place a Bid!",
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.w700),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Divider(
//                         color: Colors.grey,
//                       ),
//                       Expanded(
//                         child: SingleChildScrollView(
//                           physics: ClampingScrollPhysics(),
//                           // itemCount: itemsData.length,
//                           // itemBuilder: (context, index) {
//                           //   return itemsData[index];
//                           // }),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future<String?> openBid() => showDialog<String>(
//       context: context,
//       builder: (context) => AlertDialog(
//             title: Text("Place a Bid"),
//             content: TextField(
//               autofocus: true,
//               decoration: InputDecoration(
//                 hintText: 'biding amount',
//               ),
//               controller: controller,
//             ),
//             actions: [
//               TextButton(
//                 onPressed: submit,
//                 child: Text('Submit'),
//               ),
//             ],
//           ));

//   void submit() {
//     Navigator.of(context).pop(controller.text);
//   }
// }
