import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/community/presentation/widget/encouragement_card.dart';
import 'package:template_flutter/features/community/presentation/widget/share_encouragement_bottom_sheet.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<_EncouragementItem> _encouragementItems = <_EncouragementItem>[
    const _EncouragementItem(
      authorName: 'John Doe',
      postedAgo: '2 hours ago',
      message: 'Feeling grateful for the blessings in my life. #Gratitude',
      categoryLabel: 'Gratitude',
      likesCount: 12,
      showYouTag: false,
    ),
    const _EncouragementItem(
      authorName: 'Jane Smith',
      postedAgo: '5 hours ago',
      message:
          '"Today God reminded me through Psalm 46:10 - "Be still, and know that I am God." If you\'re feeling overwhelmed, He is your peace."',
      categoryLabel: 'Family Time',
      likesCount: 20,
      showYouTag: false,
    ),
    const _EncouragementItem(
      authorName: 'Wade Warren',
      postedAgo: '3 min ago',
      message:
          '"Faith doesn\'t always remove the storm, but it gives strength to walk through it with peace."',
      categoryLabel: 'Reflection',
      likesCount: 8,
      showYouTag: true,
    ),
    const _EncouragementItem(
      authorName: 'Alex Johnson',
      postedAgo: '1 day ago',
      message:
          'Small acts of kindness can become someone else\'s answered prayer.',
      categoryLabel: 'Kindness',
      likesCount: 5,
      showYouTag: false,
    ),
  ];

  late final List<bool> _likedStates;
  late final List<int> _likeCounts;

  @override
  void initState() {
    super.initState();
    _likedStates = List<bool>.filled(_encouragementItems.length, false);
    _likeCounts = _encouragementItems
        .map((item) => item.likesCount)
        .toList(growable: false);
  }

  Future<void> _showShareEncouragementBottomSheet() async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.55,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.scaffoldColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
            ),
            child: ShareEncouragementBottomSheet(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomAppBar(
              titleText: 'Community Light',
            ),
            Transform.translate(
              offset: Offset(0, -25.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: ListView.separated(
                  itemCount: _encouragementItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    final _EncouragementItem item = _encouragementItems[index];
                    return EncouragementCard(
                      authorName: item.authorName,
                      postedAgo: item.postedAgo,
                      message: item.message,
                      categoryLabel: item.categoryLabel,
                      likesCount: _likeCounts[index],
                      showYouTag: item.showYouTag,
                      isLiked: _likedStates[index],
                      onLikeTap: () {
                        setState(() {
                          final bool currentLikeState = _likedStates[index];
                          _likedStates[index] = !currentLikeState;
                          _likeCounts[index] = currentLikeState
                              ? (_likeCounts[index] - 1)
                              : (_likeCounts[index] + 1);
                        });
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return UIHelper.verticalSpace(8.h);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: CustomButton(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 19.h),
        title: '',
        leadingIcon: Icon(
          CupertinoIcons.add,
          color: AppColors.allPrimaryColor,
          size: 30.sp,
        ),
        backgroundGradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            const Color.fromARGB(255, 212, 207, 191),
            AppColors.c6B2F45.withValues(alpha: 0.92),
          ],
        ),
        onPressed: () {
          _showShareEncouragementBottomSheet();
        },
        height: 64.h,
        width: 64.w,
        borderRadius: BorderRadius.circular(2444.r),
        textStyle: TextFontStyle.textStyle14cFFFFFFHelveticaNeue500.copyWith(
          fontSize: 54.sp,
        ),
      ),
    );
  }
}

class _EncouragementItem {
  const _EncouragementItem({
    required this.authorName,
    required this.postedAgo,
    required this.message,
    required this.categoryLabel,
    required this.likesCount,
    required this.showYouTag,
  });

  final String authorName;
  final String postedAgo;
  final String message;
  final String categoryLabel;
  final int likesCount;
  final bool showYouTag;
}
