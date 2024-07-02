import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireeeeee/controllers/text_controllers.dart';
import 'package:fireeeeee/ui/auth/verify_code.dart';
import 'package:fireeeeee/utils/utils.dart';
import 'package:fireeeeee/widgets/round_button.dart';
import 'package:flutter/material.dart';


class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool loading = false;
  final auth = FirebaseAuth.instance;
  TextControllers tcontroller = TextControllers();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),

      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 50),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                controller: tcontroller.phoneNumberController,
                decoration: InputDecoration(
                  hintText: '+91 23455 23455',
                ),
              ),
            ),
            SizedBox(height: 80),
            RoundButton(
              loading: loading,
                title: 'Login',
                onTap: (){
                setState(() {
                  loading =true;
                });
                  auth.verifyPhoneNumber(
                    phoneNumber: '+91${tcontroller.phoneNumberController.text}',
                      verificationCompleted: (_){
                      setState(() {
                        loading = false;
                      });

                      },
                      verificationFailed: (e){
                      setState(() {
                        loading = false;
                      });
                      Utils().toastMessage(e.toString());
                      print(e.toString());
                      },
                      codeSent: (String verificationId , int? token){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VerifyCodeScreen(verificationId: verificationId,)));
                      setState(() {
                        loading = false;
                      });
                      },
                      codeAutoRetrievalTimeout: (e){
                      Utils().toastMessage(e.toString());
                      setState(() {
                        loading = false;
                      });
                      }
                  );
                }
            ),
          ],
        ),
      ),
    );
  }
}
