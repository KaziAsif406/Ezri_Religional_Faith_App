import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../gen/colors.gen.dart';
import 'widget/anchor_type.dart';

class AddFaithAnchorScreen extends StatefulWidget {
	const AddFaithAnchorScreen({super.key});

	@override
	State<AddFaithAnchorScreen> createState() => _AddFaithAnchorScreenState();
}

class _AddFaithAnchorScreenState extends State<AddFaithAnchorScreen> {
	final TextEditingController _referenceController =
			TextEditingController(text: 'Philippians 4:13');
	final TextEditingController _contentController = TextEditingController(
		text: 'I can do all things through Christ who strengthens me.',
	);
	final TextEditingController _noteController = TextEditingController(
		text: 'This reminds me to rely on His strength when I feel weak.',
	);

	AnchorTypeOption _selectedType = AnchorTypeOption.quote;
	bool _isPersonalNoteEnabled = true;

	@override
	void dispose() {
		_referenceController.dispose();
		_contentController.dispose();
		_noteController.dispose();
		super.dispose();
	}

	int _wordCount(String text) {
		return text
				.trim()
				.split(RegExp(r'\s+'))
				.where((word) => word.isNotEmpty)
				.length;
	}

	@override
	Widget build(BuildContext context) {
		final int contentWords = _wordCount(_contentController.text);
		final int noteWords = _wordCount(_noteController.text);

		return Scaffold(
			backgroundColor: AppColors.scaffoldColor,
			body: SingleChildScrollView(
				physics: const BouncingScrollPhysics(),
				child: Column(
					children: [
						SizedBox(
							height: 280.h,
							child: Stack(
								children: [
									SizedBox(
										width: double.infinity,
										height: 235.h,
										child: Image.asset(
											'assets/images/header.png',
											fit: BoxFit.cover,
										),
									),
									Positioned(
										top: 70.h,
										left: 24.w,
										right: 24.w,
										child: Row(
											children: [
												GestureDetector(
													onTap: () => Navigator.of(context).pop(),
													child: Container(
														width: 58.w,
														height: 58.w,
														decoration: BoxDecoration(
															shape: BoxShape.circle,
															border: Border.all(
																color: AppColors.cF5EDD7.withValues(alpha: 0.75),
																width: 1.6.w,
															),
															color: Colors.transparent,
														),
														child: Icon(
															Icons.arrow_back_ios_new_rounded,
															color: AppColors.cF5EDD7,
															size: 22.sp,
														),
													),
												),
												SizedBox(width: 16.w),
												Expanded(
													child: Text(
														'Edit Faith Anchor',
														style: TextFontStyle.textStyle28cFFFFFFHelveticaNeue700,
													),
												),
											],
										),
									),
									Positioned(
										bottom: 0,
										left: 0,
										right: 0,
										child: Container(
											height: 78.h,
											decoration: BoxDecoration(
												color: AppColors.scaffoldColor,
												borderRadius: BorderRadius.vertical(
													top: Radius.circular(26.r),
												),
											),
										),
									),
								],
							),
						),
						Padding(
							padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 28.h),
							child: Column(
								crossAxisAlignment: CrossAxisAlignment.start,
								children: [
									Text(
										'Anchor Type',
										style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
											fontSize: 17.sp,
										),
									),
									SizedBox(height: 12.h),
									AnchorTypeSelector(
										selectedType: _selectedType,
										onChanged: (AnchorTypeOption value) {
											setState(() {
												_selectedType = value;
											});
										},
									),
									SizedBox(height: 26.h),
									Text(
										'Referance',
										style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
											fontSize: 17.sp,
										),
									),
									SizedBox(height: 12.h),
									_FormInputCard(
										minHeight: 78.h,
										child: TextField(
											controller: _referenceController,
											style: TextFontStyle.textStyle20c3B230EHelveticaNeue400,
											decoration: const InputDecoration(
												border: InputBorder.none,
												isCollapsed: true,
											),
										),
									),
									SizedBox(height: 24.h),
									Text(
										'Content',
										style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
											fontSize: 17.sp,
										),
									),
									SizedBox(height: 12.h),
									_FormInputCard(
										minHeight: 236.h,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.end,
											children: [
												TextField(
													controller: _contentController,
													maxLines: 5,
													onChanged: (_) => setState(() {}),
													style: TextFontStyle.textStyle20c3B230EHelveticaNeue400,
													decoration: const InputDecoration(
														border: InputBorder.none,
														isCollapsed: true,
													),
												),
												SizedBox(height: 18.h),
												Text(
													'$contentWords/200 words',
													style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400
															.copyWith(fontSize: 16.sp),
												),
											],
										),
									),
									SizedBox(height: 24.h),
									Row(
										children: [
											Text(
												'Personal note',
												style:
														TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
													fontSize: 17.sp,
												),
											),
											const Spacer(),
											SizedBox(
												width: 90.w,
												child: Switch(
													value: _isPersonalNoteEnabled,
													onChanged: (bool value) {
														setState(() {
															_isPersonalNoteEnabled = value;
														});
													},
													activeThumbColor: AppColors.cE5EAEB,
													activeTrackColor:
															AppColors.allsecondaryColor.withValues(alpha: 0.95),
													inactiveThumbColor: AppColors.c99907A,
													inactiveTrackColor: AppColors.allPrimaryColor,
												),
											),
										],
									),
									SizedBox(height: 8.h),
									_FormInputCard(
										minHeight: 220.h,
										child: Column(
											crossAxisAlignment: CrossAxisAlignment.end,
											children: [
												TextField(
													enabled: _isPersonalNoteEnabled,
													controller: _noteController,
													maxLines: 4,
													onChanged: (_) => setState(() {}),
													style: TextFontStyle.textStyle20c3B230EHelveticaNeue400,
													decoration: const InputDecoration(
														border: InputBorder.none,
														isCollapsed: true,
													),
												),
												SizedBox(height: 18.h),
												Text(
													'$noteWords/96 words',
													style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400
															.copyWith(fontSize: 16.sp),
												),
											],
										),
									),
									SizedBox(height: 38.h),
									CustomButton(
										onPressed: () {},
										title: 'Save Faith Anchor',
										height: 64.h,
										borderRadius: BorderRadius.circular(40.r),
										backgroundGradient: const LinearGradient(
											begin: Alignment.topCenter,
											end: Alignment.bottomCenter,
											colors: [
												Color(0xFFD0C8B7),
												Color(0xFF6B2F45),
											],
										),
										titleGradient: const LinearGradient(
											begin: Alignment.topCenter,
											end: Alignment.bottomCenter,
											colors: [
												Color(0xFFFFFFFF),
												Color(0xFFF5EDD7),
											],
										),
										textStyle: TextFontStyle.textStyle20cFFFFFFHelveticaNeue700
												.copyWith(fontWeight: FontWeight.w600),
									),
									SizedBox(height: 16.h),
								],
							),
						),
					],
				),
			),
		);
	}
}

class _FormInputCard extends StatelessWidget {
	const _FormInputCard({
		required this.child,
		required this.minHeight,
	});

	final Widget child;
	final double minHeight;

	@override
	Widget build(BuildContext context) {
		return Container(
			width: double.infinity,
			constraints: BoxConstraints(minHeight: minHeight),
			padding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h),
			decoration: BoxDecoration(
				color: AppColors.allPrimaryColor.withValues(alpha: 0.58),
				borderRadius: BorderRadius.circular(26.r),
				border: Border.all(
					color: AppColors.c99907A.withValues(alpha: 0.18),
					width: 1.w,
				),
			),
			child: child,
		);
	}
}
