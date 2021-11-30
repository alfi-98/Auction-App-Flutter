import 'package:auction_app/main.dart';
import 'package:auction_app/screens/auctionGallery.dart';
import 'package:auction_app/screens/home_page.dart';
import 'package:auction_app/screens/my_posts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateItem extends StatefulWidget {
  static String id = 'create_item';
  const CreateItem({Key? key}) : super(key: key);

  @override
  _CreateItemState createState() => _CreateItemState();
}

class _CreateItemState extends State<CreateItem> {
  int currentStep = 0;
  final productName = TextEditingController();
  final productDes = TextEditingController();
  final productPhoto = TextEditingController();
  final minBidPrice = TextEditingController();
  final endTime = TextEditingController();
  bool isCompleted = false;
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
              AlertDialog();
            });

            // CupertinoAlertDialog(
            //   title: Text('Confirm Posting?'),
            //   actions: <CupertinoDialogAction>[
            //     CupertinoDialogAction(
            //       child: const Text('No'),
            //       onPressed: () {
            //         Navigator.pop(context);
            //       },
            //     ),
            //     CupertinoDialogAction(
            //       child: const Text('Yes'),
            //       isDestructiveAction: true,
            //       onPressed: () {
            //         // Do something destructive.
            //       },
            //     )
            //   ],
            // );
            Navigator.pushNamed(context, HomePage.id);
            print('Completed');

            // You can connect here with FireBase

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
                  Navigator.pushNamed(context, MyPosts.id);
                },
                icon: Icon(Icons.account_circle_rounded),
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
                controller: productName,
                decoration: InputDecoration(labelText: 'Product Name'),
              ),
              TextFormField(
                controller: productDes,
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
                controller: productPhoto,
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
                controller: minBidPrice,
                decoration: InputDecoration(labelText: ' Minimum Bid Price'),
              ),
              TextFormField(
                controller: endTime,
                decoration: InputDecoration(labelText: 'Auction End DateTime'),
              )
            ],
          ),
        ),
      ];
}
