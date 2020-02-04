import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_application/screens/home.dart';
import 'package:flutter_ecommerce_application/screens/login.dart';
import 'package:flutter_ecommerce_application/screens/splash.dart';
import 'package:flutter_ecommerce_application/provider/user_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (_) => UserProvider.initialize(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red.shade900,
        ),
        home: ScreenController(),
      )));
}


class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Uninialized:
      return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return Login();
      case Status.Authenticated:
       return HomePage();  
      default: return Login();
      
    }
  }
}


