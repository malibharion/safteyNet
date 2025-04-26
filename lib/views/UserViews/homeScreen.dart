import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/CustomsWidgets/backGroundImageContainer.dart';
import 'package:saftey_net/CustomsWidgets/customElevatedButton.dart';
import 'package:saftey_net/views/UserViews/communityScreen.dart';
import 'package:saftey_net/views/UserViews/userAskForHelpScreen.dart';
import 'package:saftey_net/views/UserViews/userFeedbackScreen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({super.key});

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
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
                height: MediaQuery.of(context).size.height * 0.10,
              ),
              Column(
                children: [
                  CustomElevatedButton(
                    text: 'Ask For Help',
                    icon: Icons.healing,
                    buttonWidth: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AskForHelpScreen()));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomElevatedButton(
                    text: 'Comunity',
                    icon: Icons.people_alt_outlined,
                    buttonWidth: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CommunityScreen()));
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomElevatedButton(
                    text: 'Feedback',
                    icon: Icons.feedback_outlined,
                    buttonWidth: MediaQuery.of(context).size.width * 0.8,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FeedbackScreen()));
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
