// lib/features/auth/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../common_widgets/custom_toast.dart';
import '../../../helpers/url_lunch.dart';
import '../../../common_widgets/custom_button.dart';
import '../../../common_widgets/custom_rich_text_button.dart';
import '../../../common_widgets/custom_textform_field.dart';
import '/constants/text_font_style.dart';
import '/constants/validator.dart';
import '/gen/colors.gen.dart';
import '/helpers/all_routes.dart';
import '/helpers/navigation_service.dart';
import '/helpers/ui_helpers.dart';
import 'package:get_storage/get_storage.dart';
import 'widget/social_login_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final box = GetStorage();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (_formKey.currentState!.validate()) {
      if (!_agreeToTerms) {
        customToastMessage("Required", "Please agree to terms and conditions");
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        // Registration API call
        // final success = await postRegisterRxObj
        //     .postRegister(
        //       name: _nameController.text.trim(),
        //       email: _emailController.text.trim(),
        //       phone: _phoneController.text.trim(),
        //       password: _passwordController.text.trim(),
        //     )
        //     .waitingForFutureWithoutBg();

        // if (success) {
        //   customToastMessage("Success", "Account created successfully!");
        //   NavigationService.navigateTo(Routes.navBarScreen);
        // }

        // Simulate API call
        await Future.delayed(const Duration(seconds: 2));
        customToastMessage("Success", "Account created successfully!");
        // NavigationService.navigateTo(Routes.navBarScreen);
      } catch (e) {
        customToastMessage("Failed", "Registration failed. Please try again.");
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
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(UIHelper.kDefaulutPadding()),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UIHelper.verticalSpace(20.h),

                // Back Button
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      NavigationService.goBack;
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                      color: AppColors.c202020,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ),

                UIHelper.verticalSpace(20.h),

                // Title
                Text(
                  "Create Account",
                  style: TextFontStyle.textStyle26c202020DMSans600,
                ),

                UIHelper.verticalSpace(8.h),

                Text(
                  "Fill your information below or register\nwith your social account",
                  style: TextFontStyle.textStyle14c606060DMSans400.copyWith(
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                UIHelper.verticalSpace(40.h),

                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Full Name Field
                      CustomTextFormField(
                        validator: nameValidator,
                        controller: _nameController,
                        hintText: "Enter your full name",
                        labelText: "Full Name",
                        prefixIcon: Icons.person_outline,
                        textInputAction: TextInputAction.next,
                      ),

                      UIHelper.verticalSpace(16.h),

                      // Email Field
                      CustomTextFormField(
                        validator: emailValidator,
                        controller: _emailController,
                        hintText: "Enter your email",
                        labelText: "Email Address",
                        prefixIcon: Icons.email_outlined,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      UIHelper.verticalSpace(16.h),

                      // Phone Field
                      CustomTextFormField(
                        validator: validatePhoneNumber,
                        controller: _phoneController,
                        hintText: "Enter your phone number",
                        labelText: "Phone Number",
                        prefixIcon: Icons.phone_outlined,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                      ),

                      UIHelper.verticalSpace(16.h),

                      // Password Field
                      CustomTextFormField(
                        validator: passwordValidator,
                        isPassword: true,
                        controller: _passwordController,
                        hintText: "Enter your password",
                        labelText: "Password",
                        prefixIcon: Icons.lock_outline,
                        textInputAction: TextInputAction.next,
                      ),

                      UIHelper.verticalSpace(16.h),

                      // Confirm Password Field
                      CustomTextFormField(
                        validator: (value) => confirmPasswordValidator(
                            value, _passwordController.text),
                        isPassword: true,
                        controller: _confirmPasswordController,
                        hintText: "Confirm your password",
                        labelText: "Confirm Password",
                        prefixIcon: Icons.lock_outline,
                        textInputAction: TextInputAction.done,
                      ),

                      UIHelper.verticalSpace(16.h),

                      // Terms and Conditions Checkbox
                      Row(
                        children: [
                          SizedBox(
                            width: 24.w,
                            height: 24.h,
                            child: Checkbox(
                              value: _agreeToTerms,
                              onChanged: (value) {
                                setState(() {
                                  _agreeToTerms = value ?? false;
                                });
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r),
                              ),
                              activeColor: AppColors.allPrimaryColor,
                              checkColor: AppColors.cFFFFFF, // White checkmark
                              fillColor: WidgetStateProperty.resolveWith<Color>(
                                  (states) {
                                if (states.contains(WidgetState.selected)) {
                                  return AppColors
                                      .allPrimaryColor; // Selected color
                                }
                                return AppColors.cE8E8E8; // Unselected color
                              }),
                            ),
                          ),
                          UIHelper.horizontalSpace(12.w),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                // Launch Terms & Conditions URL
                                urlLunch("https://demo.zhndev.site/wp/");
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "I agree to the ",
                                      style: TextFontStyle
                                          .textStyle14c606060DMSans400,
                                    ),
                                    TextSpan(
                                      text: "Terms & Conditions",
                                      style: TextFontStyle
                                          .textStyle14c606060DMSans400
                                          .copyWith(
                                        color: AppColors.allPrimaryColor,
                                        fontWeight: FontWeight.w600,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      UIHelper.verticalSpace(40.h),

                      // Sign Up Button
                      customButton(
                        onPressed: _isLoading ? null : _signUp,
                        title: _isLoading
                            ? "Creating Account..."
                            : "Create Account",
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

                // Social Login Buttons
                _buildSocialLoginButtons(),

                UIHelper.verticalSpace(40.h),

                // Login Redirect
                CustomRichTextButton(
                  onPressed: () {
                    NavigationService.navigateTo(Routes.loginScreen);
                  },
                  additionalText: "Already have an Account? ",
                  buttonText: "Sign In",
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
            // Handle Google sign up
          },
        ),
        UIHelper.horizontalSpace(20.w),
        socialLoginButton(
          icon: Icons.facebook,
          onPressed: () {
            // Handle Facebook sign up
          },
        ),
      ],
    );
  }
}
