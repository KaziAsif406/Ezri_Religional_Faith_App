import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/common_widgets/custom_textform_field.dart';
import 'package:template_flutter/common_widgets/selector_widget.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../gen/colors.gen.dart';

enum AnchorTypeOption { verse, quote, affirmation }

class AddFaithAnchorScreen extends StatefulWidget {
  const AddFaithAnchorScreen({super.key});

  @override
  State<AddFaithAnchorScreen> createState() => _AddFaithAnchorScreenState();
}

class _AddFaithAnchorScreenState extends State<AddFaithAnchorScreen> {
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

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
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/header_1.png',
                  fit: BoxFit.cover,
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
                            color: const Color.fromARGB(17, 255, 255, 255),
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
                          style:
                              TextFontStyle.textStyle28cFFFFFFHelveticaNeue700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 28.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Anchor Type',
                    style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400,
                  ),
                  SizedBox(height: 12.h),
                  SelectorWidget<AnchorTypeOption>(
                    selectedValue: _selectedType,
                    selectedBorderColor: AppColors.allPrimaryColor.withValues(alpha: 0.85),
                    unselectedBorderColor: AppColors.c99907A.withValues(alpha: 0.00),
                    selectedButtonGradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 247, 246, 244).withValues(alpha: 0.22),
                        Color.fromARGB(255, 175, 168, 155).withValues(alpha: 0.22),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    options: const [
                      SelectorOption<AnchorTypeOption>(
                        value: AnchorTypeOption.verse,
                        label: 'Verse',
                      ),
                      SelectorOption<AnchorTypeOption>(
                        value: AnchorTypeOption.quote,
                        label: 'Quote',
                      ),
                      SelectorOption<AnchorTypeOption>(
                        value: AnchorTypeOption.affirmation,
                        label: 'Affirmation',
                      ),
                    ],
                    onChanged: (AnchorTypeOption value) {
                      setState(() {
                        _selectedType = value;
                      });
                    },
                  ),
                  // SizedBox(height: 26.h),
                  CustomTextFormField(
                    label: 'Reference',
                    hintText: 'Add scripture reference',
                    maxLines: 1,
                    controller: _referenceController,
                    useCardStyle: true,
                    cardBackgroundColor: AppColors.allPrimaryColor,
                    cardBorderRadius: BorderRadius.circular(20.r),
                    cardPadding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h),
                    contentPadding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 24.h),
                  CustomTextFormField(
                    label: 'Content',
                    hintText: 'Write the faith anchor content',
                    controller: _contentController,
                    maxLines: 4,
                    onChanged: (_) => setState(() {}),
                    useCardStyle: true,
                    cardBackgroundColor: AppColors.allPrimaryColor,
                    cardBorderRadius: BorderRadius.circular(20.r),
                    cardPadding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h),
                    contentPadding: EdgeInsets.zero,
                    footerRight: Text(
                      '$contentWords/200 words',
                      style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400
                          .copyWith(fontSize: 16.sp),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Stack(
                    children: [
                      Row(
                        children: [
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
                              activeTrackColor: AppColors.allsecondaryColor
                                  .withValues(alpha: 0.95),
                              inactiveThumbColor: AppColors.c99907A,
                              inactiveTrackColor: AppColors.allPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      CustomTextFormField(
                        label: 'Personal note',
                        hintText: 'Add a private reflection',
                        controller: _noteController,
                        enabled: _isPersonalNoteEnabled,
                        maxLines: 3,
                        minLines: 3,
                        onChanged: (_) => setState(() {}),
                        useCardStyle: true,
                        cardBackgroundColor: AppColors.allPrimaryColor,
                        cardBorderRadius: BorderRadius.circular(20.r),
                        cardPadding: EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h),
                        contentPadding: EdgeInsets.zero,
                        footerRight: Text(
                          '$noteWords/96 words',
                          style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400
                              .copyWith(fontSize: 16.sp),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 38.h),
                  CustomButton(
                    onPressed: () {},
                    title: 'Save Faith Anchor',
                    height: 60.h,
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