

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fireeeeee/controllers/text_controllers.dart';
import 'package:fireeeeee/utils/utils.dart';
import 'package:fireeeeee/widgets/round_button.dart';
import 'package:flutter/material.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({super.key});

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  bool loading = false;
  late FirebaseDatabase database;
  late DatabaseReference databaseRef;
  TextControllers tcontroller = TextControllers();

  @override
  void initState() {
    super.initState();
    database = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL: 'https://testing-cli-b2f21-default-rtdb.asia-southeast1.firebasedatabase.app',
    );
    databaseRef = database.ref('Post');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('add node'),
        centerTitle: true,


      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            TextFormField(
              maxLines: 4,
              controller: tcontroller.postController,
              decoration: InputDecoration(
                hintText: 'What is in your mind : ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )

              ),
            ),
            const SizedBox(height: 30,),
            RoundButton(
              loading: loading,
                title: 'ADD',
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                    'title': tcontroller.postController.text.toString(),
                    'objective': 'hanji',
                  }).then((value){
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage('Post Added');
                  }).onError((error, stackTrace){
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });
                }
            )
          ],
        ),
      ),
    );
  }
}
