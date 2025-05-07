import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/adminComplainProvider.dart';
import 'package:saftey_net/StateMangment/communityProvider.dart';
import 'package:saftey_net/StateMangment/complaintProvider.dart';
import 'package:saftey_net/StateMangment/feedbackProvider.dart';
import 'package:saftey_net/StateMangment/language.dart';
import 'package:saftey_net/StateMangment/signUp.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:saftey_net/firebase_options.dart';
import 'package:saftey_net/views/StartingScreens/getStartedScreen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => ComplaintProvider()),
    ChangeNotifierProvider(create: (_) => CommunityProvider()),
    ChangeNotifierProvider(create: (_) => FeedbackProvider()),
    ChangeNotifierProvider(create: (_) => ComplaintManagerProvider()),
    ChangeNotifierProvider(create: (_) => LocalizationProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          locale: Provider.of<LocalizationProvider>(context).locale,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', ''),
            const Locale('ur', ''),
          ],
          home: child,
        );
      },
      child: const GetStartedScreen(),
    );
  }
}
