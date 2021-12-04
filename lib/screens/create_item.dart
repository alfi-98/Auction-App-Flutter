import 'package:auction_app/screens/dashBoard.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snack.dart';

class CreateItem extends StatefulWidget {
  static String id = 'create_item';
  const CreateItem({Key? key}) : super(key: key);

  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  int currentStep = 0;
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;

  late String productName;
  late String productDes;
  late String productPhoto;
  late String minBidPrice;
  late String endTime;
  bool isCompleted = false;

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedInUser = user;
      _firestore.collection('posts').add({
        'productName': productName,
        'productDescription': productDes,
        'productPhoto': productPhoto,
        'minBid': minBidPrice,
        'userName': loggedInUser.displayName
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: AppBar(
        title: Text("Create A Post"),
        centerTitle: true,
      ),
      body: Stepper(
        type: StepperType.vertical,
        steps: getSteps(),
        currentStep: currentStep,
        onStepContinue: () {
          final isLastStep = currentStep == getSteps().length - 1;

          if (isLastStep) {
            setState(() {
              getCurrentUser();
            });

            Navigator.pushNamed(context, HomePage.id);
            print('Completed');

            // You can connect here with FireBase
            Get.snackbar(
              "Item Posted",
              "You Have Successfully Added an Item for Auction",
              snackPosition: SnackPosition.TOP,
            );
          } else {
            setState(() => currentStep += 1);
          }
        },
        onStepCancel: () => setState(() => currentStep -= 1),
        controlsBuilder: (context, {onStepContinue, onStepCancel}) {
          return Container(
            margin: EdgeInsets.only(top: 50),
            child: Row(children: [
              Expanded(
                child: ElevatedButton(
                  child: Text('Continue'),
                  onPressed: onStepContinue,
                ),
              ),
              const SizedBox(width: 12),
              if (currentStep != 0)
                Expanded(
                  child: ElevatedButton(
                    child: Text('Back'),
                    onPressed: onStepCancel,
                  ),
                ),
            ]),
          );
        },
      ),
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

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text("Product Information",
              style: TextStyle(color: Colors.white)),
          content: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) {
                  productName = value;
                },
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                onChanged: (value) {
                  productDes = value;
                },
                decoration: InputDecoration(labelText: 'Product Description'),
              )
            ],
          ),
        ),
        Step(
          state: currentStep > 1 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 1,
          title: Text("Product Photo", style: TextStyle(color: Colors.white)),
          content: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) {
                  productPhoto = value;
                },
                decoration: InputDecoration(labelText: 'Product Photo'),
              ),
            ],
          ),
        ),
        Step(
          state: currentStep > 2 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 2,
          title:
              Text("Biding Information", style: TextStyle(color: Colors.white)),
          content: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (value) {
                  minBidPrice = value;
                },
                decoration: InputDecoration(labelText: ' Minimum Bid Price'),
              ),
              TextFormField(
                onChanged: (value) {
                  endTime = value;
                },
                decoration: InputDecoration(labelText: 'Auction End DateTime'),
              )
            ],
          ),
        ),
      ];
}
