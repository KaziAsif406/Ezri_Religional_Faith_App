// // lib/features/profile/presentation/profile_screen.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../../../common_widgets/custom_appbar.dart';
// import '../../../common_widgets/no_data_widget.dart';
// import '../../../common_widgets/not_found_widget.dart';
// import '../../../common_widgets/waiting_widget.dart';
// import '../../../constants/text_font_style.dart';
// import '../../../gen/colors.gen.dart';
// import '../../../helpers/ui_helpers.dart';
// import '../../../networks/api_acess.dart';
// import '../model/user_model.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});

//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }

// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Assuming you have a profile API call method
//     profileRxObj.featchProfile();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(
//         showBackArrow: true,
//         title: Text(
//           "Profile",
//           style: TextFontStyle.textStyle18c172B4DDMSans500,
//         ),
//         centerTitle: true,
//       ),
//       body: SafeArea(
//         child: StreamBuilder(
//           stream: profileRxObj.fileData,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const WaitingWidget();
//             } else if (snapshot.hasData && snapshot.data != null) {
//               final responseData = snapshot.data!;

//               // Parse the response
//               ProfileResModel profileResponse;
//               try {
//                 profileResponse = ProfileResModel.fromJson(responseData);
//               } catch (e) {
//                 return const Center(
//                   child: NoDataWidget(
//                     title: 'Data Error',
//                     subtitle: 'Failed to parse profile data',
//                   ),
//                 );
//               }

//               final user = profileResponse.data!.user;

//               return SingleChildScrollView(
//                 padding: EdgeInsets.all(16.w),
//                 child: Column(
//                   children: [
//                     // Profile Header
//                     _buildProfileHeader(user!),
//                     UIHelper.verticalSpace(24.h),

//                     // Profile Details
//                     _buildProfileDetails(user),
//                   ],
//                 ),
//               );
//             } else if (snapshot.hasError) {
//               return const NotFoundWidget();
//             } else {
//               // For demo - replace with actual API call
//               return const SizedBox.shrink();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildProfileHeader(User user) {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: AppColors.cFFFFFF,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.c000000.withValues(alpha: 0.1),
//             blurRadius: 8.r,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           // Profile Avatar
//           Container(
//             width: 60.w,
//             height: 60.h,
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: AppColors.allPrimaryColor,
//             ),
//             child: Center(
//               child: Text(
//                 user.name!.isNotEmpty ? user.name![0].toUpperCase() : 'U',
//                 style: TextFontStyle.textStyle20cFFFFFFDMSans600,
//               ),
//             ),
//           ),
//           UIHelper.horizontalSpace(16.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   user.name ?? '',
//                   style: TextFontStyle.textStyle18c202020DMSans600,
//                 ),
//                 UIHelper.verticalSpace(4.h),
//                 Text(
//                   user.email ?? '',
//                   style: TextFontStyle.textStyle14c606060DMSans400,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildProfileDetails(User user) {
//     return Container(
//       padding: EdgeInsets.all(20.w),
//       decoration: BoxDecoration(
//         color: AppColors.cFFFFFF,
//         borderRadius: BorderRadius.circular(12.r),
//         boxShadow: [
//           BoxShadow(
//             color: AppColors.c000000.withValues(alpha: 0.1),
//             blurRadius: 8.r,
//             offset: Offset(0, 2.h),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           _buildDetailItem(
//             icon: Icons.person_outline,
//             title: 'Full Name',
//             value: user.name ?? '',
//           ),
//           _buildDivider(),
//           _buildDetailItem(
//             icon: Icons.email_outlined,
//             title: 'Email Address',
//             value: user.email ?? '',
//           ),
//           _buildDivider(),
//           _buildDetailItem(
//             icon: Icons.phone_outlined,
//             title: 'Phone Number',
//             value: user.phone ?? '',
//           ),
//           _buildDivider(),
//         ],
//       ),
//     );
//   }

//   Widget _buildDetailItem({
//     required IconData icon,
//     required String title,
//     required String value,
//   }) {
//     return Padding(
//       padding: EdgeInsets.symmetric(vertical: 12.h),
//       child: Row(
//         children: [
//           Icon(
//             icon,
//             size: 20.sp,
//             color: AppColors.allPrimaryColor,
//           ),
//           UIHelper.horizontalSpace(12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextFontStyle.textStyle12c949494DMSans400,
//                 ),
//                 UIHelper.verticalSpace(2.h),
//                 Text(
//                   value,
//                   style: TextFontStyle.textStyle14c202020DMSans500,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildDivider() {
//     return Container(
//       height: 1.h,
//       color: AppColors.cE8E8E8,
//     );
//   }
// }
