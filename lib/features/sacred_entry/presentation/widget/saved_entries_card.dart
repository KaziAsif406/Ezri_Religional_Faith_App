import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/sacred_entry_store.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

class SavedEntriesCard extends StatelessWidget {
  const SavedEntriesCard({
    super.key,
    required this.entry,
    this.onTap,
    this.onMenuTap,
  });

  final SacredEntryItem entry;
  final VoidCallback? onTap;
  final VoidCallback? onMenuTap;

  String _formatDate(DateTime date) {
    const List<String> months = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _truncateContent(String content, int maxLength) {
    if (content.length <= maxLength) {
      return content;
    }
    return '${content.substring(0, maxLength)}...';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: AppColors.allPrimaryColor,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.c1C1919.withValues(alpha: 0.08),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Header with type badge and date + menu
            Row(
              children: <Widget>[
                // Type Badge with Icon on the left
                Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColors.cF5EDD7.withValues(alpha: 0.0),
                    borderRadius: BorderRadius.circular(999.r),
                    border: Border.all(
                      color: AppColors.cF2F2F2.withValues(alpha: 0.60),
                      width: 1.w,
                    ),
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.cF5EDD7,
                          const Color.fromARGB(255, 184, 175, 156),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(999.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.allsecondaryColor.withValues(alpha: 0.30),
                          blurRadius: 20.r,
                          offset: Offset(0, 8.h),
                        ),
                      ],
                    ),
                    child: Text(
                      entry.typeLabel,
                      style: TextFontStyle.textStyle14c796956HelveticaNeue300.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                UIHelper.horizontalSpace(8.w),
                // Date on the right
                Text(
                  _formatDate(entry.entryDate),
                  style:
                      TextFontStyle.textStyle12c8C7C68HelveticaNeue400.copyWith(
                    fontSize: 12.sp,
                    color: AppColors.c8C7C68,
                  ),
                ),
                const Spacer(),
                // Menu button
                GestureDetector(
                  onTap: onMenuTap,
                  child: Icon(
                    Icons.more_horiz_sharp,
                    size: 20.sp,
                    color: AppColors.c685E4A,
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceSmall,
            // Prompt header (if available)
            if (entry.selectedPrompt != null &&
                entry.selectedPrompt!.isNotEmpty)
              Text(
                entry.selectedPrompt!,
                style:
                    TextFontStyle.textStyle16c3B230EHelveticaNeue500.copyWith(
              fontSize: 18.sp,
              color: AppColors.c352619,
              fontWeight: FontWeight.w600,
                            ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            // Title
            // Text(
            //   entry.title,
            //   style: TextFontStyle.textStyle16c3B230EHelveticaNeue500.copyWith(
            //     fontSize: 18.sp,
            //     color: AppColors.c352619,
            //     fontWeight: FontWeight.w600,
            //   ),
            //   maxLines: 2,
            //   overflow: TextOverflow.ellipsis,
            // ),
            UIHelper.verticalSpaceSmall,
            // Content preview
            Text(
              _truncateContent(entry.content, 140),
              style: TextFontStyle.textStyle14c3B230EHelveticaNeue400.copyWith(
                fontSize: 14.sp,
                color: AppColors.c685E4A,
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            UIHelper.verticalSpaceMedium,
            // Word count
            Text(
              '${entry.wordCount} words',
              style: TextFontStyle.textStyle12c8C7C68HelveticaNeue400.copyWith(
                fontSize: 12.sp,
                color: AppColors.c8C7C68,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
