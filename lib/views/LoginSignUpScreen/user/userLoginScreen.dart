import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:saftey_net/StateMangment/signUp.dart';

import 'package:saftey_net/Conatants/colorsConstants.dart';
import 'package:saftey_net/Conatants/familyConstants.dart';
import 'package:saftey_net/CustomsWidgets/backGroundImageContainer.dart';
import 'package:saftey_net/CustomsWidgets/customElevatedButton.dart';
import 'package:saftey_net/CustomsWidgets/customTextFeild.dart';
import 'package:saftey_net/views/UserViews/homeScreen.dart';
import 'package:saftey_net/views/LoginSignUpScreen/user/userSignUpScreen.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
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

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: BackgroundImageWithContainer(
            backgroundImagePath: 'assets/images/image 105 (5).png',
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Center(
                      child: Image.asset(
                          'assets/images/fotor-2025041510056 1.png'),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'Login',
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
                      hintText: 'Email',
                      obscureText: false,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Password Field
                    CustomTextField(
                      controller: _passwordController,
                      prefixIcon: Icons.lock_outline,
                      hintText: 'Password',
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
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
                                            const UserHomeScreen(),
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
                      text: authProvider.isLoading ? 'Logging in...' : 'Login',
                      icon: Icons.login,
                    ),
                    SizedBox(height: 16.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            'Don\'t have an account?',
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
                                builder: (context) => const UserSignUpScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontFamily: AppFonts.robotoRegular,
                              color: AppColors.primary,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
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
