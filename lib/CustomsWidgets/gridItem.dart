import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;

  const GridItem({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.grey.shade300, blurRadius: 4)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 60, width: 60),
            SizedBox(height: 10),
            Text(title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
