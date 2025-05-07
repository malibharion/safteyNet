import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/language.dart';
import 'package:saftey_net/StateMangment/signUp.dart';

import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/CustomsWidgets/backGroundImageContainer.dart';
import 'package:saftey_net/CustomsWidgets/customElevatedButton.dart';
import 'package:saftey_net/CustomsWidgets/customTextFeild.dart';
import 'package:saftey_net/views/LoginSignUpScreen/user/userLoginScreen.dart';

class UserSignUpScreen extends StatefulWidget {
  const UserSignUpScreen({super.key});

  @override
  State<UserSignUpScreen> createState() => _UserSignUpScreenState();
}

class _UserSignUpScreenState extends State<UserSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
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
                          ? 'Sign Up'
                          : 'سائن اپ کریں',
                      style: TextStyle(
                        fontFamily: AppFonts.robotoRegular,
                        color: Colors.white,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: 20.h),

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
                              : 'ایک درست ای میل درج کریں';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Phone Field
                    CustomTextField(
                      controller: _phoneController,
                      prefixIcon: Icons.phone,
                      hintText: localizationProvider.locale.languageCode == 'en'
                          ? 'Mobile Number'
                          : 'موبائل نمبر',
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return localizationProvider.locale.languageCode ==
                                  'en'
                              ? 'Please enter your phone number'
                              : 'براہ کرم اپنا فون نمبر درج کریں';
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
                              ? 'Please enter a password'
                              : 'براہ کرم پاسورڈ درج کریں';
                        }
                        if (value.length < 6) {
                          return localizationProvider.locale.languageCode ==
                                  'en'
                              ? 'Password must be at least 6 characters'
                              : 'پاسورڈ کم از کم 6 حروف پر مشتمل ہونا چاہیے';
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

                    // Sign Up Button
                    CustomElevatedButton(
                      onPressed: authProvider.isLoading
                          ? null
                          : () async {
                              authProvider.clearError();
                              if (_formKey.currentState!.validate()) {
                                await authProvider.signUpWithEmail(
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                  onSuccess: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UserLoginScreen(),
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
                              ? 'Creating Account...'
                              : 'اکاؤنٹ بنارہا ہے...'
                          : localizationProvider.locale.languageCode == 'en'
                              ? 'Sign Up'
                              : 'سائن اپ کریں',
                      icon: Icons.login,
                    ),
                    SizedBox(height: 16.h),

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min, // Add this line
                      children: [
                        Flexible(
                          // Wrap first Text with Flexible
                          child: Text(
                            localizationProvider.locale.languageCode == 'en'
                                ? 'Already have an account?'
                                : 'کیا آپ کا اکاؤنٹ پہلے سے موجود ہے؟',
                            style: TextStyle(
                              fontFamily: AppFonts.robotoLight,
                              color: Colors.white,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const UserLoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            localizationProvider.locale.languageCode == 'en'
                                ? 'Login'
                                : 'لاگ ان کریں',
                            style: TextStyle(
                              fontFamily: AppFonts.robotoRegular,
                              color: AppColors.primary,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    )
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
