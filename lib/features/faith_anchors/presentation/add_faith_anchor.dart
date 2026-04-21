import 'package:flutter/material.dart';
import 'package:template_flutter/common_widgets/custom_switch.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/common_widgets/custom_textform_field.dart';
import 'package:template_flutter/common_widgets/selector_widget.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/faith_anchors/presentation/widget/faith_anchor_store.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

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

  String _anchorTypeLabel(AnchorTypeOption type) {
    switch (type) {
      case AnchorTypeOption.verse:
        return 'Verse';
      case AnchorTypeOption.quote:
        return 'Quote';
      case AnchorTypeOption.affirmation:
        return 'Affirmation';
    }
  }

  void _saveFaithAnchor() {
    final String content = _contentController.text.trim();
    if (content.isEmpty) {
      return;
    }

    FaithAnchorStore.instance.addItem(
      type: _anchorTypeLabel(_selectedType),
      reference: _referenceController.text.trim(),
      content: content,
      personalNote: _isPersonalNoteEnabled ? _noteController.text.trim() : '',
    );

    Navigator.of(context).pop();
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
            CustomAppBar(
              titleText: 'Edit Faith Anchor',
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
                    horizontalPadding: 29.w,
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
                        value: AnchorTypeOption.affirmation,
                        label: 'Affirmation',
                      ),
                      SelectorOption<AnchorTypeOption>(
                        value: AnchorTypeOption.quote,
                        label: 'Quote',
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
                  UIHelper.verticalSpace(24.h),
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
                  SizedBox(height: 12.h),
                  Stack(
                    children: [
                      // UIHelper.verticalSpace(30.h),
                      CustomTextFormField(
                        label: '\nPersonal note',
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
                      Positioned(
                        right: 0,
                        top: 8.h,
                        child: CustomSwitch(
                          value: _isPersonalNoteEnabled,
                          onChanged: (bool value) {
                            setState(() {
                              _isPersonalNoteEnabled = value;
                            });
                          },
                          width: 48,
                          height: 28,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 38.h),
                  CustomButton(
                    onPressed: _saveFaithAnchor,
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