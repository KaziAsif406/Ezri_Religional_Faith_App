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
          children: [
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
        height: 190.h,
        padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.allPrimaryColor
              : AppColors.cF0F2F1.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: isSelected
                ? AppColors.allsecondaryColor.withValues(alpha: 0.12)
                : AppColors.c99907A.withValues(alpha: 0.0),
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
            Container(
              width: 125.w,
              decoration: BoxDecoration(
                color: AppColors.c513B26.withValues(alpha: 0.0),
              ),
              child: Text(
                promptText,
                style: TextFontStyle.textStyle16c3B230EHelveticaNeue400.copyWith(
                  height: 1.5.h
                ),
              ),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 24.w,
                height: 24.w,
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.allsecondaryColor
                        : AppColors.c99907A.withValues(alpha: 0.70),
                    width: 1.4.w,
                  ),
                ),
                child: isSelected
                    ? Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.allsecondaryColor,
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
        padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 7.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.cCFC7B6,
              const Color.fromARGB(255, 184, 175, 156),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(999.r),
          border: Border.all(
            color: AppColors.c352619.withValues(alpha: 0.20),
            width: 1.5.w,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: AppColors.c1C1919.withValues(alpha: 0.12),
              blurRadius: 5.r,
              offset: Offset(0, 5.h),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.shuffle_rounded,
              size: 20.sp,
              color: AppColors.allsecondaryColor,
            ),
            SizedBox(width: 8.w),
            Text(
              'Shuffle',
              style: TextFontStyle.textStyle18c3B230EHelveticaNeue700,
            ),
          ],
        ),
      ),
    );
  }
}
