


import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  bool loading ;
  RoundButton({super.key, required this.title, required this.onTap, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(child: loading ? const CircularProgressIndicator(
            strokeWidth: 3,
            color: Colors.white,
          ) :
          Text(title, style: const TextStyle(
            color: Colors.white,
          ),
          )
          ),
        ),
      ),
    );
  }
}
