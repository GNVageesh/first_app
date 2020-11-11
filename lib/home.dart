import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Services/Authentication.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  HomeScreen({Key key, this.auth, this.firestore}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String email = FirebaseAuth.instance.currentUser.email.toString();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("FlutterFire"),
          centerTitle: true,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                Text("Welcome", style: TextStyle(fontSize: 30, color: Colors.lightBlue),),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: Text("Welcome", style: TextStyle(fontSize: 22, color: Colors.yellow),),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 14),
                  child: RaisedButton(
                    child: Icon(Icons.exit_to_app),
                    onPressed: () {
                      Auth(auth: widget.auth).signOut();
                    }
                  )
                ),
              ],
            ),
          ),
        ),
      );
  }
}
