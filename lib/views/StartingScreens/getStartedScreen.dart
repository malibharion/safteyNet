import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/CustomsWidgets/backGroundImageContainer.dart';
import 'package:saftey_net/CustomsWidgets/customElevatedButton.dart';
import 'package:saftey_net/views/StartingScreens/selectUserScreen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: BackgroundImageWithContainer(
          backgroundImagePath: 'assets/images/image 105 (5).png',
          child: Column(
            children: [
              Center(
                  child: Image(
                image: AssetImage('assets/images/fotor-2025041510056 1.png'),
              )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                'Saftey Net',
                style: TextStyle(
                    fontFamily: AppFonts.robotoRegular,
                    color: Colors.white,
                    fontSize: 39.sp,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.30),
              CustomElevatedButton(
                text: 'Get Started',
                icon: Icons.arrow_forward,
                buttonWidth: MediaQuery.of(context).size.width * 0.8,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SelectUserScreen()));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
