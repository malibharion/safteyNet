import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/CustomsWidgets/backGroundImageContainer.dart';
import 'package:saftey_net/CustomsWidgets/customElevatedButton.dart';
import 'package:saftey_net/CustomsWidgets/customTextFeild.dart';
import 'package:saftey_net/StateMangment/language.dart';
import 'package:saftey_net/StateMangment/signUp.dart';
import 'package:saftey_net/views/AuthoritesViews/authoriritiesHomeScreen.dart';
import 'package:saftey_net/views/AuthoritesViews/authoritiesdashBoardScreen.dart';

class AuthorititesLoginScreen extends StatefulWidget {
  const AuthorititesLoginScreen({super.key});

  @override
  State<AuthorititesLoginScreen> createState() =>
      _AuthorititesLoginScreenState();
}

class _AuthorititesLoginScreenState extends State<AuthorititesLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BackgroundImageWithContainer(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                          'assets/images/ChatGPT_Image_May_3__2025__11_27_41_AM-removebg-preview 1.png'),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      localizationProvider.locale.languageCode == 'en'
                          ? 'Login'
                          : 'لاگ ان کریں',
                      style: TextStyle(
                        fontFamily: AppFonts.robotoRegular,
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Email Field
                    CustomTextField(
                      controller: _emailController,
                      prefixIcon: Icons.email_outlined,
                      hintText: localizationProvider.locale.languageCode == 'en'
                          ? 'Email'
                          : 'ای میل',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizationProvider.locale.languageCode ==
                                  'en'
                              ? 'Please enter your email'
                              : 'براہ کرم اپنا ای میل درج کریں';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return localizationProvider.locale.languageCode ==
                                  'en'
                              ? 'Enter a valid email'
                              : 'درست ای میل درج کریں';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      prefixIcon: Icons.lock_outline,
                      hintText: localizationProvider.locale.languageCode == 'en'
                          ? 'Password'
                          : 'پاسورڈ',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizationProvider.locale.languageCode ==
                                  'en'
                              ? 'Please enter your password'
                              : 'براہ کرم اپنا پاسورڈ درج کریں';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24.h),

                    // Error Message
                    if (authProvider.errorMessage != null)
                      Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: Text(
                          authProvider.errorMessage!,
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: AppFonts.robotoRegular,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),

                    // Login Button
                    CustomElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () async {
                              authProvider.clearError();
                              if (_formKey.currentState!.validate()) {
                                await authProvider.loginWithEmail(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  onSuccess: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AdminDashboardScreen(),
                                      ),
                                    );
                                  },
                                  onError: (error) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error)),
                                    );
                                  },
                                );
                              }
                            },
                      text: authProvider.isLoading
                          ? localizationProvider.locale.languageCode == 'en'
                              ? 'Logging in...'
                              : 'لاگ ان ہو رہا ہے...'
                          : localizationProvider.locale.languageCode == 'en'
                              ? 'Login'
                              : 'لاگ ان کریں',
                      icon: Icons.login,
                    ),
                    SizedBox(height: 16.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
