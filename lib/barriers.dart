import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;
  MyBarrier({this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.green,
        border: Border.all(width: 5, color: Colors.greenAccent),
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
