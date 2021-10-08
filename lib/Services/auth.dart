import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wasthu/Services/firebase.dart';
import 'package:wasthu/Services/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

//create userobject based on firebase user
  Userid? _userFromFirebaseUser(User? user) {
    return user != null ? Userid(uid: user.uid) : null;
  }

// auth change user stream
  Stream<Userid?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      //create new document for the user
      await DatabaseService(
        uid: user!.uid,
      ).updateUserData('null', email, 'null', 'null');
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> getCurrentUID() async {
    final User user = await _auth.currentUser!;
    final String uid = user.uid;
    return uid;
  }
}
