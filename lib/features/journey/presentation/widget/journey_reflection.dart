import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/wavy_separator.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class JourneyReflection extends StatelessWidget {
	const JourneyReflection({
		super.key,
		this.title = "Ezri's first Weekly Reflection",
		this.mainText = '“Start your first reflection\n to see God\'s word in your journey.”',
		this.subText = 'Your word is a lamp to my feet, a light to my path.',
	});

	final String title;
	final String mainText;
	final String subText;

	@override
	Widget build(BuildContext context) {
		return Container(
      width: 380.w,
			height: 202.h,
			child: Stack(
				clipBehavior: Clip.none,
				children: [
					Positioned.fill(
						top: 18.h,
						child: Container(
              height: 162.h,
              width: 390.w,
              decoration: BoxDecoration(
                color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Container(
                height: 154.h,
                width: 382.w,
                padding: EdgeInsets.fromLTRB(18.w, 52.h, 18.w, 20.h),
                decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  AppColors.allsecondaryColor.withValues(alpha: 0.1),
                                  AppColors.allsecondaryColor.withValues(alpha: 0.3),
                                ],
                              ),
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.c513B26.withValues(alpha: 0.18),
                      blurRadius: 16.r,
                      offset: Offset(0, 8.h),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(
                      width: 290.w,
                      child: Text(
                        mainText,
                        textAlign: TextAlign.center,
                        style: TextFontStyle.textStyle16c3B230EHelveticaNeue400.copyWith(
                          height: 1.4,
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    WavySeparator(
                      color: AppColors.allPrimaryColor.withValues(alpha: 0.15),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      subText,
                      textAlign: TextAlign.center,
                      style: TextFontStyle
                          .textStyle14c513B26HelveticaNeue300,
                    ),
                  ],
                ),
              ),
            ),
					),
					Positioned(
						left: 60.w,
						right: 60.w,
						top: 0,
						child: Container(
							height: 44.h,
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(60.r),
								gradient: const LinearGradient(
									begin: Alignment.topCenter,
									end: Alignment.bottomCenter,
									colors: [
										AppColors.cF5EDD7,
										Color.fromARGB(255, 182, 176, 159),
									],
								),
								boxShadow: [
									BoxShadow(
										color: AppColors.c513B26.withValues(alpha: 0.26),
										blurRadius: 8.r,
										offset: Offset(0, 9.h),
									),
								],
							),
							alignment: Alignment.center,
							child: Text(
								title,
								textAlign: TextAlign.center,
								style: TextFontStyle.textStyle16c3B230EHelveticaNeue500,
							),
						),
					),
				],
			),
		);
	}
}


