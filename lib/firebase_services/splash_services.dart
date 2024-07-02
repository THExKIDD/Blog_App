

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireeeeee/ui/auth/Login_screen.dart';
import 'package:fireeeeee/ui/post/post_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {

  void isLogin(BuildContext context)
  {


    final auth = FirebaseAuth.instance;

    final user = auth.currentUser ;

    if(user != null)
    {
      Timer(const Duration(seconds: 3),
              ()=>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PostScreen()))
      );

    }
    else
      {
        Timer(const Duration(seconds: 3),
                ()=>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()))
        );
      }





  }

}