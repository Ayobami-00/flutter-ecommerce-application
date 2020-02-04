import 'package:cloud_firestore_all/cloud_firestore_all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_application/commons/loading.dart';
import 'package:flutter_ecommerce_application/pages/signup.dart';
import 'package:flutter_ecommerce_application/provider/provider.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    return Scaffold(
      key: _key,
      body: user.status== Status.Authenticating ? Loading() : Stack(
        children: <Widget>[
          Image.asset(
            'images/back.jpg',
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
              alignment: Alignment.topCenter,
              child: Image.asset('images/logo.png')),
          Container(
            color: Colors.black.withOpacity(0.4),
            width: double.infinity,
            height: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 300.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Email",
                                icon: Icon(Icons.alternate_email),
                              ),
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 8.0),
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.8),
                        elevation: 0.0,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                          child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Password",
                                icon: Icon(Icons.lock_outline),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              controller: _passwordTextController,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return "The password filed cannot be empty";
                                } else if (value.length < 6) {
                                  return "The password has to be at least 6 characters long";
                                }
                                return null;
                              }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
                      child: Material(
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red.shade700,
                          elevation: 0.0,
                          child: MaterialButton(
                            onPressed: () async{
                              if(_formKey.currentState.validate()){
                                if(!await user.SignIn(_emailTextController.text,_passwordTextController.text))
                                  _key.currentState.showSnackBar(SnackBar(content: Text("Sign in failed")));
                              }
                              
                            },
                            minWidth: MediaQuery.of(context).size.width,
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22.0,
                              ),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Forgot password",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp()));
                          } ,
                          child: Text("Sign up", style:TextStyle(color: Colors.red)))
                      ),
                    )
                  ],
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
      // bottomNavigationBar: Container(
      //   child: Padding(
      //     padding: const EdgeInsets.only(
      //         left: 12.0, right: 12.0, top: 8.0, bottom: 8.0),
      //     child: FlatButton(
      //       color: Colors.red.shade900,
      //       onPressed: () {
      //         Navigator.pushReplacement(
      //             context, MaterialPageRoute(builder: (context) => HomePage()));
      //       },
      //       child: Text(
      //         "Sign in / Sign up with google",
      //         style: TextStyle(color: Colors.white),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
