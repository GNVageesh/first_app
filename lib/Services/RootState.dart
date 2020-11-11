import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home.dart';
import '../login.dart';
import 'Authentication.dart';

class RootState extends StatefulWidget {
  @override
  _RootStateState createState() => _RootStateState();
}

class _RootStateState extends State<RootState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth(auth: _auth).user,
      builder: (BuildContext context,
          AsyncSnapshot<User> snapshot) {
        if(snapshot.connectionState == ConnectionState.active) {
          if(snapshot.data?.uid == null) {
            return LoginUI(
              auth: _auth,
              firestore: _firestore,
            );
          } else {
            return HomeScreen(
              auth: _auth,
              firestore: _firestore,
            );
          }
        }
        else {
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        }
      },
    );
  }
}
