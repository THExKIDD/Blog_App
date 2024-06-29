import 'package:fireeeeee/controllers/text_controllers.dart';
import 'package:fireeeeee/ui/auth/Login_screen.dart';
import 'package:fireeeeee/utils/utils.dart';
import 'package:fireeeeee/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool loading = false;

  TextControllers tcontroller = TextControllers();
  final _formkey = GlobalKey<FormState>();

  FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  void dispose() {
    tcontroller.emailController.dispose();
    tcontroller.passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  validator: (value){
                    if(value!.isEmpty)
                    {
                      return 'Enter Email';
                    }
                    return null;

                  },
                  controller: tcontroller.emailController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,

                      ),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10),right: Radius.circular(10)),
                    ),
                    prefixIcon: Icon(Icons.alternate_email),
                    hintText: 'Enter Email...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10),right: Radius.circular(10)),
                    ),
                  )
              ),
              const SizedBox(height: 10),
              Obx(() => TextFormField(
                  obscureText: tcontroller.obscureText,
                    controller: tcontroller.passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          tcontroller.obscureText
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: tcontroller.toggleObscureText,
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,

                        ),
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(10),right: Radius.circular(10)),
                      ),
                      prefixIcon: const Icon(Icons.lock_open),
                      hintText: 'Enter Password...',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(10),right: Radius.circular(10)),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Password';
                      }
                      return null;
                    }
                ),
              ),
              const SizedBox(height: 40),

              RoundButton(
                title: 'Press',
                loading: loading,
                onTap: (){
                  signUpAuth();
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already Have an Account?'),
                  TextButton(onPressed: (){

                    Navigator.pop(context);

                  },
                      child: const Text('Login'))

                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  void signUpAuth()
  {

    if(_formkey.currentState != null && _formkey.currentState!.validate())
    {
    setState(() {
    loading =true;
    });
    _auth.createUserWithEmailAndPassword(email: tcontroller.emailController.text.toString(),
    password: tcontroller.passwordController.text.toString()).then((value) {
    setState(() {
    loading =false;
    });

    }).onError((error, stackTrace){
    Utils().toastMessage(error.toString());
    setState(() {
    loading =false;
    });

    });

    }
    }
  }

