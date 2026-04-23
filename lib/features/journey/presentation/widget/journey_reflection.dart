import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
			width: double.infinity,
			color: AppColors.scaffoldColor,
			padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 20.h),
			child: SizedBox(
				height: 202.h,
				child: Stack(
					clipBehavior: Clip.none,
					children: [
						Positioned.fill(
							top: 18.h,
							child: CustomPaint(
								painter: _ScallopedBottomBorderPainter(
									color: AppColors.c8C7C68.withValues(alpha: 0.38),
								),
								child: Container(
									padding: EdgeInsets.fromLTRB(18.w, 52.h, 18.w, 20.h),
									decoration: BoxDecoration(
										color: AppColors.cC7BFAD,
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
											Text(
												mainText,
												textAlign: TextAlign.center,
												style: TextFontStyle
														.textStyle16c000000Inter500
														.copyWith(
															color: AppColors.allsecondaryColor,
															fontSize: 18.sp,
															fontFamily: 'Helvetica Neue',
															fontWeight: FontWeight.w400,
															height: 1.35,
														),
											),
											SizedBox(height: 12.h),
											SizedBox(
												height: 10.h,
												width: double.infinity,
												child: CustomPaint(
													painter: _SoftDividerPainter(
														color: AppColors.c8C7C68.withValues(alpha: 0.45),
													),
												),
											),
											SizedBox(height: 10.h),
											Text(
												subText,
												textAlign: TextAlign.center,
												style: TextFontStyle
														.textStyle14c3B230EHelveticaNeue400
														.copyWith(
															color: AppColors.c685E4A,
															fontSize: 14.sp,
															fontWeight: FontWeight.w400,
														),
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
								height: 46.h,
								decoration: BoxDecoration(
									borderRadius: BorderRadius.circular(30.r),
									gradient: const LinearGradient(
										begin: Alignment.topCenter,
										end: Alignment.bottomCenter,
										colors: [
											AppColors.cF5EDD7,
											AppColors.cDED7C5,
										],
									),
									boxShadow: [
										BoxShadow(
											color: AppColors.c513B26.withValues(alpha: 0.26),
											blurRadius: 18.r,
											offset: Offset(0, 9.h),
										),
									],
								),
								alignment: Alignment.center,
								child: Text(
									title,
									textAlign: TextAlign.center,
									style: TextFontStyle.textStyle14c3B230EHelveticaNeue500
											.copyWith(
												fontSize: 32.sp / 2,
												fontWeight: FontWeight.w700,
											),
								),
							),
						),
					],
				),
			),
		);
	}
}

class _SoftDividerPainter extends CustomPainter {
	const _SoftDividerPainter({required this.color});

	final Color color;

	@override
	void paint(Canvas canvas, Size size) {
		final Paint paint = Paint()
			..color = color
			..strokeWidth = 1.1.w
			..style = PaintingStyle.stroke
			..strokeCap = StrokeCap.round;

		final Path path = Path()
			..moveTo(0, size.height * 0.55)
			..cubicTo(
				size.width * 0.20,
				size.height * 0.12,
				size.width * 0.40,
				size.height * 0.98,
				size.width * 0.50,
				size.height * 0.55,
			)
			..cubicTo(
				size.width * 0.63,
				size.height * 0.14,
				size.width * 0.83,
				size.height * 0.95,
				size.width,
				size.height * 0.50,
			);

		canvas.drawPath(path, paint);
	}

	@override
	bool shouldRepaint(covariant _SoftDividerPainter oldDelegate) {
		return oldDelegate.color != color;
	}
}

class _ScallopedBottomBorderPainter extends CustomPainter {
	const _ScallopedBottomBorderPainter({required this.color});

	final Color color;

	@override
	void paint(Canvas canvas, Size size) {
		final Paint paint = Paint()
			..color = color
			..strokeWidth = 1.2.w
			..style = PaintingStyle.stroke
			..strokeCap = StrokeCap.round;

		final double radius = 9.r;
		final int count = math.max(1, (size.width / (radius * 2)).floor());
		final double step = size.width / count;
		final double y = size.height - 0.6.h;

		for (int i = 0; i < count; i++) {
			final Rect arcRect = Rect.fromCenter(
				center: Offset(step * i + (step / 2), y),
				width: step,
				height: radius * 2,
			);
			canvas.drawArc(arcRect, math.pi, math.pi, false, paint);
		}
	}

	@override
	bool shouldRepaint(covariant _ScallopedBottomBorderPainter oldDelegate) {
		return oldDelegate.color != color;
	}
}
