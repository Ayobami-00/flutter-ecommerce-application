import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_ecommerce_application/db/users.dart';


enum Status{Uninialized, Authenticated, Authenticating, Unauthenticated}

class UserProvider with ChangeNotifier{
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninialized;
  Status get status => _status;
  FirebaseUser get user => _user;
  UserServices _userServices = UserServices();

  UserProvider.initialize(): _auth = FirebaseAuth.instance{
    _auth.onAuthStateChanged.listen(_onStateChanged);
      }
      Future<bool> SignIn(String email, String password)async{
         try{
        _status = Status.Authenticated;
        notifyListeners();
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        return true;
      }catch(e){
        _status = Status.Unauthenticated;
        notifyListeners();
        print(e.toString());
        return false;
      }
      }


      Future<bool> SignUp(String name,String email, String password)async{
         try{
        _status = Status.Authenticated;
        notifyListeners();
        await _auth.createUserWithEmailAndPassword(email: email, password: password).then((user){
          Map<String,dynamic> values = {
            "name": name,
            "email": email,
            "userId": user.user.uid,
          };
          _userServices.createUser(values);
        });
        return true;
      }catch(e){
        _status = Status.Unauthenticated;
        notifyListeners();
        print(e.toString());
        return false;
      }
      }

      Future signOut() async{
        _auth.signOut();
        _status = Status.Unauthenticated;
        notifyListeners();
        return Future.delayed(Duration.zero);
      }
        
     

      
    
      Future<void> _onStateChanged(FirebaseUser user) async{
        if(user == null){
          _status = Status.Unauthenticated;
        }else{
          _user = user;
          _status = Status.Authenticated;
        }
        notifyListeners();

  }
}