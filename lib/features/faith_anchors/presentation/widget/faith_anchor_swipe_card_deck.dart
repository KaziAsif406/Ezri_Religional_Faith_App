import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_section_card.dart';
import 'package:template_flutter/common_widgets/stacked_cards.dart';
import 'package:template_flutter/helpers/all_routes.dart';
import 'package:template_flutter/helpers/navigation_service.dart';

import '../../../../gen/colors.gen.dart';
import 'faith_anchor_card.dart';
import 'faith_anchor_store.dart';

class FaithAnchorSwipeCardDeck extends StatelessWidget {
  const FaithAnchorSwipeCardDeck({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<FaithAnchorItem>>(
      valueListenable: FaithAnchorStore.instance.itemsListenable,
      builder: (BuildContext context, List<FaithAnchorItem> items, _) {
        return StackedSwipeDeck<FaithAnchorItem>(
          items: items,
          keyBuilder: (FaithAnchorItem item) => item.id,
          cardBuilder: (BuildContext context, FaithAnchorItem item, bool isTopCard) {
            return FaithAnchorCard(
              item: item,
              onDelete: () => FaithAnchorStore.instance.removeItemById(item.id),
            );
          },
          emptyBuilder: (BuildContext context, VoidCallback resetDeck) {
            return HomeSectionCard(
              backgroundColor: AppColors.cC7BFAD,
              imagePath: 'assets/icons/Security_Empty.png',
              title: 'Establish Your Foundational Verses',
              description:
                  'Create your first Faith Anchor card to define and document the scriptures that guide your life.',
              buttonLabel: 'Add New Faith Anchor',
              buttonGradient: <Color>[
                AppColors.allsecondaryColor.withValues(alpha: 0.20),
                AppColors.allsecondaryColor.withValues(alpha: 0.20),
              ],
              buttonShadowColor: AppColors.c8C7C68.withValues(alpha: 0.35),
              onButtonTap: () {
                NavigationService.navigateTo(Routes.addFaithAnchor);
              },
            );
          },
          maxVisibleCards: 3,
          deckHeight: 250.h,
          topOffsetStep: -12.h,
          horizontalInset: 12.w,
          scaleStep: 0.03,
          dismissBackgroundBuilder: (BuildContext context, FaithAnchorItem item) {
            return const _FaithSwipeHintBackground(
              alignment: Alignment.centerLeft,
              icon: Icons.arrow_forward_rounded,
            );
          },
          dismissSecondaryBackgroundBuilder:
              (BuildContext context, FaithAnchorItem item) {
            return const _FaithSwipeHintBackground(
              alignment: Alignment.centerRight,
              icon: Icons.arrow_back_rounded,
            );
          },
          onItemDismissed: (FaithAnchorItem item, DismissDirection direction) {
            FaithAnchorStore.instance.removeItemById(item.id);
          },
        );
      },
    );
  }
}

class _FaithSwipeHintBackground extends StatelessWidget {
  const _FaithSwipeHintBackground({
    required this.alignment,
    required this.icon,
  });

  final Alignment alignment;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF9C8E72).withValues(alpha: 0.22),
        borderRadius: BorderRadius.circular(30.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: alignment,
      child: Icon(
        icon,
        size: 26.sp,
        color: AppColors.c513B26.withValues(alpha: 0.74),
      ),
    );
  }
}
