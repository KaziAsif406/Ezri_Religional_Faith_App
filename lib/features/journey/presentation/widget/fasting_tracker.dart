import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class FastingTracker extends StatelessWidget {
	const FastingTracker({
		super.key,
		this.title = 'Your journey begins here.',
		this.subtitle = 'Track, log, and reflect on your fasting journey',
		this.buttonText = 'Start Your First light',
		this.onStartPressed,
	});

	final String title;
	final String subtitle;
	final String buttonText;
	final VoidCallback? onStartPressed;

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			decoration: BoxDecoration(
				color: AppColors.cC7BFAD,
				borderRadius: BorderRadius.circular(24.r),
				border: Border.all(
					color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
					width: 1.w,
				),
			),
			padding: EdgeInsets.fromLTRB(22.w, 35.h, 22.w, 24.h),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: [
					Image.asset(
            'assets/icons/Fire_Empty.png',
            width: 64.w,
            height: 64.w,
          ),
					SizedBox(height: 16.h),
					Text(
						title,
						textAlign: TextAlign.center,
						style: TextFontStyle.textStyle20c8C7C68HelveticaNeue500.copyWith(
              fontSize: 24.sp,
            ),
					),
					SizedBox(height: 8.h),
					Text(
						subtitle,
						textAlign: TextAlign.center,
						style: TextFontStyle.textStyle14c99907AHelveticaNeue400,
					),
					SizedBox(height: 16.h),
					CustomButton(
						height: 52.h,
						width: 227.w,
						title: buttonText,
						onPressed: onStartPressed,
						borderRadius: BorderRadius.circular(1000.r),
						backgroundGradient: LinearGradient(
							begin: Alignment.topCenter,
							end: Alignment.bottomCenter,
							colors: [
								AppColors.cF5EDD7.withValues(alpha: 0.76),
                AppColors.c6B2F45.withValues(alpha: 0.92),
							],
						),
						textStyle: TextFontStyle.textStyle16cFFFFFFHelveticaNeue500.copyWith(
							color: AppColors.cF5EDD7,
							fontWeight: FontWeight.w500,
						),
					),
				],
			),
		);
	}
}
