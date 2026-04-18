import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/common_widgets/custom_textform_field.dart';
import 'package:template_flutter/common_widgets/selector_widget.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/helpers/navigation_service.dart';

import '../../../gen/colors.gen.dart';

enum SacredTypeOption { reflection, memoryVerses, journaling, bibleReading, prayer, fasting }

class AddSacredEntryScreen extends StatefulWidget {
  const AddSacredEntryScreen({super.key});

  @override
  State<AddSacredEntryScreen> createState() => _AddSacredEntryScreenState();
}

class _AddSacredEntryScreenState extends State<AddSacredEntryScreen> {
  final TextEditingController _entryController = TextEditingController(
    text:
        "Today, I'm grateful for the opportunity to learn and grow, and for the connections I've made with people from all over the world.",
  );
  final TextEditingController _verseController = TextEditingController();

  SacredTypeOption _selectedType = SacredTypeOption.reflection;
  bool _promptEnabled = false;
  DateTime _selectedDate = DateTime(2024, 6, 15);

  @override
  void dispose() {
    _entryController.dispose();
    _verseController.dispose();
    super.dispose();
  }

  int _wordCount(String text) {
    return text
        .trim()
        .split(RegExp(r'\s+'))
        .where((String word) => word.isNotEmpty)
        .length;
  }

  String _formattedDate(DateTime date) {
    const List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final int words = _wordCount(_entryController.text);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                SizedBox(
                  height: 220.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/header_1.png',
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
                          'New Sacred Entry',
                          style: TextFontStyle.textStyle28cFFFFFFHelveticaNeue700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(0, -25.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle(
                      lightText: 'Select',
                      darkText: 'Date',
                    ),
                    SizedBox(height: 12.h),

                    // CustomTextFormField(
                    //   controller: TextEditingController(
                    //     text: _formattedDate(_selectedDate),
                    //   ),
                    //   useCardStyle: true,
                    //   height: 90.h,
                    //   cardBackgroundColor:
                    //       AppColors.allPrimaryColor.withValues(alpha: 0.72),
                    //   cardBorderColor:
                    //       AppColors.c99907A.withValues(alpha: 0.18),
                    //   cardBorderRadius: BorderRadius.circular(20.r),
                    //   cardPadding: EdgeInsets.fromLTRB(20.w, 8.h, 8.w, 8.h),
                    //   // contentPadding: EdgeInsets.zero,
                    //   suffixIcon: Positioned(
                    //     top: 0.h,
                    //     right: 0.w,
                    //     child: GestureDetector(
                    //       onTap: () {
                    //         // Handle date picker tap
                    //       },
                    //       child: Container(
                    //         width: 44.w,
                    //         height: 44.w,
                    //         decoration: BoxDecoration(
                    //           shape: BoxShape.circle,
                    //           color:
                    //               AppColors.cF5F6F5.withValues(alpha: 0.12),
                    //           boxShadow: [
                    //             BoxShadow(
                    //               color: AppColors.c1C1919
                    //                   .withValues(alpha: 0.10),
                    //               blurRadius: 5.r,
                    //               offset: Offset(0, 4.h),
                    //             ),
                    //           ],
                    //         ),
                    //         child: Icon(
                    //           Icons.calendar_month_outlined,
                    //           size: 22.sp,
                    //           color: AppColors.c513B26,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),

                    _RoundedInputShell(
                      child: Row(
                        children: [
                          Text(
                            _formattedDate(_selectedDate),
                            style: TextFontStyle
                                .textStyle14c3B230EHelveticaNeue300
                                .copyWith(
                              fontSize: 16.sp,
                              color: AppColors.c685E4A,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.allPrimaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.c1C1919
                                        .withValues(alpha: 0.20),
                                    blurRadius: 8.r,
                                    offset: Offset(0, 4.h),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.calendar_month_outlined,
                                size: 22.sp,
                                color: AppColors.c513B26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    _SectionTitle(
                      lightText: 'Sacred',
                      darkText: 'Type',
                    ),
                    SizedBox(height: 12.h),
                    SelectorWidget<SacredTypeOption>(
                      selectedValue: _selectedType,
                      height: 64.h,
                      // width: double.infinity,
                      spacing: 14.w,
                      borderRadius: BorderRadius.circular(24.r),
                      horizontalPadding: 12.w,
                      selectedButtonGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.cF5F6F5.withValues(alpha: 0.36),
                          AppColors.allPrimaryColor.withValues(alpha: 0.72),
                        ],
                      ),
                      unselectedButtonGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.allPrimaryColor.withValues(alpha: 0.28),
                          AppColors.allPrimaryColor.withValues(alpha: 0.44),
                        ],
                      ),
                      selectedBorderColor: AppColors.allsecondaryColor,
                      unselectedBorderColor: AppColors.c99907A.withValues(alpha: 0.22),

                      selectedTextStyle: TextFontStyle
                          .textStyle16c796956HelveticaNeue400
                          .copyWith(
                        fontSize: 15.sp,
                        color: AppColors.c352619,
                        fontWeight: FontWeight.w500,
                      ),
                      unselectedTextStyle: TextFontStyle
                          .textStyle16c796956HelveticaNeue400
                          .copyWith(
                        fontSize: 15.sp,
                        color: AppColors.c8C7C68,
                        fontWeight: FontWeight.w400,
                      ),
                      options: <SelectorOption<SacredTypeOption>>[
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.reflection,
                          label: 'Reflection',
                          leading: Image.asset(
                            'assets/icons/reflection.png',
                            width: 36.w,
                            height: 36.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.memoryVerses,
                          label: 'Memory Verses',
                          leading: Image.asset(
                            'assets/icons/memory.png',
                            width: 36.w,
                            height: 36.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.journaling,
                          label: 'Journaling',
                          leading: Image.asset(
                            'assets/icons/journaling.png',
                            width: 36.w,
                            height: 36.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                      onChanged: (SacredTypeOption value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                    SizedBox(height: 34.h),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: _SectionTitle(
                            lightText: 'Prompt',
                            darkText: 'Selector',
                          ),
                        ),
                        SizedBox(
                          width: 48.w,
                          child: Transform.scale(
                            scale: 1.0,
                            child: CupertinoSwitch(
                              value: _promptEnabled,
                              onChanged: (bool value) {
                                setState(() {
                                  _promptEnabled = value;
                                });
                              },
                              
                              activeTrackColor: AppColors.allsecondaryColor
                                  .withValues(alpha: 0.45),
                              inactiveThumbColor: AppColors.allPrimaryColor,
                              inactiveTrackColor:
                                  AppColors.c99907A.withValues(alpha: 0.45),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    const _WavySeparator(
                      
                    ),
                    SizedBox(height: 26.h),
                    _SectionTitle(
                      lightText: 'Sacred',
                      darkText: 'Entry',
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _RoundActionButton(
                          icon: Icons.mic_none_rounded,
                          onTap: () {},
                          filled: true,
                        ),
                        SizedBox(width: 26.w),
                        _RoundActionButton(
                          iconText: 'Aa',
                          onTap: () {},
                          filled: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'What are you grateful for today?',
                      style: TextFontStyle.textStyle14c3B230EHelveticaNeue400,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextFormField(
                      controller: _entryController,
                      maxLines: 5,
                      minLines: 5,
                      onChanged: (_) => setState(() {}),
                      useCardStyle: true,
                      cardBackgroundColor:
                          AppColors.allPrimaryColor,
                      cardBorderColor:
                          AppColors.c99907A.withValues(alpha: 0.48),
                      cardBorderRadius: BorderRadius.circular(24.r),
                      cardPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                      contentPadding: EdgeInsets.zero,
                      footerLeft: const _TextEditingFooterButtons(),
                      footerRight: Text(
                        '$words/300 words',
                        style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400
                            .copyWith(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    const _WavySeparator(),
                    SizedBox(height: 26.h),
                    Text(
                      'Verses',
                      style: TextFontStyle.textStyle24c8C7C68HelveticaNeue300,
                    ),
                    SizedBox(height: 14.h),
                    _RoundedInputShell(
                      child: Row(
                        children: [
                          Text(
                            'Attach a Verse',
                            style: TextFontStyle
                                .textStyle14c3B230EHelveticaNeue300
                                .copyWith(
                              fontSize: 16.sp,
                              color: AppColors.c685E4A,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.allPrimaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.c1C1919
                                        .withValues(alpha: 0.20),
                                    blurRadius: 8.r,
                                    offset: Offset(0, 4.h),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.attach_file_rounded,
                                size: 22.sp,
                                color: AppColors.c513B26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 34.h),
                    CustomButton(
                      onPressed: () {},
                      title: 'Save Entry',
                      height: 60.h,
                      borderRadius: BorderRadius.circular(5555.r),
                      backgroundGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.cF5EDD7.withValues(alpha: 0.76),
                          AppColors.c6B2F45.withValues(alpha: 0.92),
                        ],
                      ),
                      textStyle: TextFontStyle
                          .textStyle16cFFFFFFHelveticaNeue500
                          .copyWith(
                        color: AppColors.cF5EDD7,
                      ),
                    ),
                    SizedBox(height: 42.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.lightText, required this.darkText});

  final String lightText;
  final String darkText;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '$lightText ',
            style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
              fontSize: 24.sp,
              color: AppColors.c8C7C68,
            ),
          ),
          TextSpan(
            text: darkText,
            style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400.copyWith(
              fontSize: 24.sp,
              color: AppColors.c352619,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _RoundedInputShell extends StatelessWidget {
  const _RoundedInputShell({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      // constraints: BoxConstraints(minHeight: 60.h),
      padding: EdgeInsets.fromLTRB(20.w, 8.h, 5.w, 8.h),
      decoration: BoxDecoration(
        color: AppColors.allPrimaryColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
          width: 1.w,
        ),
      ),
      child: child,
    );
  }
}

class _RoundActionButton extends StatelessWidget {
  const _RoundActionButton({
    required this.onTap,
    required this.filled,
    this.icon,
    this.iconText,
  });

  final VoidCallback onTap;
  final bool filled;
  final IconData? icon;
  final String? iconText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 96.w,
        height: 96.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: filled
              ? AppColors.allPrimaryColor
              : AppColors.allPrimaryColor.withValues(alpha: 0.56),
          border: Border.all(
            color: AppColors.c99907A.withValues(alpha: 0.18),
            width: 2.w,
          ),
          boxShadow: filled
              ? null
              : <BoxShadow>[
                  BoxShadow(
                    color: AppColors.c1C1919.withValues(alpha: 0.14),
                    blurRadius: 16.r,
                    offset: Offset(0, 8.h),
                  ),
                ],
        ),
        child: Center(
          child: icon != null
              ? Icon(
                  icon,
                  size: 36.sp,
                  color: AppColors.c513B26,
                )
              : Text(
                  iconText ?? '',
                  style:
                      TextFontStyle.textStyle20c3B230EHelveticaNeue400.copyWith(
                    fontSize: 22.sp,
                    color: AppColors.c513B26,
                  ),
                ),
        ),
      ),
    );
  }
}

class _TextEditingFooterButtons extends StatelessWidget {
  const _TextEditingFooterButtons();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _FooterCircleButton(
          label: 'B',
          style: TextFontStyle.textStyle14c3B230EHelveticaNeue500,
        ),
        SizedBox(width: 10.w),
        _FooterCircleButton(
          label: 'I',
          style: TextFontStyle.textStyle14c3B230EHelveticaNeue400.copyWith(
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(width: 10.w),
        _FooterCircleButton(
          label: 'U',
          style: TextFontStyle.textStyle14c3B230EHelveticaNeue400.copyWith(
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    );
  }
}

class _FooterCircleButton extends StatelessWidget {
  const _FooterCircleButton({required this.label, required this.style});

  final String label;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color.fromARGB(255, 230, 225, 213).withValues(alpha: 0.84),
        boxShadow: [
          BoxShadow(
            color: AppColors.c1C1919.withValues(alpha: 0.10),
            blurRadius: 4.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Center(
        child: Text(label, style: style.copyWith(fontSize: 14.sp)),
      ),
    );
  }
}

class _WavySeparator extends StatelessWidget {
  const _WavySeparator();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 5.h,
      child: CustomPaint(
        painter: _WavyLinePainter(),
      ),
    );
  }
}

class _WavyLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = AppColors.cF5EDD7.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5.w;

    final Path path = Path();
    const double waves = 15;
    final double segment = size.width / waves;

    path.moveTo(0, size.height / 2);
    for (double i = 0; i < waves; i++) {
      final double startX = i * segment;
      final double endX = startX + segment;
      path.quadraticBezierTo(
        startX + segment / 2,
        i % 2 == 0 ? 0 : size.height,
        endX,
        size.height / 2,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
