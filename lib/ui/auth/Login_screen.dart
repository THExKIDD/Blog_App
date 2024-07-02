import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fireeeeee/controllers/text_controllers.dart';
import 'package:fireeeeee/ui/auth/signup_screen.dart';
import 'package:fireeeeee/ui/post/post_screen.dart';
import 'package:fireeeeee/utils/utils.dart';
import 'package:fireeeeee/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextControllers tcontroller = TextControllers();
  final _formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tcontroller.emailController;
    tcontroller.passwordController;

  }

  void login()
  {
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(email: tcontroller.emailController.text, password: tcontroller.passwordController.text).then((value) {
      setState(() {
        loading=false;
      });
      Utils().toastMessage(value.user!.email.toString());
    }).onError((error , stackTrace){
      setState(() {
        loading=false;
      });
      Utils().toastMessage(error.toString());
    });
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PostScreen()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login'),
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

                  obscureText: tcontroller.loginObscure.value ? true : false,
                    controller: tcontroller.passwordController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                          icon: Icon(tcontroller.loginObscure.value ? Icons.lock : Icons.lock_open),
                          onPressed: () => tcontroller.toggleLoginPass()
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
                  if(_formkey.currentState != null && _formkey.currentState!.validate())
                    {
                      setState(() {
                        loading =true;
                      });
                      login();
                    }






              },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Dont Have an Account?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupScreen()));
                    
                  },
                      child: const Text('Sign Up'))
                  
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
