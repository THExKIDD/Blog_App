

import 'dart:async';

import 'package:fireeeeee/ui/auth/Login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashServices {

  void isLogin(BuildContext context)
  {
    Timer(Duration(seconds: 3),
    ()=>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()))
    );
  }

}