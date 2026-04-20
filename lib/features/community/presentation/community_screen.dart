import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/common_widgets/custom_textform_field.dart';
import 'package:template_flutter/common_widgets/selector_widget.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/community/presentation/widget/encouragement_card.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}


class _CommunityScreenState extends State<CommunityScreen> {
  bool isLiked = false;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EncouragementCard(
                      authorName: 'John Doe',
                      postedAgo: '2 hours ago',
                      message: 'Feeling grateful for the blessings in my life. #Gratitude',
                      categoryLabel: 'Gratitude',
                      likesCount: 12,
                      isLiked: isLiked,
                      onLikeTap: () {
                        setState(() {
                          isLiked = !isLiked;
                        });
                      },
                    ),
                    UIHelper.verticalSpace(8.h),
                    EncouragementCard(
                      authorName: 'Jane Smith',
                      postedAgo: '5 hours ago',
                      message: '\“Today God reminded me through Psalm 46:10 — \‘Be still, and know that I am God.\’ If you\’re feeling overwhelmed, He is your peace.\”',
                      categoryLabel: 'Family Time',
                      likesCount: 20,
                      isLiked: false,
                      onLikeTap: () {
                        // Handle like tap for this card
                      },
                    ),
                  ],
                )
              ),
            ),
          ],
        
        ),
      )

    );
  }
}