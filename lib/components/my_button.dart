import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final double padPercent;
  final Function()? onTap;
  final String text;
  const MyButton(
      {super.key,
      required this.padPercent,
      required this.onTap,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
            MediaQuery.sizeOf(context).height * (padPercent / 2)),
        margin: EdgeInsets.all(
            MediaQuery.sizeOf(context).height * (padPercent / 2)),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
