import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/community/presentation/widget/encouragement_card.dart';
import 'package:template_flutter/common_widgets/custom_section_card.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

class StackedCardsScreen extends StatelessWidget {
  const StackedCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SafeArea(
        child: const CommunitySwipeCardDeck(),
      ),
    );
  }
}

class CommunitySwipeCardDeck extends StatefulWidget {
  const CommunitySwipeCardDeck({super.key});

  @override
  State<CommunitySwipeCardDeck> createState() => _CommunitySwipeCardDeckState();
}

class _CommunitySwipeCardDeckState extends State<CommunitySwipeCardDeck> {
  static const int _maxVisibleCards = 3;

  final List<_EncouragementStackItem> _cards =
      List<_EncouragementStackItem>.from(_initialCards);
  final Map<String, bool> _likedStates = <String, bool>{};
  final Map<String, int> _likeCounts = <String, int>{};

  @override
  void initState() {
    super.initState();
    for (final _EncouragementStackItem card in _cards) {
      _likedStates[card.id] = false;
      _likeCounts[card.id] = card.likesCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_cards.isEmpty) {
      return HomeSectionCard(
        onButtonTap: _resetDeck,
        backgroundColor: AppColors.cC7BFAD,
        imagePath: 'assets/icons/Candle_Empty.png',
        title: 'Your Light Awaits',
        description:
            'Share your light — your words can inspire others.',
        buttonLabel: 'Load New Lights',
        buttonGradient: [
          AppColors.allsecondaryColor.withValues(alpha: 0.20),
          AppColors.allsecondaryColor.withValues(alpha: 0.20),
        ],
        buttonShadowColor: AppColors.c8C7C68.withValues(alpha: 0.35),
      );
    }

    final int visibleCount =
        _cards.length < _maxVisibleCards ? _cards.length : _maxVisibleCards;

    return Column(
      children: [
        UIHelper.verticalSpace(50.h),
        SizedBox(
          height: 160.h,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.topCenter,
            children: List<Widget>.generate(visibleCount, (int depthIndex) {
              final int cardIndex = visibleCount - 1 - depthIndex;
              final _EncouragementStackItem card = _cards[cardIndex];
              final bool isTopCard = cardIndex == 0;
        
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOut,
                top: depthIndex * -15.h,
                left: 30.w,
                right: 30.w,
                child: AnimatedScale(
                  duration: const Duration(milliseconds: 320),
                  curve: Curves.easeOut,
                  scale: 1 + (depthIndex * 0.09),
                  child: isTopCard
                      ? Dismissible(
                          key: ValueKey<String>(card.id),
                          direction: DismissDirection.horizontal,
                          dismissThresholds: const <DismissDirection, double>{
                            DismissDirection.startToEnd: 0.24,
                            DismissDirection.endToStart: 0.24,
                          },
                          movementDuration: const Duration(milliseconds: 190),
                          resizeDuration: const Duration(milliseconds: 170),
                          background: const _SwipeHintBackground(
                            alignment: Alignment.centerLeft,
                            icon: Icons.arrow_forward_rounded,
                          ),
                          // secondaryBackground: const _SwipeHintBackground(
                          //   alignment: Alignment.centerRight,
                          //   icon: Icons.arrow_back_rounded,
                          // ),
                          onDismissed: (_) => _removeTopCard(),
                          child: _buildCard(card),
                        )
                      : IgnorePointer(child: _buildCard(card)),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildCard(_EncouragementStackItem card) {
    return EncouragementCard(
      authorName: card.authorName,
      postedAgo: card.postedAgo,
      message: card.message,
      // categoryLabel: card.categoryLabel,
      likesCount: _likeCounts[card.id] ?? card.likesCount,
      showYouTag: card.showYouTag,
      isLiked: _likedStates[card.id] ?? false,
      onLikeTap: () => _toggleLike(card),
      showBottomSection: false,
    );
  }

  void _toggleLike(_EncouragementStackItem card) {
    final bool wasLiked = _likedStates[card.id] ?? false;
    final int currentCount = _likeCounts[card.id] ?? card.likesCount;

    setState(() {
      _likedStates[card.id] = !wasLiked;
      _likeCounts[card.id] = wasLiked ? currentCount - 1 : currentCount + 1;
    });
  }

  void _removeTopCard() {
    if (_cards.isEmpty) {
      return;
    }

    setState(() {
      _cards.removeAt(0);
    });
  }

  void _resetDeck() {
    if (_cards.isNotEmpty) {
      return;
    }

    setState(() {
      _cards.addAll(_initialCards);
    });
  }
}

class _SwipeHintBackground extends StatelessWidget {
  const _SwipeHintBackground({
    required this.alignment,
    required this.icon,
  });

  final Alignment alignment;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 160, 160, 159).withValues(alpha: 0.20),
        borderRadius: BorderRadius.circular(24.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      alignment: alignment,
      child: Icon(
        icon,
        size: 22.sp,
        color: AppColors.allsecondaryColor.withValues(alpha: 0.75),
      ),
    );
  }
}

class _EncouragementStackItem {
  const _EncouragementStackItem({
    required this.id,
    required this.authorName,
    required this.categoryLabel,
    required this.postedAgo,
    required this.message,
    required this.likesCount,
    required this.showYouTag,
  });

  final String id;
  final String authorName;
  final String categoryLabel;
  final String postedAgo;
  final String message;
  final int likesCount;
  final bool showYouTag;
}

const List<_EncouragementStackItem> _initialCards = <_EncouragementStackItem>[
  _EncouragementStackItem(
    id: 'card_1',
    authorName: 'Elena Faith',
    categoryLabel: 'Gratitude',
    postedAgo: '16h Fast',
    message:
        '"Today I realized how small acts of kindness can shift an entire day. Thank You, Lord."',
    likesCount: 8,
    showYouTag: false,
  ),
  _EncouragementStackItem(
    id: 'card_2',
    authorName: 'Wade Warren',
    categoryLabel: 'Reflection',
    postedAgo: '3h Fast',
    message:
        '"Faith may not calm every storm immediately, but it anchors your heart through every wave."',
    likesCount: 12,
    showYouTag: true,
  ),
  _EncouragementStackItem(
    id: 'card_3',
    authorName: 'Jane Smith',
    categoryLabel: 'Family Time',
    postedAgo: '9h Fast',
    message:
        '"Tonight we prayed together as a family, and peace filled our home in a new way."',
    likesCount: 5,
    showYouTag: false,
  ),
  _EncouragementStackItem(
    id: 'card_4',
    authorName: 'Alex Johnson',
    categoryLabel: 'Community',
    postedAgo: '1d Fast',
    message:
        '"Encouraging one person today reminded me how God multiplies small acts of love."',
    likesCount: 3,
    showYouTag: false,
  ),
  _EncouragementStackItem(
    id: 'card_5',
    authorName: 'Mila Turner',
    categoryLabel: 'Personal Growth',
    postedAgo: '4d Fast',
    message:
        '"Fasting isn\'t just about giving up food, it\'s about making space for God\'s voice to grow louder in your life."',
    likesCount: 3,
    showYouTag: false,
  ),
];