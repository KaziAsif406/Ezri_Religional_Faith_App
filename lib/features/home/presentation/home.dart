import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/community/presentation/widget/community_swipe_card_deck.dart';
import 'package:template_flutter/features/faith_anchors/presentation/widget/faith_anchor_swipe_card_deck.dart';
import 'package:template_flutter/helpers/all_routes.dart';
import 'package:template_flutter/helpers/navigation_service.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

import '../../../gen/colors.gen.dart';
import 'widget/home_action_tile.dart';
import '../../../common_widgets/custom_section_card.dart';
import '../../../common_widgets/custom_section_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                Positioned(
                  top: 190.h,
                  left: 15.w,
                  right: 15.w,
                  child: Row(
                    children: [
                      Expanded(
                        child: HomeActionTile(
                          label: 'Add\nEntry',
                          imagePath: 'assets/icons/add_entry.png',
                        ),
                      ),
                      UIHelper.horizontalSpace(9.w),
                      Expanded(
                        child: HomeActionTile(
                          label: 'Ezri\nChat',
                          imagePath: 'assets/icons/chat.png',
                        ),
                      ),
                      UIHelper.horizontalSpace(9.w),
                      Expanded(
                        child: HomeActionTile(
                          label: 'Community\nLight',
                          imagePath: 'assets/icons/community.png',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(22.w, 17.h, 22.w, 35.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeSectionHeader(
                    titlePrefix: 'Faith',
                    titleHighlight: 'Anchors',
                  ),
                  SizedBox(height: 12.h),
                  const FaithAnchorSwipeCardDeck(),
                  SizedBox(height: 28.h),
                  HomeSectionHeader(
                    titlePrefix: 'Community',
                    titleHighlight: 'Light',
                    actionText: 'View all',
                    onActionTap: () {
                      NavigationService.navigateTo(Routes.communityScreen);
                    },
                  ),
                  SizedBox(height: 12.h),
                  const CommunitySwipeCardDeck(),
                  SizedBox(height: 28.h),
                  HomeSectionHeader(
                    titlePrefix: 'Sacred',
                    titleHighlight: 'Entries',
                    actionText: 'View all',
                    onActionTap: () {},
                  ),
                  SizedBox(height: 14.h),
                  HomeSectionCard(
                    backgroundColor: AppColors.allPrimaryColor,
                    imagePath: 'assets/icons/Journal_Empty.png',
                    title: 'Start Your Sacred Journal',
                    description:
                        'Document your reflections, thoughts, and prayers with guided prompts.',
                    buttonLabel: 'Create New Entry',
                    buttonGradient: [
                      AppColors.c6B2F45.withValues(alpha: 0.20),
                      AppColors.c6B2F45.withValues(alpha: 0.70),
                    ],
                    buttonShadowColor: AppColors.c6B2F45.withValues(alpha: 0.42),
                    elevatedButton: true,
                  ),
                  SizedBox(height: 28.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
