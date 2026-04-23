import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/assets.gen.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class JourneyProgress extends StatelessWidget {
	const JourneyProgress({
		super.key,
		this.title = 'Your progress starts here',
		this.subtitle = 'Track your reading, prayers, and milestones — every\nstep counts on your journey.',
		this.buttonText = 'Add journey',
		this.onAddJourneyPressed,
	});

	final String title;
	final String subtitle;
	final String buttonText;
	final VoidCallback? onAddJourneyPressed;

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			decoration: BoxDecoration(
				color: AppColors.allPrimaryColor,
				borderRadius: BorderRadius.circular(24.r),
				border: Border.all(
					color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
					width: 1.w,
				),
			),
			padding: EdgeInsets.fromLTRB(22.w, 32.h, 22.w, 13.h),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: [
					Container(
						width: 66.w,
						height: 66.w,
            padding: EdgeInsets.all(20.w),
						decoration: BoxDecoration(
							shape: BoxShape.circle,
							color: AppColors.allsecondaryColor.withValues(alpha: 0.28),
							boxShadow: [
								BoxShadow(
									color: Colors.white.withValues(alpha: 0.18),
									blurRadius: 0,
									offset: Offset(0, 1.h),
								),
							],
						),
						alignment: Alignment.center,
						child: Image.asset(
							Assets.icons.journalEmpty.path,
							width: 26.w,
							height: 26.w,
						),
					),
					SizedBox(height: 10.h),
					Text(
						title,
						textAlign: TextAlign.center,
						style: TextFontStyle.textStyle24c8C7C68HelveticaNeue400.copyWith(
							fontSize: 20.sp,
              fontWeight: FontWeight.w500,
						),
					),
					SizedBox(height: 4.h),
					Text(
						subtitle,
						textAlign: TextAlign.center,
						style: TextFontStyle.textStyle12c99907AHelveticaNeue400.copyWith(
							fontSize: 14.sp,
							height: 1.42,
						),
					),
					SizedBox(height: 18.h),
					CustomButton(
            height: 52.h,
            width: 170.w,
						title: buttonText,
						onPressed: onAddJourneyPressed,
            borderRadius: BorderRadius.circular(1000.r),
            backgroundColor: AppColors.allsecondaryColor.withValues(alpha: 0.20),
            textStyle: TextFontStyle.textStyle16cFFFFFFHelveticaNeue500.copyWith(
              fontWeight: FontWeight.w500,
            ),
					)
				],
			),
		);
	}
}
