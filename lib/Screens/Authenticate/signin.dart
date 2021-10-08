import 'package:flutter/material.dart';
import 'package:wasthu/Screens/Authenticate/signup.dart';
import 'package:wasthu/Services/auth.dart';
import 'package:wasthu/shared/constants.dart';
import 'package:wasthu/shared/loading.dart';

class Signin extends StatefulWidget {
  final Function toggleView;
  Signin({required this.toggleView});

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
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
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      //margin: const EdgeInsets.only(top: 100),
                      width: double.infinity,

                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
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
                                  child: Text("Welcome Back",
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
                                      val!.isEmpty ? 'Enter an Email' : null,
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
                                      dynamic res = await _auth
                                          .signInWithEmailAndPassword(
                                              email, password);
                                      print(res);
                                      if (res == null) {
                                        setState(() {
                                          error =
                                              'Username or Password is Wrong';
                                          loading = false;
                                        });
                                      }
                                    }
                                    /*\    dynamic res = await _auth.signInAnon();
                    
                              if (res == null) {
                                print("erro");
                              } else {
                                print("signed");
                                print(res.uid);
                              }*/
                                  },
                                  child: Text('Sign In'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                  child: Text(
                                    "Don't Have an Account? Sign Up",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.blue),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
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
