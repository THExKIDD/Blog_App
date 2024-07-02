
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
        title: const Text('Post Screen'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                auth.signOut().then((value){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                }).onError((error , stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(Icons.logout)
          ),
          const SizedBox(width: 10),
          
          
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => PostScreen()));
        
      },
      child: Icon(Icons.add),
      ),
    );
  }
}
