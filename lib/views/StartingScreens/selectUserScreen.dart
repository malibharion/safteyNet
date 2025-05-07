import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/CustomsWidgets/backGroundImageContainer.dart';
import 'package:saftey_net/CustomsWidgets/customElevatedButton.dart';
import 'package:saftey_net/StateMangment/language.dart';
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
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    return SafeArea(
      child: Center(
        child: BackgroundImageWithContainer(
          child: Column(
            children: [
              Center(
                  child: Image(
                width: 200.w,
                image: AssetImage(
                    'assets/images/ChatGPT_Image_May_3__2025__11_27_41_AM-removebg-preview 1.png'),
              )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Text(
                localizationProvider.locale.languageCode == 'en'
                    ? 'Safety Net'
                    : 'سیفٹی نیٹ',
                style: TextStyle(
                  fontFamily: AppFonts.robotoRegular,
                  color: Colors.white,
                  fontSize: 39.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.20,
              ),
              Column(
                children: [
                  CustomElevatedButton(
                    text: localizationProvider.locale.languageCode == 'en'
                        ? 'User'
                        : 'صارف',
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
                    text: localizationProvider.locale.languageCode == 'en'
                        ? 'Authorities'
                        : 'اختیارات',
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
