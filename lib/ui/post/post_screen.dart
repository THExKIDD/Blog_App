
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fireeeeee/ui/auth/Login_screen.dart';
import 'package:fireeeeee/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Screen'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                auth.signOut().then((value){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                }).onError((error , stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: Icon(Icons.logout)
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
