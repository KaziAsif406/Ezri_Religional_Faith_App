import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/community/presentation/widget/community_swipe_card_deck.dart';
import 'package:template_flutter/features/faith_anchors/presentation/widget/faith_anchor_swipe_card_deck.dart';
import 'package:template_flutter/features/home/presentation/widget/sacred_entries_list.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/sacred_entry_store.dart';
import 'package:template_flutter/helpers/all_routes.dart';
import 'package:template_flutter/helpers/navigation_service.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

import '../../../gen/colors.gen.dart';
import '../../../common_widgets/custom_section_card.dart';
import '../../../common_widgets/custom_section_header.dart';


class JourneyScreen extends StatefulWidget {
  const JourneyScreen({super.key});

  @override
  State<JourneyScreen> createState() => _JourneyScreenState();
}


class _JourneyScreenState extends State<JourneyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 430.h,
                  width: double.infinity,
                  child: Image.asset(
                    'assets/images/header.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 22.w,
                  right: 22.w,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(top: 78.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Wade Warren (You)',
                                style: TextFontStyle.textStyle16cFFFFFFHelveticaNeue400.copyWith(
                                  color: AppColors.cF0F2F1.withValues(alpha: 0.6),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'Welcome back',
                                style: TextFontStyle.textStyle24cFFFFFFHelveticaNeue400,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 65.h),
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.cE5EAEB.withValues(alpha: 0.45),
                            width: 2.w,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'W',
                            style: TextFontStyle.textStyle12cFFFFFFHelveticaNeue700.copyWith(
                              fontSize: 28.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}