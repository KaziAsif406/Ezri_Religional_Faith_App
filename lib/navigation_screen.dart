// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import 'gen/colors.gen.dart';

// class NavigationScreen extends StatefulWidget {
// 	const NavigationScreen({super.key});

// 	@override
// 	State<NavigationScreen> createState() => _NavigationScreenState();
// }

// class _NavigationScreenState extends State<NavigationScreen> {
// 	int _currentIndex = 1;

// 	@override
// 	Widget build(BuildContext context) {
// 		return Scaffold(
// 			extendBody: true,
// 			backgroundColor: AppColors.scaffoldColor,
// 			body: IndexedStack(
// 				index: _currentIndex,
// 				children: const [
// 					_NavPage(title: 'Word'),
// 					_NavPage(title: 'Home'),
// 					_NavPage(title: 'Journey'),
// 				],
// 			),
// 			bottomNavigationBar: Container(
//                 decoration: BoxDecoration(
//                     color: AppColors.cA19782.withValues(alpha: 0.0),
//                 ),
// 				child: CurvedNavigationBar(
// 					index: _currentIndex,
// 					height: 75,
// 					backgroundColor: AppColors.scaffoldColor.withValues(alpha: 0.0),
// 					color: AppColors.cA19782,
// 					buttonBackgroundColor: AppColors.allsecondaryColor,
// 					animationCurve: Curves.easeOutCubic,
// 					animationDuration: const Duration(milliseconds: 300),
// 					onTap: (int index) {
// 						setState(() {
// 							_currentIndex = index;
// 						});
// 					},
// 					items: <Widget>[
// 						_NavBarItem(
// 							iconPath: 'assets/icons/word.png',
// 							label: 'Word',
// 							selected: _currentIndex == 0,
// 						),
// 						_NavBarItem(
// 							iconPath: 'assets/icons/menu.png',
// 							label: 'Home',
// 							selected: _currentIndex == 1,
// 							extraLarge: true,
// 						),
// 						_NavBarItem(
// 							iconPath: 'assets/icons/journey.png',
// 							label: 'Journey',
// 							selected: _currentIndex == 2,
// 						),
// 					],
// 				),
// 			),
// 		);
// 	}
// }

// class _NavPage extends StatelessWidget {
// 	final String title;

// 	const _NavPage({required this.title});

// 	@override
// 	Widget build(BuildContext context) {
// 		return ColoredBox(
// 			color: AppColors.scaffoldColor,
// 			child: Center(
// 				child: Text(
// 					title,
// 					style: TextStyle(
// 						color: AppColors.allsecondaryColor.withValues(alpha: 0.5),
// 						fontSize: 18.sp,
// 						fontWeight: FontWeight.w400,
// 					),
// 				),
// 			),
// 		);
// 	}
// }

// class _NavBarItem extends StatelessWidget {
// 	final String iconPath;
// 	final String label;
// 	final bool selected;
// 	final bool extraLarge;

// 	const _NavBarItem({
// 		required this.iconPath,
// 		required this.label,
// 		required this.selected,
// 		this.extraLarge = false,
// 	});

// 	@override
// 	Widget build(BuildContext context) {
// 		final Color foregroundColor = selected
// 			? Colors.white
// 			: AppColors.allsecondaryColor.withValues(alpha: 0.78);
// 		final Color textColor = selected
// 			? Colors.white
// 			: AppColors.allsecondaryColor.withValues(alpha: 0.76);

// 		return Column(
// 			mainAxisSize: MainAxisSize.min,
// 			mainAxisAlignment: MainAxisAlignment.center,
// 			children: [
// 				SizedBox(
// 							width: selected && extraLarge ? 48.w : 24.w,
// 							height: selected && extraLarge ? 48.w : 24.w,
// 					child: Center(
// 						child: Image.asset(
// 							iconPath,
// 									width: selected && extraLarge ? 30.w : 21.w,
// 									height: selected && extraLarge ? 30.w : 21.w,
// 							color: foregroundColor,
// 							colorBlendMode: BlendMode.srcIn,
// 						),
// 					),
// 				),
// 						SizedBox(height: selected && extraLarge ? 6.h : 2.h),
// 				Text(
// 					label,
// 					style: TextStyle(
// 						color: textColor,
// 								fontSize: selected && extraLarge ? 12.sp : selected ? 10.sp : 16.sp,
// 						fontWeight: FontWeight.w400,
// 						height: 1,
// 					),
// 				),
// 			],
// 		);
// 	}
// }
