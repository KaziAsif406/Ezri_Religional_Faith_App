// lib/widgets/buttons/custom_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/constants/text_font_style.dart';
import '/gen/colors.gen.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.leadingIcon,
    this.isLoading = false,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.height,
    this.width,
    this.textStyle,
    this.padding,
    this.backgroundGradient,
    this.titleGradient,
  });

  final VoidCallback? onPressed;
  final String title;
  final Widget? leadingIcon;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Gradient? backgroundGradient;
  final Gradient? titleGradient;

  @override
  Widget build(BuildContext context) {
    final BorderRadiusGeometry resolvedRadius =
        borderRadius ?? BorderRadius.circular(12.r);
    final TextStyle resolvedTextStyle =
        textStyle ?? TextFontStyle.textStyle10c513B26HelveticaNeue400;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 50.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
          borderRadius: resolvedRadius,
        ),
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundGradient != null
                ? Colors.transparent
                : (backgroundColor ?? AppColors.allPrimaryColor),
            foregroundColor: foregroundColor ?? AppColors.allPrimaryColor,
            disabledBackgroundColor:
                (backgroundColor ?? AppColors.allPrimaryColor)
                    .withValues(alpha: 0.5),
            disabledForegroundColor:
                (foregroundColor ?? AppColors.allPrimaryColor)
                    .withValues(alpha: 0.5),
            shadowColor: Colors.transparent,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: resolvedRadius,
            ),
            padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
          ),
          child: isLoading
              ? SizedBox(
                  width: 20.w,
                  height: 20.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      foregroundColor ?? AppColors.allPrimaryColor,
                    ),
                  ),
                )
              : _CustomButtonTitle(
                  title: title,
                  leadingIcon: leadingIcon,
                  textStyle: resolvedTextStyle,
                  titleGradient: titleGradient,
                ),
        ),
      ),
    );
  }
}

class _CustomButtonTitle extends StatelessWidget {
  const _CustomButtonTitle({
    required this.title,
    required this.leadingIcon,
    required this.textStyle,
    required this.titleGradient,
  });

  final String title;
  final Widget? leadingIcon;
  final TextStyle textStyle;
  final Gradient? titleGradient;

  @override
  Widget build(BuildContext context) {
    final Widget plainText = Text(
      title,
      style: textStyle,
      textAlign: TextAlign.center,
    );

    Widget titleWidget = plainText;

    if (titleGradient != null) {
      titleWidget = ShaderMask(
        shaderCallback: (Rect bounds) {
          return titleGradient!.createShader(bounds);
        },
        blendMode: BlendMode.srcIn,
        child: Text(
          title,
          style: textStyle.copyWith(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (leadingIcon == null) {
      return titleWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        leadingIcon!,
        titleWidget,
      ],
    );
  }
}

// // Alternative function-style customButton (if you prefer function over class)
// Widget customButton({
//   required VoidCallback? onPressed,
//   required String title,
//   Widget? leadingIcon,
//   bool isLoading = false,
//   Color? backgroundColor,
//   Color? foregroundColor,
//   BorderRadiusGeometry? borderRadius,
//   double? height,
//   double? width,
//   TextStyle? textStyle,
//   EdgeInsetsGeometry? padding,
//   Gradient? backgroundGradient,
//   Gradient? titleGradient,
// }) {
//   final BorderRadiusGeometry resolvedRadius =
//       borderRadius ?? BorderRadius.circular(12.r);
//   final TextStyle resolvedTextStyle =
//       textStyle ?? TextFontStyle.textStyle10c513B26HelveticaNeue400;

//   return SizedBox(
//     width: width ?? double.infinity,
//     height: height ?? 50.h,
//     child: DecoratedBox(
//       decoration: BoxDecoration(
//         gradient: backgroundGradient,
//         borderRadius: resolvedRadius,
//       ),
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: backgroundGradient != null
//               ? Colors.transparent
//               : (backgroundColor ?? AppColors.allPrimaryColor),
//           foregroundColor: foregroundColor ?? AppColors.allPrimaryColor,
//           disabledBackgroundColor:
//               (backgroundColor ?? AppColors.allPrimaryColor)
//                   .withValues(alpha: 0.5),
//           disabledForegroundColor:
//               (foregroundColor ?? AppColors.allPrimaryColor)
//                   .withValues(alpha: 0.5),
//           shadowColor: Colors.transparent,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: resolvedRadius,
//           ),
//           padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w),
//         ),
//         child: isLoading
//             ? SizedBox(
//                 width: 20.w,
//                 height: 20.h,
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2.w,
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     foregroundColor ?? AppColors.allPrimaryColor,
//                   ),
//                 ),
//               )
//             : _CustomButtonTitle(
//                 title: title,
//                 leadingIcon: leadingIcon,
//                 textStyle: resolvedTextStyle,
//                 titleGradient: titleGradient,
//               ),
//       ),
//     ),
//   );
// }
