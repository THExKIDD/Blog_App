import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fireeeeee/ui/auth/Login_screen.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import 'post_add_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final editor = TextEditingController();
  final searchFilter = TextEditingController();
  late FirebaseDatabase database;
  late DatabaseReference databaseRef;
  final auth = FirebaseAuth.instance;

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
        automaticallyImplyLeading: false,
        title: const Text('Post Screen'),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        actions: [
          IconButton(
            onPressed: () {
              auth.signOut().then((value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              }).onError((error, stackTrace) {
                Utils().toastMessage(error.toString());
              });
            },
            icon: const Icon(Icons.logout),
          ),
          const SizedBox(width: 10),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostAddScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseRef,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('title').value.toString();

                if (searchFilter.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('objective').value.toString()),
                    trailing: PopupMenuButton(
                      icon: Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                          child: ListTile(
                            title: Text('edit'),
                            leading: Icon(Icons.edit),
                            onTap: () {
                              Navigator.pop(context);
                              showMyDialog(title, snapshot);
                            },
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            title: Text('delete'),
                            leading: Icon(Icons.delete),
                          ),
                        )
                      ],
                    ),
                  );
                } else if (title.toLowerCase().contains(searchFilter.text.toLowerCase().toString())) {
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('objective').value.toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showMyDialog(String title, DataSnapshot snapshot) async {
    editor.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update'),
          content: Container(
            height: 50,
            child: TextField(
              controller: editor,
              decoration: InputDecoration(
                hintText: 'Edit',
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                databaseRef.child(snapshot.key!).update({
                  'title': editor.text.toLowerCase(),
                  'objective': snapshot.child('objective').value.toString(),
                }).then((value) {
                  Utils().toastMessage('Post Updated');
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              child: Text('Edit'),
            ),
          ],
        );
      },
    );
  }
}