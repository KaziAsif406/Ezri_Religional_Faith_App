import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/gen/colors.gen.dart';

class EncouragementCard extends StatelessWidget {
  const EncouragementCard({
    super.key,
    this.authorName = '',
    this.postedAgo = '',
    this.message = '',
    this.categoryLabel = '',
    this.likesCount = 8,
    this.avatarImage = const AssetImage('assets/images/profile.png'),
    this.showYouTag = true,
    this.onLikeTap,
    this.onBookmarkTap,
    this.onDeleteTap,
    this.onReportTap, 
    this.isLiked = false,
  });

  final String authorName;
  final String postedAgo;
  final String message;
  final String categoryLabel;
  final int likesCount;
  final ImageProvider avatarImage;
  final bool showYouTag;
  final VoidCallback? onLikeTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onDeleteTap;
  final VoidCallback? onReportTap;
  final bool isLiked;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(24.w, 24.h, 16.w, 16.h),
      decoration: BoxDecoration(
        color: AppColors.allPrimaryColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderRow(
            authorName: authorName,
            postedAgo: postedAgo,
            likesCount: likesCount,
            avatarImage: avatarImage,
            showYouTag: showYouTag,
            onLikeTap: onLikeTap,
            isLiked: isLiked,
          ),
          SizedBox(height: 12.h),
          Text(
            message,
            style: TextFontStyle.textStyle14c796956HelveticaNeue400.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            )
          ),
          SizedBox(height: 12.h),
          SizedBox(
            height: 14.h,
            width: double.infinity,
            child: CustomPaint(painter: _ScribbleDividerPainter()),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Text(
                categoryLabel,
                style: TextFontStyle.textStyle16c8C7C68HelveticaNeue400,
              ),
              Spacer(),
              _CircleActionButton(
                icon: Icons.bookmark_border_rounded,
                onTap: onBookmarkTap,
              ),
              SizedBox(width: 12.w),
              _CircleActionButton(
                icon: Icons.delete_outline_rounded,
                onTap: onDeleteTap,
              ),
              SizedBox(width: 12.w),
              _CircleActionButton(
                icon: Icons.warning_amber_rounded,
                onTap: onReportTap,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.authorName,
    required this.postedAgo,
    required this.likesCount,
    required this.avatarImage,
    required this.showYouTag,
    required this.onLikeTap,
    this.isLiked = false,
  });

  final String authorName;
  final String postedAgo;
  final int likesCount;
  final ImageProvider avatarImage;
  final bool showYouTag;
  final VoidCallback? onLikeTap;
  final bool isLiked;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 52.w,
          height: 52.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/images/profile.png',
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 8.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              postedAgo,
              style: TextFontStyle.textStyle14c8C7C68HelveticaNeue300,
            ),
            SizedBox(height: 4.h),
            Text(
              showYouTag ? '$authorName (You)' : authorName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextFontStyle.textStyle16c3B230EHelveticaNeue400,
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: onLikeTap,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
            child: Column(
              children: [
                Icon(
                  isLiked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: AppColors.allsecondaryColor,
                  size: 25.sp,
                ),
                SizedBox(height: 2.h),
                Text(
                  '$likesCount',
                  style: TextFontStyle.textStyle12c8C7C68HelveticaNeue400,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleActionButton extends StatelessWidget {
  const _CircleActionButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32.w,
        height: 32.w,
        decoration: BoxDecoration(
          color: AppColors.cF5EDD7.withValues(alpha: 0.60),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.c1C1919.withValues(alpha: 0.10),
              blurRadius: 8.r,
              offset: Offset(0, 6.h),
            ),
          ],
        ),
        child: SizedBox(
          width: 32.w,
          height: 32.w,
          child: Icon(
            icon,
            color: AppColors.allsecondaryColor,
            size: 16.sp,
          ),
        ),
      ),
    );
  }
}

class _ScribbleDividerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 1.6.w
      ..color = AppColors.cE8E1CB;

    final Path path = Path()..moveTo(0, size.height * 0.58);
    final double segment = size.width / 12;

    for (int i = 0; i < 12; i++) {
      final double startX = segment * i;
      final double endX = segment * (i + 1);
      final double controlX = (startX + endX) / 2;
      final bool up = i.isEven;
      final double controlY = up ? size.height * 0.28 : size.height * 0.84;
      path.quadraticBezierTo(controlX, controlY, endX, size.height * 0.58);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
