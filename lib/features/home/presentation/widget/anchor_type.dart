import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';

import '../../../../gen/colors.gen.dart';

enum AnchorTypeOption { verse, quote, affirmation }

class AnchorTypeSelector extends StatelessWidget {
  const AnchorTypeSelector({
    super.key,
    required this.selectedType,
    required this.onChanged,
  });

  final AnchorTypeOption selectedType;
  final ValueChanged<AnchorTypeOption> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _AnchorTypeChip(
            label: 'Verse',
            isSelected: selectedType == AnchorTypeOption.verse,
            onTap: () => onChanged(AnchorTypeOption.verse),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _AnchorTypeChip(
            label: 'Quote',
            isSelected: selectedType == AnchorTypeOption.quote,
            onTap: () => onChanged(AnchorTypeOption.quote),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _AnchorTypeChip(
            label: 'Affirmation',
            isSelected: selectedType == AnchorTypeOption.affirmation,
            onTap: () => onChanged(AnchorTypeOption.affirmation),
          ),
        ),
      ],
    );
  }
}

class _AnchorTypeChip extends StatelessWidget {
  const _AnchorTypeChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        height: 56.h,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.c8F96A0.withValues(alpha: 0.22)
              : AppColors.cF5F6F5.withValues(alpha: 0.24),
          borderRadius: BorderRadius.circular(34.r),
          border: Border.all(
            color: isSelected
                ? AppColors.c352619.withValues(alpha: 0.30)
                : AppColors.c99907A.withValues(alpha: 0.16),
            width: 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.c1C1919.withValues(alpha: 0.12),
                    blurRadius: 12.r,
                    offset: Offset(0, 7.h),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextFontStyle.textStyle16c796956HelveticaNeue400.copyWith(
            color: isSelected ? AppColors.allsecondaryColor : AppColors.c685E4A,
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
