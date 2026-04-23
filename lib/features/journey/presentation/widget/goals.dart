import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class Goals extends StatelessWidget {
	const Goals({
		super.key,
		this.title = 'Set Your First Goal',
		this.subtitle =
				'Choose your focus - reading, prayer, fasting, or\njournaling. Small steps build your faith journey.',
		this.buttonText = '+ Add New Goal',
		this.onAddGoalPressed,
	});

	final String title;
	final String subtitle;
	final String buttonText;
	final VoidCallback? onAddGoalPressed;

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
			padding: EdgeInsets.fromLTRB(22.w, 24.h, 22.w, 26.h),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: [
					Icon(
						Icons.track_changes_rounded,
						size: 66.sp,
						color: AppColors.c99907A,
					),
					SizedBox(height: 8.h),
					Text(
						title,
						textAlign: TextAlign.center,
						style: TextFontStyle.textStyle24c8C7C68HelveticaNeue400.copyWith(
							fontSize: 20.sp,
							fontWeight: FontWeight.w500,
						),
					),
					SizedBox(height: 2.h),
					Text(
						subtitle,
						textAlign: TextAlign.center,
						style: TextFontStyle.textStyle12c99907AHelveticaNeue400.copyWith(
							fontSize: 14.sp,
							height: 1.42,
						),
					),
					SizedBox(height: 14.h),
					Container(
						decoration: BoxDecoration(
							borderRadius: BorderRadius.circular(1000.r),
							boxShadow: [
								BoxShadow(
									color: AppColors.c513B26.withValues(alpha: 0.14),
									blurRadius: 16.r,
									offset: Offset(0, 8.h),
								),
							],
						),
						child: CustomButton(
							height: 52.h,
							width: 170.w,
							title: buttonText,
							onPressed: onAddGoalPressed,
							borderRadius: BorderRadius.circular(1000.r),
							backgroundGradient: const LinearGradient(
								begin: Alignment.topCenter,
								end: Alignment.bottomCenter,
								colors: [
									AppColors.cC7BFAD,
									AppColors.cB4B197,
								],
							),
							textStyle:
									TextFontStyle.textStyle16cFFFFFFHelveticaNeue500.copyWith(
								color: AppColors.cF5EDD7,
								fontWeight: FontWeight.w500,
							),
						),
					),
				],
			),
		);
	}
}
