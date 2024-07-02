import 'package:fireeeeee/ui/post/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireeeeee/controllers/text_controllers.dart';
import 'package:fireeeeee/ui/auth/verify_code.dart';
import 'package:fireeeeee/utils/utils.dart';
import 'package:fireeeeee/widgets/round_button.dart';


class VerifyCodeScreen extends StatefulWidget {
 final String verificationId;
  const VerifyCodeScreen({super.key,required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
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
                controller: tcontroller.verifyCOntroller,
                decoration: InputDecoration(
                  hintText: '6 digit code',
                ),
              ),
            ),
            SizedBox(height: 80),
            RoundButton(
                loading: loading,
                title: 'Verify',
                onTap: () async{
                  setState(() {
                    loading = true;
                  });
                  final token = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: tcontroller.verifyCOntroller.text.toString()
                  );
                  try{
                    await auth.signInWithCredential(token);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PostScreen()));
                  }catch(e){
                    setState(() {
                      loading = false;

                    });
                    Utils().toastMessage(e.toString());
                    print(e.toString());
                  }
                }
            ),
          ],
        ),
      ),
    );
  }
}
