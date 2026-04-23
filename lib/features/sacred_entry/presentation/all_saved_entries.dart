import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/sacred_entry_store.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/saved_entries_card.dart';
import 'package:template_flutter/gen/colors.gen.dart';
// import 'package:template_flutter/helpers/navigation_service.dart';
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
  OverlayEntry? _overlayEntry;
  // ignore: unused_field
  SacredEntryItem? _selectedEntry;
  Offset _menuPosition = Offset.zero;

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
    _overlayEntry?.remove();
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
            pinned: true,
            floating: true,
            snap: true,
            expandedHeight: 160.h,
            toolbarHeight: 1.h,
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
              height: 72.h,
              safeAreaPadding: 0,
              child: Container(
                color: AppColors.scaffoldColor,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
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
          // List of entries with proper spacing
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (_filteredEntries.isEmpty) {
                  return Container(
                    decoration: BoxDecoration(
                      color: AppColors.allPrimaryColor.withValues(alpha: 0.00),
                    ),
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
                  onMenuTap: (GlobalKey menuKey) {
                    _showEntryMenu(context, entry, menuKey);
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

  void _showEntryMenu(
    BuildContext context,
    SacredEntryItem entry,
    GlobalKey menuKey,
  ) {
    // Remove any existing overlay entry
    _overlayEntry?.remove();

    // Get the position of the menu button
    final RenderBox? renderBox =
        menuKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset buttonPosition = renderBox.localToGlobal(Offset.zero);
    final Size buttonSize = renderBox.size;

    _selectedEntry = entry;
    _menuPosition = Offset(
      buttonPosition.dx - 120.w, // Offset to align right
      buttonPosition.dy + buttonSize.height + 8.h,
    );

    // Create overlay entry
    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Stack(
          children: <Widget>[
            // Tap outside to close
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMenu,
                child: Container(color: Colors.transparent),
              ),
            ),
            // Floating menu
            Positioned(
              left: _menuPosition.dx - 20,
              top: _menuPosition.dy,
              child: Material(
                color: AppColors.allPrimaryColor.withValues(alpha: 0.00),
                child: Container(
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: AppColors.allPrimaryColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: AppColors.allsecondaryColor.withValues(alpha: 0.30),
                      width: 1.w,
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: AppColors.c1C1919.withValues(alpha: 0.15),
                        blurRadius: 16.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      // Edit option
                      GestureDetector(
                        onTap: () {
                          _closeMenu();
                          // Handle edit
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.edit_rounded,
                                size: 18.sp,
                                color: AppColors.c513B26,
                              ),
                              UIHelper.horizontalSpaceSmall,
                              Text(
                                'Edit',
                                style: TextFontStyle
                                    .textStyle14c3B230EHelveticaNeue400
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: AppColors.c352619,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Divider
                      Divider(
                        height: 1.h,
                        color: AppColors.cF2F2F2.withValues(alpha: 0.50),
                        indent: 12.w,
                        endIndent: 12.w,
                      ),
                      // Delete option
                      GestureDetector(
                        onTap: () {
                          _closeMenu();
                          // Handle delete
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 12.h,
                          ),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.delete_rounded,
                                size: 18.sp,
                                color: Colors.red.shade400,
                              ),
                              UIHelper.horizontalSpaceSmall,
                              Text(
                                'Delete',
                                style: TextFontStyle
                                    .textStyle14c3B230EHelveticaNeue400
                                    .copyWith(
                                  fontSize: 14.sp,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );

    // Add overlay to the overlay stack
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _closeMenu() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _selectedEntry = null;
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
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(_SearchBarDelegate oldDelegate) {
    return height != oldDelegate.height || child != oldDelegate.child;
  }
}
