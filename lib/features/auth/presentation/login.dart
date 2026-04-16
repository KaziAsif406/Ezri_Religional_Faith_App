import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_toast.dart';
import 'package:template_flutter/helpers/loading_helper.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_rich_text_button.dart';
import '../../../common_widgets/custom_text_button.dart';
import '../../../common_widgets/custom_textform_field.dart';
import '../../../networks/api_acess.dart';
import '/constants/text_font_style.dart';
import '/constants/validator.dart';
import '/gen/colors.gen.dart';
import '/helpers/all_routes.dart';
import '/helpers/navigation_service.dart';
import '/helpers/ui_helpers.dart';
import 'widget/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (true) {
      setState(() {
        _isLoading = true;
      });

      try {
        final success = await postLoginRxObj
            .postLogin(
              email: _emailController.text.trim(),
              password: _passController.text.trim(),
            )
            .waitingForFutureWithoutBg();

        if (success) {
          //await Future.delayed(const Duration(milliseconds: 500));
          log("Login Successful");

          customToastMessage('Success', "You have sucessfully logged in");
          NavigationService.navigateTo(Routes.productsScreen);
        }
      } catch (e) {
        // Handle error here
        customToastMessage("Failed", "Login failed. Please try again.");
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _emailController.text = "test@example.com";
    _passController.text = "password123";
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(
            UIHelper.kDefaulutPadding(),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UIHelper.verticalSpace(40.h),

                // Logo
                // Assets.images.logo.image(
                //   height: 80.h,
                //   width: 80.w,
                //   fit: BoxFit.contain,
                // ),

                UIHelper.verticalSpace(40.h),

                // Title
                Text(
                  "Welcome Back",
                  style: TextFontStyle.textStyle26c202020DMSans600,
                ),

                UIHelper.verticalSpace(8.h),

                Text(
                  "Please sign in to your account",
                  style: TextFontStyle.textStyle14c606060DMSans400,
                  textAlign: TextAlign.center,
                ),

                UIHelper.verticalSpace(40.h),

                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      // Email Field
                      CustomTextFormField(
                        validator: emailValidator,
                        controller: _emailController,
                        hintText: "Enter email or phone number",
                        labelText: "Email or Phone Number",
                        prefixIcon: Icons.email_outlined,
                        textInputAction: TextInputAction.next,
                      ),

                      UIHelper.verticalSpace(16.h),

                      // Password Field
                      CustomTextFormField(
                        validator: passwordValidator,
                        isPassword: true,
                        controller: _passController,
                        hintText: "Enter password",
                        labelText: "Password",
                        prefixIcon: Icons.lock_outline,
                        textInputAction: TextInputAction.done,
                      ),

                      UIHelper.verticalSpace(16.h),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTexButton(
                          onPressed: () {
                            NavigationService.navigateTo(Routes.forgotPWScreen);
                          },
                          title: "Forgot password?",
                        ),
                      ),

                      UIHelper.verticalSpace(40.h),

                      // Login Button
                      customButton(
                        onPressed: _isLoading ? null : _login,
                        title: _isLoading ? "Signing In..." : "Sign In",
                        isLoading: _isLoading,
                      ),
                    ],
                  ),
                ),

                UIHelper.verticalSpace(40.h),

                // Divider with "Or"
                Row(
                  children: [
                    Expanded(child: _horizontalLine()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Or",
                        style: TextFontStyle.textStyle14c383838DMSans600,
                      ),
                    ),
                    Expanded(child: _horizontalLine()),
                  ],
                ),

                UIHelper.verticalSpace(40.h),

                // Social Login Buttons (Optional)
                _buildSocialLoginButtons(),

                UIHelper.verticalSpace(40.h),

                // Sign Up Redirect
                CustomRichTextButton(
                  onPressed: () {
                    NavigationService.navigateTo(Routes.signUpScreen);
                  },
                  additionalText: "Don't have an Account? ",
                  buttonText: "Sign Up",
                ),

                UIHelper.verticalSpace(20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _horizontalLine() {
    return Container(
      height: 1.h,
      color: AppColors.cE8E8E8,
    );
  }

  Widget _buildSocialLoginButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        socialLoginButton(
          icon: Icons.g_mobiledata,
          onPressed: () {
            // Handle Google login
          },
        ),
        UIHelper.horizontalSpace(20.w),
        socialLoginButton(
          icon: Icons.facebook,
          onPressed: () {
            // Handle Facebook login
          },
        ),
      ],
    );
  }
}
