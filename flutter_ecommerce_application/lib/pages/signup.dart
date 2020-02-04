import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_application/commons/common.dart';
import 'package:flutter_ecommerce_application/commons/loading.dart';
import 'package:flutter_ecommerce_application/db/auth.dart';
import 'package:flutter_ecommerce_application/pages/home.dart';
import 'package:flutter_ecommerce_application/provider/provider.dart';
import 'package:provider/provider.dart';
import '../db/users.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  UserServices _userServices = UserServices();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController =
      TextEditingController();
  TextEditingController _nameTextController = TextEditingController();
  bool loading = false;
  String gender;
  String groupValue = "male";
  bool hidePass = true;
  Auth auth = Auth();
  @override
  Widget build(BuildContext context) {
  final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status== Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 120.0,bottom: 120.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                    BoxShadow(
                      color: Colors.grey[350],
                      blurRadius: 20.0,
                    )],
                  ),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Container(
                            alignment: Alignment.topCenter,
                            child: Image.asset(
                              'images/logo.png',
                              width: 200.0,
                              fit: BoxFit.fill,
                            ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.4),
                            elevation: 0.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: ListTile(
                                title: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Full name",
                                        icon: Icon(Icons.person_outline),
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _nameTextController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "The name filed cannot be empty";
                                      }
                                      return null;
                                    }),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 8.0),
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "Male",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    trailing: Radio(
                                        value: "male",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e)),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      "Female",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    trailing: Radio(
                                        value: "female",
                                        groupValue: groupValue,
                                        onChanged: (e) => valueChanged(e)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.8),
                            elevation: 0.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: ListTile(
                                title: TextFormField(
                                    decoration: InputDecoration(
                                        hintText: "Email",
                                        icon: Icon(Icons.alternate_email),
                                        border: InputBorder.none),
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailTextController,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        Pattern pattern =
                                            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                        RegExp regex = RegExp(pattern);
                                        if (!regex.hasMatch(value))
                                          return "Please make sure your email address is valid";
                                        else
                                          return null;
                                      }
                                    }),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.grey.withOpacity(0.8),
                            elevation: 0.0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                              child: ListTile(
                                  title: TextFormField(
                                      decoration: InputDecoration(
                                          hintText: "Password",
                                          icon: Icon(Icons.lock_outline),
                                          border: InputBorder.none),
                                      keyboardType: TextInputType.emailAddress,
                                      controller: _passwordTextController,
                                      obscureText: hidePass,
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "The password filed cannot be empty";
                                        } else if (value.length < 6) {
                                          return "The password has to be at least 6 characters long";
                                        }
                                        return null;
                                      }),
                                  trailing: IconButton(
                                    icon: Icon(Icons.remove_red_eye),
                                    onPressed: () {
                                      setState(() {
                                        hidePass = false;
                                      });
                                    },
                                  )),
                            ),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                        //   child: Material(
                        //     borderRadius: BorderRadius.circular(10.0),
                        //     color: Colors.white.withOpacity(0.8),
                        //     elevation: 0.0,
                        //     child: Padding(
                        //       padding:
                        //           const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                        //       child: ListTile(
                        //           title: TextFormField(
                        //               decoration: InputDecoration(
                        //                   hintText: "Confirm password",
                        //                   icon: Icon(Icons.lock_outline),
                        //                   border: InputBorder.none),
                        //               keyboardType: TextInputType.emailAddress,
                        //               controller: _confirmPasswordTextController,
                        //               obscureText: hidePass,
                        //               validator: (value) {
                        //                 if (value.isEmpty) {
                        //                   return "The password filed cannot be empty";
                        //                 } else if (value.length < 6) {
                        //                   return "The password has to be at least 6 characters long";
                        //                 } else if (_passwordTextController.text !=
                        //                     value) {
                        //                   return "The passwords do not match";
                        //                 }
                        //                 return null;
                        //               }),
                        //           trailing: IconButton(
                        //             icon: Icon(Icons.remove_red_eye),
                        //             onPressed: () {
                        //               setState(() {
                        //                 hidePass = false;
                        //               });
                        //             },
                        //           )),
                        //     ),
                        //   ),
                        // ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: Material(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.red.shade700,
                              elevation: 0.0,
                              child: MaterialButton(
                                onPressed: () async{
                              if(_formKey.currentState.validate()){
                                if(!await user.SignUp(_nameTextController.text,_emailTextController.text,_passwordTextController.text))
                                  _key.currentState.showSnackBar(SnackBar(content: Text("Sign up failed")));
                              }
                              
                            },
                                minWidth: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Sign Up",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                              )),
                        ),
                        Center(
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "I already have an account",
                                    style: TextStyle(
                                        color: Colors.deepOrange, fontSize: 16),
                                    textAlign: TextAlign.center,
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Or sign Up with",
                                  style:
                                      TextStyle(fontSize: 18, color: Colors.grey),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                    onPressed: () async{
                                      FirebaseUser user = await auth.googleSignIn();
                                      if(user == null){
                                        _userServices.createUser(
                                          {
                                            "name": user.displayName,
                                            "photo": user.photoUrl,
                                            "email": user.email,
                                            "userId": user.uid
                                          });
                                          changeScreenReplacement(context, HomePage());
                                      }
                                    },
                                    child: Image.asset(
                                      "images/ggg.png",
                                      width: 30,
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            
            ),
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
      
    );
  }

  valueChanged(e) {
    setState(() {
      if (e == 'male') {
        groupValue = e;
        gender = e;
      } else if (e == "female") {
        groupValue = e;
        gender = e;
      }
    });
  }

}
