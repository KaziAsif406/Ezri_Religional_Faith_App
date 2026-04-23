import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:template_flutter/common_widgets/dual_tone_title.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/journey/presentation/widget/journey_reflection.dart';
import 'package:template_flutter/gen/assets.gen.dart';
import 'package:template_flutter/helpers/all_routes.dart';
import 'package:template_flutter/helpers/navigation_service.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

import '../../../gen/colors.gen.dart';


class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}


class _JourneyScreenState extends State<JourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 430.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 22.w,
                  right: 22.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 78.h),
                          child: Text(
                            'Journey',
                            style: TextFontStyle.textStyle32cFFFFFFHelveticaNeue700,
                          ),
                        ),
                      ),
                      // Spacer(),
                      Container(
                        margin: EdgeInsets.only(top: 85.h),
                        width: 88.w,
                        height: 42.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.r),
                          border: Border.all(
                            color: AppColors.cE5EAEB.withValues(alpha: 0.45),
                            width: 2.w,
                          ),
                        ),
                        child: Container(
                          width: 80.w,
                          height: 34.w,
                          margin: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40.r),
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.cF5EDD7,
                                Color.fromARGB(255, 170, 161, 138),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/fire.png',
                                width: 16.w,
                                height: 18.w,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '3 Days',
                                style: TextFontStyle.textStyle14c3B230EHelveticaNeue400,
                              ),
                            ],
                          ),
                        )
                      ),
                      UIHelper.horizontalSpace(12.w),
                      Container(
                        margin: EdgeInsets.only(top: 85.h),
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.cE5EAEB.withValues(alpha: 0.45),
                            width: 2.w,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'J',
                            style: TextFontStyle.textStyle12cFFFFFFHelveticaNeue700.copyWith(
                              fontSize: 28.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(20, -260.h),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/icons/Union.png',
                    width: 60.w,
                    height: 198.h,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 6.h,
                    left: 16.w,
                    child: Row(
                      children: [
                        Container(
                          height: 28.h,
                          width: 28.w,
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: AppColors.allsecondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                          //  'assets/icons/Check.png',
                          Assets.icons.check.path,
                            width: 16.w,
                            height: 16.w,
                          ),
                        ),
                        UIHelper.horizontalSpace(26.w),
                        Text(
                          'Daily Scripture Habit',
                          style: TextFontStyle.textStyle16cFFFFFFHelveticaNeue400.copyWith(
                            color: AppColors.cF0F2F1.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    )
                  ),
                  Positioned(
                    top: 74.h,
                    left: 6.w,
                    child: Row(
                      children: [
                        Container(
                          height: 48.h,
                          width: 48.w,
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: AppColors.cF0F2F1.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/icons/fire.png',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                        UIHelper.horizontalSpace(16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '5-Day Prayer Streak',
                              style: TextFontStyle.textStyle18cFFFFFFHelveticaNeue400,
                            ),
                            UIHelper.verticalSpace(8.h),
                            Row(
                              children: [
                                Image.asset(
                                  'assets/icons/Restart.png',
                                  width: 14.w,
                                  height: 14.h,
                                ),
                                UIHelper.horizontalSpace(4.w),
                                Text(
                                  'Reset',
                                  style: TextFontStyle.textStyle14cF2A918HelveticaNeue400,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 167.h,
                    left: 20.7.w,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/Lock.png',
                          width: 18.w,
                          height: 18.h,
                        ),
                        UIHelper.horizontalSpace(32.w),
                        Text(
                          'Memorize 10 Verses',
                          style: TextFontStyle.textStyle16cFFFFFFHelveticaNeue400.copyWith(
                            color: AppColors.cF0F2F1.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Transform.translate(
              offset: Offset(0, -185.h),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        '“Keep steady, Wade — you’re close to\nyour next milestone”',
                        style: TextFontStyle.textStyle16c238D1AHelveticaNeue400,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    UIHelper.verticalSpace(28.h),
                    JourneyReflection(
                      mainText: '“Start your first reflection to see God’s word in your journey.”',
                      subText: 'Your word is a lamp to my feet, a light to my path.',
                    ),
                    UIHelper.verticalSpace(28.h),
                    DualToneTitle(
                      lightText: 'Progress',
                      darkText: 'Summary',
                      lightTextStyle: TextFontStyle.textStyle24c8C7C68HelveticaNeue300,
                      darkTextStyle: TextFontStyle.textStyle24c3B230EHelveticaNeue500,
                    ),
                    UIHelper.verticalSpace(12.h),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}





// UIHelper.verticalSpace(40.h),
                          