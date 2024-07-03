
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:fireeeeee/ui/auth/Login_screen.dart';
import 'package:fireeeeee/ui/post/post_add_screen.dart';
import 'package:fireeeeee/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => const PostAddScreen()));
        
      },
      child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          // Expanded(
          //     child:StreamBuilder(
          //       stream: databaseRef.onValue,
          //       builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
          //         if(!snapshot.hasData){
          //           return CircularProgressIndicator();
          //         }
          //         else {
          //           Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //           List<dynamic> list =[];
          //           list.clear();
          //           list= map.values.toList();
          //           return ListView.builder(
          //               itemCount: snapshot.data!.snapshot.children.length,
          //               itemBuilder: (context, index) {
          //                 return ListTile(
          //                   title: Text(list[index]['title']),
          //                   subtitle: Text(list[index]['objective']),
          //                 );
          //               });
          //         }
          //       },
          //     ),
          //     ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchFilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder()
              ),
              onChanged: (String value){
                setState(() {

                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(query: databaseRef,
                itemBuilder: (context , snapshot, animation, index){
              final title = snapshot.child('title').value.toString();

              if(searchFilter.text.isEmpty){
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('objective').value.toString()),

                );
              }
              else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toString())){
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('objective').value.toString()),

                );
              }
              else{
                return Container();
              }

                }),
          ),

        ],
      ),
    );
  }
}
