import 'package:flutter/material.dart';

class MyBotton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const MyBotton({super.key,
  required this.text,
  required this.onTap
  });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(10)
        ),
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Center(
         child: Text(text),
        ),
      ),
    );
  }
}