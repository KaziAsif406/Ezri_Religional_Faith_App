import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import '/gen/colors.gen.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.height,
    this.width,
    this.label,
    this.labelStyle,
    this.hintText,
    this.controller,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 5,
    this.minLines,
    this.contentPadding,
    this.focusNode,
    this.enabled,
    this.useCardStyle = false,
    this.cardBackgroundColor,
    this.cardBorderColor,
    this.cardBorderWidth,
    this.cardBorderRadius,
    this.cardPadding,
    this.footerLeft,
    this.footerRight,
    this.footerSpacing,
    this.footerPadding,
    this.footerTextStyle,
  });

  final String? label;
  final TextStyle? labelStyle;
  final double? height;
  final double? width;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final int maxLines;
  final int? minLines;
  final EdgeInsetsGeometry? contentPadding;
  final FocusNode? focusNode;
  final bool? enabled;
  final bool useCardStyle;
  final Color? cardBackgroundColor;
  final Color? cardBorderColor;
  final double? cardBorderWidth;
  final BorderRadiusGeometry? cardBorderRadius;
  final EdgeInsetsGeometry? cardPadding;
  final Widget? footerLeft;
  final Widget? footerRight;
  final double? footerSpacing;
  final EdgeInsetsGeometry? footerPadding;
  final TextStyle? footerTextStyle;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _obscureText;

  double? get _effectiveHeight => widget.height?.h;
  double? get _effectiveWidth => widget.width?.w;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleObscure() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry resolvedCardRadius =
        widget.cardBorderRadius ?? BorderRadius.circular(26.r);

    return SizedBox(
      height: _effectiveHeight,
      width: _effectiveWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null && widget.label!.isNotEmpty) ...[
            Text(
              widget.label!,
              style: widget.labelStyle ??
                  TextFontStyle.textStyle14c8C7C68HelveticaNeue400,
            ),
            SizedBox(height: 8.h),
          ],
          Container(
            width: double.infinity,
            decoration: widget.useCardStyle
                ? BoxDecoration(
                    color:
                        widget.cardBackgroundColor ?? AppColors.allPrimaryColor,
                    borderRadius: resolvedCardRadius,
                    border: Border.all(
                      color: widget.cardBorderColor ??
                          const Color.fromARGB(0, 153, 144, 122).withValues(alpha: 0.18),
                      width: widget.cardBorderWidth ?? 1.w,
                    ),
                  )
                : null,
            padding: widget.useCardStyle
                ? (widget.cardPadding ??
                    EdgeInsets.fromLTRB(18.w, 16.h, 18.w, 14.h))
                : EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: widget.controller,
                  validator: widget.validator,
                  enabled: widget.enabled,
                  obscureText: _obscureText,
                  onChanged: widget.onChanged,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.obscureText ? 1 : widget.maxLines,
                  minLines: widget.minLines,
                  focusNode: widget.focusNode,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextFontStyle.textStyle14c8C7C68HelveticaNeue300,
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.obscureText
                        ? GestureDetector(
                            onTap: _toggleObscure,
                            child: Image.asset(
                              _obscureText
                                  ? 'assets/icons/eye_off.png'
                                  : 'assets/icons/eye_on.png',
                              width: 12.w,
                              height: 12.h,
                            ),
                          )
                        : widget.suffixIcon,
                    contentPadding: widget.contentPadding ??
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    filled: !widget.useCardStyle,
                    fillColor: AppColors.allPrimaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color:
                            AppColors.allsecondaryColor.withValues(alpha: 0.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color:
                            AppColors.allsecondaryColor.withValues(alpha: 0.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide(
                        color:
                            AppColors.allsecondaryColor.withValues(alpha: 0.0),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: AppColors.allsecondaryColor,
                      ),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Colors.red,
                        width: 2,
                      ),
                    ),
                    errorStyle: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.red,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.allsecondaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                if (widget.footerLeft != null || widget.footerRight != null) ...[
                  SizedBox(height: 12.h),
                  Padding(
                    padding: widget.footerPadding ?? EdgeInsets.zero,
                    child: Row(
                      children: [
                        if (widget.footerLeft != null) widget.footerLeft!,
                        if (widget.footerLeft != null &&
                            widget.footerRight != null)
                          SizedBox(width: widget.footerSpacing ?? 12.w),
                        if (widget.footerRight != null) ...[
                          const Spacer(),
                          DefaultTextStyle(
                            style: widget.footerTextStyle ??
                                TextFontStyle.textStyle14c8C7C68HelveticaNeue400,
                            child: widget.footerRight!,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
