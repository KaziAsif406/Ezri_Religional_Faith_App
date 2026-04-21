import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:template_flutter/common_widgets/custom_appbar.dart';
import 'package:template_flutter/common_widgets/custom_button.dart';
import 'package:template_flutter/common_widgets/custom_switch.dart';
import 'package:template_flutter/common_widgets/custom_textform_field.dart';
import 'package:template_flutter/common_widgets/selector_widget.dart';
import 'package:template_flutter/constants/text_font_style.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/prompt_selector_section.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/section_title.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/rounded_input_shell.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/round_action_button.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/text_editing_footer.dart';
import 'package:template_flutter/features/sacred_entry/presentation/widget/wavy_separator.dart';

import '../../../gen/colors.gen.dart';

enum SacredTypeOption { reflection, memoryVerses, journaling, bibleReading, prayer, fasting }

class AddSacredEntryScreen extends StatefulWidget {
  const AddSacredEntryScreen({super.key});

  @override
  State<AddSacredEntryScreen> createState() => _AddSacredEntryScreenState();
}

class _AddSacredEntryScreenState extends State<AddSacredEntryScreen> {
  final Random _random = Random();
  final TextEditingController _entryController = TextEditingController();
  final List<String> _promptPool = <String>[
    'What are you grateful for today?',
    'What challenge did you overcome this week?',
    'Which prayer felt most answered lately?',
    'Where did you notice grace today?',
    'What scripture stayed with you this morning?',
    'What did you release to God this week?',
    'Which moment made your faith feel stronger?',
    'How did you practice kindness today?',
    'What blessing surprised you this week?',
    'What truth are you holding onto right now?',
  ];

  SacredTypeOption _selectedType = SacredTypeOption.reflection;
  bool _promptEnabled = false;
  DateTime _selectedDate = DateTime.now();
  List<String> _activePrompts = <String>[];
  int _selectedPromptIndex = 0;

  @override
  void initState() {
    super.initState();
    _activePrompts = _generatePromptPair(previousPair: const <String>[]);
  }

  @override
  void dispose() {
    _entryController.dispose();
    super.dispose();
  }

  int _wordCount(String text) {
    return text
        .trim()
        .split(RegExp(r'\s+'))
        .where((String word) => word.isNotEmpty)
        .length;
  }

  String _formattedDate(DateTime date) {
    const List<String> months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  List<String> _generatePromptPair({
    required List<String> previousPair,
    bool forceBothNew = false,
  }) {
    if (_promptPool.length < 2) {
      return List<String>.from(_promptPool);
    }

    final List<String> shuffled = List<String>.from(_promptPool)..shuffle(_random);

    if (forceBothNew && previousPair.length == 2) {
      final Set<String> previousSet = previousPair.toSet();
      final List<String> candidates = shuffled
          .where((String prompt) => !previousSet.contains(prompt))
          .toList();
      if (candidates.length >= 2) {
        return <String>[candidates[0], candidates[1]];
      }
    }

    List<String> nextPair = <String>[shuffled[0], shuffled[1]];

    // Avoid showing the exact same pair after a shuffle when alternatives exist.
    if (previousPair.length == 2 && _promptPool.length > 2) {
      final Set<String> previousSet = previousPair.toSet();
      if (nextPair.toSet().containsAll(previousSet)) {
        nextPair = <String>[shuffled[0], shuffled[2]];
      }
    }

    return nextPair;
  }

  void _onPromptToggle(bool value) {
    setState(() {
      _promptEnabled = value;
      if (_promptEnabled && _activePrompts.length < 2) {
        _activePrompts = _generatePromptPair(previousPair: const <String>[]);
      }
      if (_promptEnabled) {
        _selectedPromptIndex = 0;
      }
    });
  }

  void _shufflePrompts() {
    setState(() {
      _activePrompts = _generatePromptPair(
        previousPair: _activePrompts,
        forceBothNew: true,
      );
      _selectedPromptIndex = 0;
    });
  }

  void _onPromptCardTap(int index) {
    setState(() {
      _selectedPromptIndex = index;
    });
  }

  Future<void> _pickEntryDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime(2100, 12, 31),
      initialDatePickerMode: DatePickerMode.day,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.c6B2F45,
              onPrimary: AppColors.cF5EDD7,
              surface: AppColors.allPrimaryColor,
              onSurface: AppColors.c513B26,
            ),
            dialogTheme: DialogThemeData(
              backgroundColor: AppColors.allPrimaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );

    if (pickedDate == null || !mounted) {
      return;
    }

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final int words = _wordCount(_entryController.text);

    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              titleText: 'Add Sacred Entry',
            ),
            Transform.translate(
              offset: Offset(0, -25.h),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      lightText: 'Select',
                      darkText: 'Date',
                    ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: _pickEntryDate,
                      child: RoundedInputShell(
                        child: Row(
                          children: [
                            Text(
                              _formattedDate(_selectedDate),
                              style: TextFontStyle
                                  .textStyle14c3B230EHelveticaNeue300
                                  .copyWith(
                                fontSize: 16.sp,
                                color: AppColors.c685E4A,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.allPrimaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.c1C1919
                                        .withValues(alpha: 0.20),
                                    blurRadius: 8.r,
                                    offset: Offset(0, 4.h),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.calendar_month_outlined,
                                size: 22.sp,
                                color: AppColors.c513B26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 28.h),
                    SectionTitle(
                      lightText: 'Sacred',
                      darkText: 'Type',
                    ),
                    SizedBox(height: 12.h),
                    SelectorWidget<SacredTypeOption>(
                      selectedValue: _selectedType,
                      height: 76.h,
                      spacing: 0.w,
                      borderRadius: BorderRadius.circular(24.r),
                      horizontalPadding: 15.w,
                      selectedButtonGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.allPrimaryColor,
                          AppColors.allPrimaryColor,
                        ],
                      ),
                      unselectedButtonGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.cC7BFAD,
                          AppColors.cC7BFAD,
                        ],
                      ),
                      selectedBorderColor: AppColors.allsecondaryColor.withValues(alpha: 0.60),
                      unselectedBorderColor: AppColors.allsecondaryColor.withValues(alpha: 0.12),

                      selectedTextStyle: TextFontStyle.textStyle14c3B230EHelveticaNeue500.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedTextStyle: TextFontStyle.textStyle16c796956HelveticaNeue400.copyWith(
                        fontSize: 15.sp,
                        color: AppColors.c8C7C68,
                        fontWeight: FontWeight.w400,
                      ),
                      options: <SelectorOption<SacredTypeOption>>[
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.reflection,
                          label: 'Reflection',
                          leading: Image.asset(
                            'assets/icons/reflection.png',
                            width: 42.w,
                            height: 42.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.memoryVerses,
                          label: 'Memory Verses',
                          leading: Image.asset(
                            'assets/icons/memory.png',
                            width: 42.w,
                            height: 42.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.journaling,
                          label: 'Journaling',
                          leading: Image.asset(
                            'assets/icons/journaling.png',
                            width: 42.w,
                            height: 42.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.bibleReading,
                          label: 'Bible Reading',
                          leading: Image.asset(
                            'assets/icons/bible.png',
                            width: 42.w,
                            height: 42.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.prayer,
                          label: 'Prayer',
                          leading: Image.asset(
                            'assets/icons/prayer.png',
                            width: 42.w,
                            height: 42.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                        SelectorOption<SacredTypeOption>(
                          value: SacredTypeOption.fasting,
                          label: 'Fasting',
                          leading: Image.asset(
                            'assets/icons/fasting.png',
                            width: 42.w,
                            height: 42.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                      onChanged: (SacredTypeOption value) {
                        setState(() {
                          _selectedType = value;
                        });
                      },
                    ),
                    SizedBox(height: 34.h),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SectionTitle(
                            lightText: 'Prompt',
                            darkText: 'Selector',
                          ),
                        ),
                        CustomSwitch(
                          value: _promptEnabled,
                          onChanged: _onPromptToggle,
                          width: 48,
                          height: 28,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      switchInCurve: Curves.easeOutCubic,
                      switchOutCurve: Curves.easeInCubic,
                      transitionBuilder: (Widget child, Animation<double> animation) {
                        return SizeTransition(
                          sizeFactor: animation,
                          axisAlignment: -1,
                          child: FadeTransition(
                            opacity: animation,
                            child: child,
                          ),
                        );
                      },
                      child: !_promptEnabled
                          ? const SizedBox(key: ValueKey<String>('prompt-cards-hidden'))
                          : PromptSelectorSection(
                              key: const ValueKey<String>('prompt-cards-visible'),
                              prompts: _activePrompts,
                              selectedIndex: _selectedPromptIndex,
                              onPromptTap: _onPromptCardTap,
                              onShuffleTap: _shufflePrompts,
                            ),
                    ),
                    const WavySeparator(),
                    SizedBox(height: 26.h),
                    SectionTitle(
                      lightText: 'Sacred',
                      darkText: 'Entry',
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundActionButton(
                          icon: Icons.mic_none_rounded,
                          onTap: () {},
                          filled: true,
                        ),
                        SizedBox(width: 26.w),
                        RoundActionButton(
                          iconText: 'Aa',
                          onTap: () {},
                          filled: false,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      'What are you grateful for today?',
                      style: TextFontStyle.textStyle14c3B230EHelveticaNeue400,
                    ),
                    SizedBox(height: 14.h),
                    CustomTextFormField(
                      controller: _entryController,
                      maxLines: 5,
                      minLines: 5,
                      onChanged: (_) => setState(() {}),
                      useCardStyle: true,
                      cardBackgroundColor:
                          AppColors.allPrimaryColor,
                      cardBorderColor:
                          AppColors.c99907A.withValues(alpha: 0.48),
                      cardBorderRadius: BorderRadius.circular(24.r),
                      cardPadding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                      contentPadding: EdgeInsets.zero,
                      footerLeft: const TextEditingFooterButtons(),
                      footerRight: Text(
                        '$words/300 words',
                        style: TextFontStyle.textStyle14c8C7C68HelveticaNeue400
                            .copyWith(fontSize: 16.sp),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    const WavySeparator(),
                    SizedBox(height: 26.h),
                    Text(
                      'Verses',
                      style: TextFontStyle.textStyle24c8C7C68HelveticaNeue300,
                    ),
                    SizedBox(height: 14.h),
                    RoundedInputShell(
                      child: Row(
                        children: [
                          Text(
                            'Attach a Verse',
                            style: TextFontStyle
                                .textStyle14c3B230EHelveticaNeue300
                                .copyWith(
                              fontSize: 16.sp,
                              color: AppColors.c685E4A,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    AppColors.allPrimaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.c1C1919
                                        .withValues(alpha: 0.20),
                                    blurRadius: 8.r,
                                    offset: Offset(0, 4.h),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.attach_file_rounded,
                                size: 22.sp,
                                color: AppColors.c513B26,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 34.h),
                    CustomButton(
                      onPressed: () {},
                      title: 'Save Entry',
                      height: 60.h,
                      borderRadius: BorderRadius.circular(5555.r),
                      backgroundGradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          AppColors.cF5EDD7.withValues(alpha: 0.76),
                          AppColors.c6B2F45.withValues(alpha: 0.92),
                        ],
                      ),
                      textStyle: TextFontStyle
                          .textStyle16cFFFFFFHelveticaNeue500
                          .copyWith(
                        color: AppColors.cF5EDD7,
                      ),
                    ),
                    SizedBox(height: 42.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


