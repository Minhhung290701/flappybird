import 'package:flutter/material.dart';

class MyBird extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: Image.asset(
        'asset/images/flappybird.png'
      ),
    );
  }
}
