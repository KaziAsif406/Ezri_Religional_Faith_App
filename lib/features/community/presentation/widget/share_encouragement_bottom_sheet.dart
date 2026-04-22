import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/common_widgets/custom_textform_field.dart';
import 'package:template_flutter/common_widgets/dual_tone_title.dart';
import 'package:template_flutter/common_widgets/text_editing_footer_buttons.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/navigation_service.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';



class ShareEncouragementBottomSheet extends StatefulWidget {
  const ShareEncouragementBottomSheet({
    super.key
  });

  @override
  State<ShareEncouragementBottomSheet> createState() => _ShareEncouragementBottomSheetState();
}

class _ShareEncouragementBottomSheetState extends State<ShareEncouragementBottomSheet> {
  final TextEditingController _entryController = TextEditingController();

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

   int _wordCount(String text) {
    return text
        .trim()
        .split(RegExp(r'\s+'))
        .where((String word) => word.isNotEmpty)
        .length;
  }
  @override
  Widget build(BuildContext context) {
    final int words = _wordCount(_entryController.text);


    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                DualToneTitle(
                  lightTextStyle: TextFontStyle.textStyle28c8C7C68HelveticaNeue300,
                  darkTextStyle: TextFontStyle.textStyle28c3B230EHelveticaNeue700,
                  lightText: 'Share',
                  darkText: 'Encouragement',
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    NavigationService.goBack;
                  },
                  icon: Icon(
                    Icons.close,
                    size: 24.sp,
                    color: AppColors.allPrimaryColor,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpace(25.h),
            SizedBox(
              height: 10.h,
              width: double.infinity,
              child: CustomPaint(painter: _ScribbleDividerPainter()),
            ),
            UIHelper.verticalSpace(25.h),
            CustomTextFormField(
              controller: _entryController,
              maxLines: 5,
              minLines: 5,
              onChanged: (_) => setState(() {}),
              useCardStyle: true,
              label: 'Message',
              hintText: 'Write your encouragement or testimony...',
              cardBackgroundColor:
                  AppColors.allPrimaryColor,
              cardBorderColor:
                  AppColors.c99907A.withValues(alpha: 0.48),
              cardBorderRadius: BorderRadius.circular(24.r),
              cardPadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.zero,
              footerLeft: const TextEditingFooterButtons(),
              footerRight: Text(
                '$words/300 words',
                style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400
                    .copyWith(fontSize: 16.sp),
              ),
            ),
            UIHelper.verticalSpace(20.h),
            Center(
              child: DualToneTitle(
                lightTextStyle: TextFontStyle.textStyle16c238D1AHelveticaNeue400.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                darkTextStyle: TextFontStyle.textStyle16c238D1AHelveticaNeue400,
                lightText: 'Note : ',
                darkText: 'Short, uplifting messages only',
              )
            ),
            UIHelper.verticalSpace(20.h),
            Center(
              child: CustomButton(
                height: 60.h,
                width: 190.w,
                borderRadius: BorderRadius.circular(60.r),
                title: 'Share Light',
                textStyle: TextFontStyle.textStyle16cFFFFFFHelveticaNeue500.copyWith(
                  color: Colors.white,
                ),
                onPressed: () {
                  // Handle share action
                },
                backgroundGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    AppColors.cF5EDD7.withValues(alpha: 0.96),
                    AppColors.c6B2F45.withValues(alpha: 0.92),
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


class _ScribbleDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6.w
      ..color = AppColors.cE8E1CB;

    final Path path = Path()..moveTo(0, size.height * 0.58);
    final double segment = size.width / 12;

    for (int i = 0; i < 12; i++) {
      final double startX = segment * i;
      final double endX = segment * (i + 1);
      final double controlX = (startX + endX) / 2;
      final bool up = i.isEven;
      final double controlY = up ? size.height * 0.28 : size.height * 0.84;
      path.quadraticBezierTo(controlX, controlY, endX, size.height * 0.58);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}