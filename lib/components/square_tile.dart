import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final double padPercent;
  final Function()? onTap;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.padPercent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(
            MediaQuery.sizeOf(context).height * (padPercent / 2)),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        child: Image.asset(
          imagePath,
          height: MediaQuery.sizeOf(context).height * padPercent / 1.5,
        ),
      ),
    );
  }
}
