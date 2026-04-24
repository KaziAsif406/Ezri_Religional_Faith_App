import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/assets.gen.dart';
import 'package:template_flutter/gen/colors.gen.dart';

enum GoalType {
  bibleReading,
  prayer,
  fasting,
  reflection,
  memoryVerses,
  journaling,
  other,
}

class GoalTypeSelector extends StatelessWidget {
  const GoalTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeChanged,
  });

  final GoalType selectedType;
  final ValueChanged<GoalType> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    final List<_GoalTypeOption> options = <_GoalTypeOption>[
      _GoalTypeOption(
        type: GoalType.bibleReading,
        label: 'Bible\nReading',
        assetPath: Assets.icons.bible.path,
      ),
      _GoalTypeOption(
        type: GoalType.prayer,
        label: 'Prayer',
        assetPath: Assets.icons.prayer.path,
      ),
      _GoalTypeOption(
        type: GoalType.fasting,
        label: 'Fasting',
        assetPath: Assets.icons.fasting.path,
      ),
      _GoalTypeOption(
        type: GoalType.reflection,
        label: 'Reflection',
        assetPath: Assets.icons.reflection.path,
      ),
      _GoalTypeOption(
        type: GoalType.memoryVerses,
        label: 'Memory\nVerses',
        assetPath: Assets.icons.memory.path,
      ),
      _GoalTypeOption(
        type: GoalType.journaling,
        label: 'Journaling',
        assetPath: Assets.icons.journaling.path,
      ),
    ];

    return Column(
      children: [
        GridView.builder(
          itemCount: options.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 0.92,
          ),
          itemBuilder: (BuildContext context, int index) {
            final _GoalTypeOption option = options[index];
            final bool isSelected = selectedType == option.type;

            return GestureDetector(
              onTap: () => onTypeChanged(option.type),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.allPrimaryColor
                      : AppColors.cC7BFAD,
                  borderRadius: BorderRadius.circular(24.r),
                  border: Border.all(
                    color: isSelected
                        ? AppColors.allsecondaryColor.withValues(alpha: 0.60)
                        : AppColors.allsecondaryColor.withValues(alpha: 0.12),
                    width: isSelected ? 1.8.w : 1.w,
                  ),
                ),
                padding: EdgeInsets.all(14.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(option.assetPath),
                      width: 50.w,
                      height: 50.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      option.label,
                      textAlign: TextAlign.center,
                      style: TextFontStyle.textStyle16c3B230EHelveticaNeue400
                          .copyWith(
                        fontWeight:
                            isSelected ? FontWeight.w700 : FontWeight.w400,
                        color: isSelected
                            ? AppColors.allsecondaryColor
                            : AppColors.c8C7C68,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () => onTypeChanged(GoalType.other),
          child: Container(
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            decoration: BoxDecoration(
              color: AppColors.allPrimaryColor,
              borderRadius: BorderRadius.circular(40.r),
              border: Border.all(
                color: selectedType == GoalType.other
                    ? AppColors.allsecondaryColor.withValues(alpha: 0.60)
                    : AppColors.allsecondaryColor.withValues(alpha: 0.28),
                width: selectedType == GoalType.other ? 1.8.w : 1.3.w,
              ),
            ),
            child: Text(
              'Other',
              style: TextFontStyle.textStyle20c3B230EHelveticaNeue500,
            ),
          ),
        ),
      ],
    );
  }
}

class _GoalTypeOption {
  const _GoalTypeOption({
    required this.type,
    required this.label,
    required this.assetPath,
  });

  final GoalType type;
  final String label;
  final String assetPath;
}
