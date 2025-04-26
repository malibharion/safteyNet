import 'package:flutter/material.dart';

class BackgroundImageWithContainer extends StatelessWidget {
  final Widget child;
  final String? backgroundImagePath;
  final Color containerColor;
  final EdgeInsetsGeometry? padding;
  final double? maxWidth; // Optional max width
  final double? maxHeight; // Optional max height

  const BackgroundImageWithContainer({
    super.key,
    required this.child,
    this.backgroundImagePath,
    this.containerColor = const Color(0xA6000000),
    this.padding,
    this.maxWidth,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (backgroundImagePath != null)
            Image.asset(
              backgroundImagePath!,
              fit: BoxFit.cover,
            )
          else
            Container(color: Colors.grey),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxWidth ?? MediaQuery.of(context).size.width * 0.9,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Container(
                  padding: padding ?? const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
