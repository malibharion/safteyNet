import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/CustomsWidgets/homeScreenContainer.dart';

import 'package:saftey_net/CustomsWidgets/topBarContainer.dart';
import 'package:saftey_net/StateMangment/language.dart';
import 'package:saftey_net/views/UserViews/Complaints/complainMainScreen.dart';
import 'package:saftey_net/views/UserViews/communityScreen.dart';
import 'package:saftey_net/views/UserViews/feedbackscreen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    var localizationProvider = Provider.of<LocalizationProvider>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 243, 243, 243),
        body: Column(
          children: [
            TopBarContainer(),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              localizationProvider.locale.languageCode == 'en'
                  ? "Welcome Back"
                  : "خوش آمدید واپس",
              style: TextStyle(
                fontFamily: AppFonts.robotoRegular,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeScreenContainer(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ComplaintMainScreen()));
                  },
                  text: localizationProvider.locale.languageCode == 'en'
                      ? "Complain"
                      : "شکایت کریں",
                  image: AssetImage('assets/images/Complaints.png'),
                ),
                HomeScreenContainer(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommunityScreen()));
                  },
                  text: localizationProvider.locale.languageCode == 'en'
                      ? "Community"
                      : "کمیونٹی",
                  image: AssetImage('assets/images/community.png'),
                ),
                HomeScreenContainer(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FeedbackScreen()));
                  },
                  text: localizationProvider.locale.languageCode == 'en'
                      ? "Feedback"
                      : "رائے",
                  image: AssetImage('assets/images/feeback5.png'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
