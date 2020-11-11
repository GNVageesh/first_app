import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app/Services/Authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginUI extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  const LoginUI({
    Key key,
    @required this.auth,
    @required this.firestore,
  }) : super(key: key);
  @override
  _LoginUIState createState() => _LoginUIState();
}

class _LoginUIState extends State<LoginUI> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(60),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextFormField(
            textAlign: TextAlign.center,
            controller: _email,
            decoration: InputDecoration(hintText: "Email...."),
          ),
          TextFormField(
            textAlign: TextAlign.center,
            controller: _password,
            obscureText: true,
            decoration: InputDecoration(hintText: "Password...."),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RaisedButton(
                child: Text("Login"),
                onPressed: () async {
                  final String value = await Auth(auth: widget.auth)
                      .signIn(email: _email.text, password: _password.text);
                  if (value == "") {
                    _email.clear();
                    _password.clear();
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(value),
                    ));
                  }
                },
              ),
              RaisedButton(
                  child: Text("Register"),
                onPressed: () async {
                  final String value = await Auth(
                      auth: widget.auth, firestore: widget.firestore)
                      .createUser(
                      email: _email.text,
                      password: _password.text);
                  if (value == "") {
                    _email.clear();
                    _password.clear();
                  } else {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text(value),
                    ));
                  }
                },)
            ],
          )
        ]),
      ),
    ));
  }
}
