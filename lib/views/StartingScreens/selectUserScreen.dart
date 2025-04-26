import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/CustomsWidgets/backGroundImageContainer.dart';
import 'package:saftey_net/CustomsWidgets/customElevatedButton.dart';
import 'package:saftey_net/views/LoginSignUpScreen/Authtorities/authoritiesloginScreen.dart';
import 'package:saftey_net/views/LoginSignUpScreen/user/userLoginScreen.dart';

class SelectUserScreen extends StatefulWidget {
  const SelectUserScreen({super.key});

  @override
  State<SelectUserScreen> createState() => _SelectUserScreenState();
}

class _SelectUserScreenState extends State<SelectUserScreen> {
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              Column(
                children: [
                  CustomElevatedButton(
                    text: 'User',
                    icon: Icons.arrow_forward,
                    buttonWidth: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const UserLoginScreen()));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomElevatedButton(
                    text: 'Authorities',
                    icon: Icons.arrow_forward,
                    buttonWidth: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const AuthorititesLoginScreen()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
