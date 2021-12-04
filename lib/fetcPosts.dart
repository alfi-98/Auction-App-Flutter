import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FetchPosts extends StatefulWidget {
  const FetchPosts({Key? key}) : super(key: key);

  @override
  _FetchPosts createState() => _FetchPosts();
}

class _FetchPosts extends State<FetchPosts> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("posts").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Something is wrong"),
          );
        }

        return SizedBox(
          height: 400,
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data == null ? 0 : snapshot.data!.docs.length,
              itemBuilder: (_, index) {
                DocumentSnapshot _documentSnapshot = snapshot.data!.docs[index];

                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: Text(_documentSnapshot['productName']),
                    title: Text(
                      "\$ ${_documentSnapshot['minBid']}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    trailing: GestureDetector(
                      child: CircleAvatar(
                        child: Icon(Icons.remove_circle),
                      ),
                    ),
                  ),
                );
              }),
        );
      },
    );
  }
}
