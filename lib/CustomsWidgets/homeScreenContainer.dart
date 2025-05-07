import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';

class HomeScreenContainer extends StatefulWidget {
  final String text;
  final ImageProvider image;
  final VoidCallback onTap;

  const HomeScreenContainer({
    required this.onTap,
    required this.text,
    required this.image,
    super.key,
  });

  @override
  State<HomeScreenContainer> createState() => _HomeScreenContainerState();
}

class _HomeScreenContainerState extends State<HomeScreenContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image(image: widget.image),
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: AppFonts.robotoLight,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
