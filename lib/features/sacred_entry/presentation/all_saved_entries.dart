import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/sacred_entry_store.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/saved_entries_card.dart';
import 'package:template_flutter/gen/colors.gen.dart';
import 'package:template_flutter/helpers/navigation_service.dart';
import 'package:template_flutter/helpers/ui_helpers.dart';

class AllSavedEntriesScreen extends StatefulWidget {
  const AllSavedEntriesScreen({super.key});

  @override
  State<AllSavedEntriesScreen> createState() => _AllSavedEntriesScreenState();
}

class _AllSavedEntriesScreenState extends State<AllSavedEntriesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final SacredEntryStore _store = SacredEntryStore.instance;
  List<SacredEntryItem> _filteredEntries = <SacredEntryItem>[];

  @override
  void initState() {
    super.initState();
    _store.itemsListenable.addListener(_updateFilteredEntries);
    _updateFilteredEntries();
  }

  @override
  void dispose() {
    _store.itemsListenable.removeListener(_updateFilteredEntries);
    _searchController.dispose();
    super.dispose();
  }

  void _updateFilteredEntries() {
    final String query = _searchController.text.toLowerCase();
    final List<SacredEntryItem> allEntries =
        (_store.itemsListenable as ValueNotifier<List<SacredEntryItem>>).value;

    if (query.isEmpty) {
      _filteredEntries = allEntries;
    } else {
      _filteredEntries = allEntries
          .where((SacredEntryItem item) =>
              item.title.toLowerCase().contains(query) ||
              item.content.toLowerCase().contains(query) ||
              item.typeLabel.toLowerCase().contains(query))
          .toList();
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: CustomScrollView(
        slivers: <Widget>[
          // Collapsible header with title and back button
          SliverAppBar(
            backgroundColor: AppColors.scaffoldColor,
            automaticallyImplyLeading: false,
            pinned: false,
            floating: true,
            snap: false,
            expandedHeight: 160.h, // Height for header + search bar
            flexibleSpace: FlexibleSpaceBar(
              background: CustomAppBar(
                titleText: 'Saved Entries',
              ),
            ),
          ),
          // Pinned search bar that stays at top when scrolling
          SliverPersistentHeader(
            pinned: true,
            delegate: _SearchBarDelegate(
              height: 80.h,
              safeAreaPadding: MediaQuery.of(context).padding.top,
              child: Container(
                color: AppColors.scaffoldColor,
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 12.h),
                child: Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColors.allPrimaryColor,
                    borderRadius: BorderRadius.circular(28.r),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.c1C1919.withValues(alpha: 0.08),
                        blurRadius: 12.r,
                        offset: Offset(0, 2.h),
                      ),
                    ],
                  ),
                  child: Row(
                    children: <Widget>[
                      UIHelper.horizontalSpaceMedium,
                      Icon(
                        Icons.search_rounded,
                        size: 24.sp,
                        color: AppColors.c8C7C68,
                      ),
                      UIHelper.horizontalSpaceSmall,
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          onChanged: (_) => _updateFilteredEntries(),
                          decoration: InputDecoration(
                            hintText: 'Search here...',
                            hintStyle: TextFontStyle
                                .textStyle10c513B26HelveticaNeue400
                                .copyWith(
                              fontSize: 16.sp,
                              color: AppColors.c8C7C68.withValues(alpha: 0.60),
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          style: TextFontStyle.textStyle14c3B230EHelveticaNeue400
                              .copyWith(
                            fontSize: 16.sp,
                            color: AppColors.c352619,
                          ),
                          cursorColor: AppColors.c513B26,
                        ),
                      ),
                      // Filter icon
                      Padding(
                        padding: EdgeInsets.only(right: 16.w),
                        child: Icon(
                          Icons.tune_rounded,
                          size: 24.sp,
                          color: AppColors.c685E4A,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // List of entries
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (_filteredEntries.isEmpty) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.note_outlined,
                            size: 64.sp,
                            color: AppColors.c8C7C68.withValues(alpha: 0.30),
                          ),
                          UIHelper.verticalSpaceMedium,
                          Text(
                            'No entries found',
                            style: TextFontStyle
                                .textStyle16c8C7C68HelveticaNeue400
                                .copyWith(
                              fontSize: 16.sp,
                              color: AppColors.c8C7C68,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final SacredEntryItem entry = _filteredEntries[index];
                return SavedEntriesCard(
                  entry: entry,
                  onTap: () {
                    // Handle entry tap - navigate to detail screen
                  },
                  onMenuTap: () {
                    // Handle menu tap - show delete/edit options
                    _showEntryMenu(context, entry);
                  },
                );
              },
              childCount: _filteredEntries.isEmpty ? 1 : _filteredEntries.length,
            ),
          ),
        ],
      ),
    );
  }

  void _showEntryMenu(BuildContext context, SacredEntryItem entry) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.allPrimaryColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(24.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.c8C7C68.withValues(alpha: 0.20),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              UIHelper.verticalSpaceMedium,
              Text(
                'Entry Options',
                style:
                    TextFontStyle.textStyle16c3B230EHelveticaNeue500.copyWith(
                  fontSize: 16.sp,
                  color: AppColors.c352619,
                  fontWeight: FontWeight.w600,
                ),
              ),
              UIHelper.verticalSpaceMedium,
              ListTile(
                leading: Icon(
                  Icons.edit_rounded,
                  size: 24.sp,
                  color: AppColors.c513B26,
                ),
                title: Text(
                  'Edit Entry',
                  style:
                      TextFontStyle.textStyle14c3B230EHelveticaNeue400.copyWith(
                    fontSize: 14.sp,
                    color: AppColors.c352619,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle edit
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.delete_rounded,
                  size: 24.sp,
                  color: Colors.red.shade400,
                ),
                title: Text(
                  'Delete Entry',
                  style:
                      TextFontStyle.textStyle14c3B230EHelveticaNeue400.copyWith(
                    fontSize: 14.sp,
                    color: Colors.red.shade400,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  // Handle delete
                },
              ),
              UIHelper.verticalSpaceSmall,
            ],
          ),
        );
      },
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  _SearchBarDelegate({
    required this.height,
    required this.safeAreaPadding,
    required this.child,
  });

  final double height;
  final double safeAreaPadding;
  final Widget child;

  @override
  double get minExtent => height + safeAreaPadding;

  @override
  double get maxExtent => height + safeAreaPadding;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: EdgeInsets.only(top: safeAreaPadding),
      child: child,
    );
  }

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) {
    return height != oldDelegate.height ||
        safeAreaPadding != oldDelegate.safeAreaPadding ||
        child != oldDelegate.child;
  }
}
