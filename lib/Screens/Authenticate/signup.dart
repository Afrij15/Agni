import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wasthu/Services/auth.dart';
import 'package:wasthu/shared/constants.dart';
import 'package:wasthu/shared/loading.dart';

class SignUp extends StatefulWidget {
  final Function toggleView;
  SignUp({required this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Accessing Customer Database
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('customer');

  //Accessing Firebase Auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();

  //Accessing FormField
  final _formKey = GlobalKey<FormState>();

  //Accessing Screenloading set to false
  bool loading = false;

  //text field
  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/bgimage.png'), fit: BoxFit.cover),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      //margin: const EdgeInsets.only(top: 100),
                      width: double.infinity,
                      height: 500,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                          color: Colors.white),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Text("Let's Start",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: 'Poppins',
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center),
                                ),
                                TextFormField(
                                  validator: (val) =>
                                      val!.isEmpty ? 'Enter a Name' : null,
                                  decoration: textInputDecorforAuth.copyWith(
                                      hintText: 'Name'),
                                  onChanged: (val) {
                                    setState(() => name = val);
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  validator: (val) => val!.isEmpty ||
                                          !val.contains(RegExp(
                                              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')) ||
                                          !val.contains(".com")
                                      ? 'Enter an Email'
                                      : null,
                                  decoration: textInputDecorforAuth.copyWith(
                                      hintText: 'Email'),
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                TextFormField(
                                  validator: (val) => val!.length < 8
                                      ? 'Password Minimum length is 8'
                                      : null,
                                  decoration: textInputDecorforAuth.copyWith(
                                      hintText: 'Password'),
                                  obscureText: true,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.orange[900],
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 10),
                                    textStyle: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      /*   dynamic res =
                                          _auth.registerWithEmailAndPassword(
                                              email, password);*/
                                      dynamic res = await _firebaseAuth
                                          .createUserWithEmailAndPassword(
                                              email: email, password: password)
                                          .then((value) => {
                                                FirebaseFirestore.instance
                                                    .collection('customer')
                                                    .doc(value.user!.uid)
                                                    .set({
                                                  "email": email,
                                                  "name": name,
                                                  "phone": '',
                                                  "address": ''
                                                })
                                              });
                                      if (res == null) {
                                        setState(() {
                                          error = 'Please Supply Valid Email';
                                          loading = false;
                                        });
                                      }
                                      /*  await collectionReference.add({
                                        'name': name,
                                        'email': email,
                                        'phone': '',
                                        'address': ''
                                      });*/
                                    }
                                  },
                                  child: Text('Sign Up'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                  child: Text(
                                    "Already Have an Account? Sign In",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  ),
                                ),
                                Image.asset(
                                  'assets/logo.png',
                                  height: 100,
                                  width: 100,
                                ),
                                Text(
                                  error,
                                  style: TextStyle(color: Colors.red),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
