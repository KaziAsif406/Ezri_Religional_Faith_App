import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/sacred_entry_store.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class SacredEntriesList extends StatelessWidget {
  const SacredEntriesList({
    super.key,
    required this.entries,
  });

  final List<SacredEntryItem> entries;

  String _formatDate(DateTime date) {
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
    return '${months[date.month - 1]} ${date.day}';
  }

  String _wordCountLabel(int count) {
    if (count == 1) {
      return '1 word';
    }
    return '$count words';
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.separated(
        itemCount: entries.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        separatorBuilder: (_, __) => SizedBox(height: 8.h),
        itemBuilder: (BuildContext context, int index) {
          final SacredEntryItem entry = entries[index];
          return Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
            decoration: BoxDecoration(
              color: AppColors.allPrimaryColor,
              borderRadius: BorderRadius.circular(24.r),
              border: Border.all(
                color: AppColors.allsecondaryColor.withValues(alpha: 0.12),
                width: 1.w,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  entry.typeIconAsset,
                  width: 40.w,
                  height: 40.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 12.w),
                SizedBox(
                  width: 210.w, // Adjust the width as needed
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entry.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle.textStyle10c513B26HelveticaNeue400
                            .copyWith(fontSize: 17.sp),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        '${_wordCountLabel(entry.wordCount)}  •  ${entry.typeLabel}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextFontStyle.textStyle14c99907AHelveticaNeue400
                            .copyWith(fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
                // SizedBox(width: 10.w),
                Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    _formatDate(entry.entryDate),
                    style: TextFontStyle.textStyle14c99907AHelveticaNeue400,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
