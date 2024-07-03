
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class TextControllers{

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool _obscureText = true.obs;

  bool get obscureText => _obscureText.value;

  void toggleObscureText() {
    _obscureText.value = !_obscureText.value;
  }

  RxBool loginObscure = true.obs;

  void toggleLoginPass()
  {
    loginObscure.value = !loginObscure.value;
  }

  final phoneNumberController = TextEditingController();
  final verifyCOntroller = TextEditingController();

  final postController = TextEditingController();


  }