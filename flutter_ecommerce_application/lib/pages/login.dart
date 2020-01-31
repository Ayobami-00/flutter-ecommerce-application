import 'package:cloud_firestore_all/cloud_firestore_all.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // SharedPreferences preferences;
  // bool loading = false;
  // bool isLogedin = false;

  // @override
  // void initState() {
  //   super.initState();
  //   isSignedIn();
  // }

  // void isSignedIn() async {
  //   setState(() {
  //     loading = true;
  //   });
  //   preferences = await SharedPreferences.getInstance();
  //   isLogedin = await googleSignIn.isSignedIn();
  //   if (isLogedin) {
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => HomePage()));
  //   }
  //   setState(() {
  //     loading = false;
  //   });
  // }

  // Future handleSignIn() async {
  //   preferences = await SharedPreferences.getInstance();

  //   setState(() {
  //     loading = true;
  //   });

  //   GoogleSignInAccount googleUser = await googleSignIn.signIn();
  //   GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleUser.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.getCredential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );

  //   final AuthResult authResult =
  //       await firebaseAuth.signInWithCredential(credential);
  //   final FirebaseUser firebaseUser = authResult.user;

  //   if(firebaseUser != null){
  //     final QuerySnapshot result = await Firestore.instance.collection("users").where("id",isEqualTo: firebaseUser.uid).getDocuments();
  //     final List<DocumentSnapshot> documents = result.documents;
  //     if(documents.length == 0){
  //       ///insert the user to our colection
  //     }
  //   }else{

  //   }
  // }
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/back.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            alignment: Alignment.topCenter,
            child: Image.asset('images/logo.png')
          ),
          Visibility(
              visible: loading ?? true,
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white.withOpacity(0.9),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                  ),
                ),
              ))
        ],
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
          child: FlatButton(
            color: Colors.red.shade900,
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: Text(
              "Sign in / Sign up with google",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
