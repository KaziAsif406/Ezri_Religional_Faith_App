import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../../gen/colors.gen.dart';

class PromptSelectorSection extends StatelessWidget {
  const PromptSelectorSection({
    super.key,
    required this.prompts,
    required this.selectedIndex,
    required this.onPromptTap,
    required this.onShuffleTap,
  });

  final List<String> prompts;
  final int selectedIndex;
  final ValueChanged<int> onPromptTap;
  final VoidCallback onShuffleTap;

  @override
  Widget build(BuildContext context) {
    if (prompts.length < 2) {
      return const SizedBox.shrink();
    }

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _PromptCard(
                promptText: prompts[0],
                isSelected: selectedIndex == 0,
                onTap: () => onPromptTap(0),
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: _PromptCard(
                promptText: prompts[1],
                isSelected: selectedIndex == 1,
                onTap: () => onPromptTap(1),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        _PromptShuffleButton(
          onTap: onShuffleTap,
        ),
        SizedBox(height: 24.h),
      ],
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard({
    required this.promptText,
    required this.isSelected,
    required this.onTap,
  });

  final String promptText;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        height: 252.h,
        padding: EdgeInsets.fromLTRB(18.w, 20.h, 18.w, 20.h),
        decoration: BoxDecoration(
          color: AppColors.allPrimaryColor,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: isSelected
                ? AppColors.c513B26.withValues(alpha: 0.65)
                : AppColors.c99907A.withValues(alpha: 0.26),
            width: isSelected ? 1.6.w : 1.2.w,
          ),
          boxShadow: isSelected
              ? <BoxShadow>[
                  BoxShadow(
                    color: AppColors.c513B26.withValues(alpha: 0.10),
                    blurRadius: 10.r,
                    offset: Offset(0, 3.h),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              promptText,
              style: TextFontStyle.textStyle14c3B230EHelveticaNeue400.copyWith(
                fontSize: 21.sp,
                height: 1.35,
                color: AppColors.c352619,
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 33.w,
                height: 33.w,
                padding: EdgeInsets.all(3.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.c513B26
                        : AppColors.c99907A.withValues(alpha: 0.70),
                    width: 1.4.w,
                  ),
                ),
                child: isSelected
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.c513B26,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PromptShuffleButton extends StatelessWidget {
  const _PromptShuffleButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColors.allPrimaryColor,
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: AppColors.c99907A.withValues(alpha: 0.34),
            width: 1.w,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.c1C1919.withValues(alpha: 0.12),
              blurRadius: 10.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.shuffle_rounded,
              size: 24.sp,
              color: AppColors.c513B26,
            ),
            SizedBox(width: 8.w),
            Text(
              'Shuffle',
              style: TextFontStyle.textStyle20c3B230EHelveticaNeue400.copyWith(
                fontSize: 20.sp,
                color: AppColors.c352619,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
