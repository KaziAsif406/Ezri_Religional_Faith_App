import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
				color: AppColors.scaffoldColor,
				borderRadius: BorderRadius.circular(34.r),
				border: Border.all(
					color: AppColors.cCFC7B6.withValues(alpha: 0.95),
					width: 1.2.w,
				),
				boxShadow: [
					BoxShadow(
						color: AppColors.c513B26.withValues(alpha: 0.08),
						blurRadius: 18.r,
						offset: Offset(0, 4.h),
					),
				],
			),
			padding: EdgeInsets.fromLTRB(18.w, 24.h, 18.w, 22.h),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: [
					Container(
						width: 128.w,
						height: 128.w,
						decoration: BoxDecoration(
							shape: BoxShape.circle,
							color: AppColors.cB4B197,
							border: Border.all(
								color: AppColors.c796956.withValues(alpha: 0.75),
								width: 1.4.w,
							),
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
							Assets.icons.bible.path,
							width: 46.w,
							height: 46.w,
							color: AppColors.c675440,
						),
					),
					SizedBox(height: 22.h),
					Text(
						title,
						textAlign: TextAlign.center,
						style: TextFontStyle.textStyle24c3B230EHelveticaNeue700.copyWith(
							color: AppColors.cA29783,
							fontSize: 30.sp,
							height: 1.05,
						),
					),
					SizedBox(height: 10.h),
					Text(
						subtitle,
						textAlign: TextAlign.center,
						style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400.copyWith(
							color: AppColors.cA29783.withValues(alpha: 0.8),
							fontSize: 18.sp,
							height: 1.42,
						),
					),
					SizedBox(height: 30.h),
					GestureDetector(
						onTap: onAddJourneyPressed,
						child: Container(
							width: 332.w,
							height: 98.h,
							decoration: BoxDecoration(
								borderRadius: BorderRadius.circular(50.r),
								gradient: LinearGradient(
									begin: Alignment.topCenter,
									end: Alignment.bottomCenter,
									colors: [
										AppColors.cB9C7CF.withValues(alpha: 0.55),
										AppColors.cCFC7B6,
									],
								),
								border: Border.all(
									color: AppColors.cE5EAEB.withValues(alpha: 0.5),
									width: 1.w,
								),
								boxShadow: [
									BoxShadow(
										color: AppColors.c513B26.withValues(alpha: 0.10),
										blurRadius: 22.r,
										offset: Offset(0, 10.h),
									),
								],
							),
							alignment: Alignment.center,
							child: Text(
								buttonText,
								textAlign: TextAlign.center,
								style: TextFontStyle.textStyle24c3B230EHelveticaNeue500.copyWith(
									color: AppColors.cF5EDD7,
									fontSize: 30.sp,
									height: 1,
									shadows: [
										Shadow(
											color: AppColors.c513B26.withValues(alpha: 0.18),
											blurRadius: 6.r,
											offset: Offset(0, 1.h),
										),
									],
								),
							),
						),
					),
				],
			),
		);
	}
}
