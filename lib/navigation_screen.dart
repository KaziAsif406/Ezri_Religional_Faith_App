import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/features/journey/presentation/journey.dart';

import 'features/home/presentation/home.dart';
import 'gen/colors.gen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 1;
  bool _isBottomNavVisible = true;

  void _setBottomNavVisible(bool isVisible) {
    if (_isBottomNavVisible == isVisible) {
      return;
    }

    setState(() {
      _isBottomNavVisible = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: AppColors.scaffoldColor,
      body: NotificationListener<UserScrollNotification>(
        onNotification: (notification) {
          if (notification.depth != 0) {
            return false;
          }

          if (notification.direction == ScrollDirection.reverse) {
            _setBottomNavVisible(false);
          } else if (notification.direction == ScrollDirection.forward) {
            _setBottomNavVisible(true);
          }

          return false;
        },
        child: IndexedStack(
          index: _currentIndex,
          children: const [
            _NavPage(title: 'Word'),
            HomeScreen(),
            JourneyScreen(),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 360),
        curve: Curves.easeOutCubic,
        height: _isBottomNavVisible ? 132.h : 25.h,
        child: ClipRect(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: _BottomNavBar(
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                  _isBottomNavVisible = true;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _BottomNavBar({
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/bottom_nav.png',
              width: 1.sw,
              height: 96.h,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            left: 35.w,
            right: 35.w,
            bottom: 25.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 28.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _RegularNavButton(
                    iconPath: 'assets/icons/word.png',
                    label: 'Word',
                    selected: currentIndex == 0,
                    onTap: () => onTap(0),
                  ),
                  SizedBox(width: 72.w),
                  _RegularNavButton(
                    iconPath: 'assets/icons/journey.png',
                    label: 'Journey',
                    selected: currentIndex == 2,
                    onTap: () => onTap(2),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4.h,
            left: 0,
            right: 0,
            child: _CenterNavButton(
              iconPath: 'assets/icons/menu.png',
              selected: currentIndex == 1,
              onTap: () => onTap(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavPage extends StatelessWidget {
  final String title;

  const _NavPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.scaffoldColor,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: AppColors.allsecondaryColor.withValues(alpha: 0.5),
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class _RegularNavButton extends StatelessWidget {
  final String iconPath;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _RegularNavButton({
    required this.iconPath,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color foregroundColor = selected
        ? AppColors.allsecondaryColor
        : AppColors.allsecondaryColor.withValues(alpha: 0.50);
    final Color textColor = selected
        ? AppColors.allsecondaryColor
        : AppColors.allsecondaryColor.withValues(alpha: 0.55);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 28.w,
            height: 28.h,
            color: foregroundColor,
            colorBlendMode: BlendMode.srcIn,
          ),
          SizedBox(height: 6.h),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _CenterNavButton extends StatelessWidget {
  final String iconPath;
  final bool selected;
  final VoidCallback onTap;

  const _CenterNavButton({
    required this.iconPath,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor =
        selected ? AppColors.allsecondaryColor : AppColors.cA19782;
    final Color iconColor =
        selected ? Colors.white : AppColors.allsecondaryColor;

    return Center(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          width: 78.w,
          height: 78.h,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bgColor,
            border: Border.all(
              color: AppColors.allPrimaryColor.withValues(alpha: 0.45),
              width: 2.w,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 44, 44, 44).withValues(alpha: 0.25),
                blurRadius: 9.r,
                offset: Offset(0, 8.h),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 30.w,
              height: 30.w,
              color: iconColor,
              colorBlendMode: BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
