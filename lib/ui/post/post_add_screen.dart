

import 'package:flutter/material.dart';

class PostAddScreen extends StatefulWidget {
  const PostAddScreen({super.key});

  @override
  State<PostAddScreen> createState() => _PostAddScreenState();
}

class _PostAddScreenState extends State<PostAddScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add node'),
        centerTitle: true,


      ),
    );
  }
}
