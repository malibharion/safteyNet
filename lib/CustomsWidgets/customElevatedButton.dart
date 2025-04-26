import 'package:flutter/material.dart';
import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? buttonColor;
  final Color? textColor;
  final double? buttonHeight;
  final double? buttonWidth;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.buttonColor = AppColors.primary,
    this.textColor = Colors.white,
    this.buttonHeight,
    this.buttonWidth,
    this.fontSize = 16,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? 48,
      width: buttonWidth,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontFamily: AppFonts.robotoRegular,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              icon,
              color: textColor,
              size: fontSize! + 2,
            ),
          ],
        ),
      ),
    );
  }
}
