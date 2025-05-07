import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';

class TopBarContainer extends StatelessWidget {
  const TopBarContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      width: double.infinity,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Text(
            'Saftey Net',
            style: TextStyle(
                fontFamily: AppFonts.robotoRegular,
                color: Colors.white,
                fontSize: 30.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
