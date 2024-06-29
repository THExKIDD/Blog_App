import 'package:fireeeeee/controllers/text_controllers.dart';
import 'package:fireeeeee/ui/auth/signup_screen.dart';
import 'package:fireeeeee/widgets/round_button.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextControllers tcontroller = TextControllers();
  final _formkey = GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    tcontroller.emailController;
    tcontroller.passwordController;

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
              TextFormField(

                obscureText: true,
                  controller: tcontroller.passwordController,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,

                      ),
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(10),right: Radius.circular(10)),
                    ),
                    prefixIcon: Icon(Icons.lock_open),
                    hintText: 'Enter Password...',
                    border: OutlineInputBorder(
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
              const SizedBox(height: 40),

              RoundButton(
                title: 'Press',
              onTap: (){
                  if(_formkey.currentState!.validate())
                    {

                    }

              },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dont Have an Account?'),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                    
                  },
                      child: Text('Sign Up'))
                  
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
