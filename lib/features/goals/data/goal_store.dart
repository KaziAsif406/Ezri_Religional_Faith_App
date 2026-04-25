import 'package:template_flutter/features/goals/presentation/widget/frequency_selector.dart';
import 'package:template_flutter/features/goals/presentation/widget/goal_type_selector.dart';
import 'package:template_flutter/gen/assets.gen.dart';

class SavedGoal {
  const SavedGoal({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.frequency,
    required this.loggedDays,
    required this.isReminderEnabled,
    required this.selectedDays,
    required this.reminderTimeLabel,
  });

  final String title;
  final String subtitle;
  final String iconPath;
  final GoalFrequency frequency;
  final int loggedDays;
  final bool isReminderEnabled;
  final List<String> selectedDays;
  final String reminderTimeLabel;

  int get totalDaysTarget {
    final int selectedDayCount = selectedDays.isEmpty ? 1 : selectedDays.length;

    switch (frequency) {
      case GoalFrequency.daily:
        return 7;
      case GoalFrequency.weekly:
        return selectedDayCount;
      case GoalFrequency.monthly:
        return selectedDayCount * 4;
    }
  }

  double get progressValue {
    if (totalDaysTarget == 0) {
      return 0;
    }
    return (loggedDays / totalDaysTarget).clamp(0, 1);
  }

  String get dayCountLabel => '$loggedDays/$totalDaysTarget days';

  SavedGoal copyWith({
    String? title,
    String? subtitle,
    String? iconPath,
    GoalFrequency? frequency,
    int? loggedDays,
    bool? isReminderEnabled,
    List<String>? selectedDays,
    String? reminderTimeLabel,
  }) {
    return SavedGoal(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      iconPath: iconPath ?? this.iconPath,
      frequency: frequency ?? this.frequency,
      loggedDays: loggedDays ?? this.loggedDays,
      isReminderEnabled: isReminderEnabled ?? this.isReminderEnabled,
      selectedDays: selectedDays ?? this.selectedDays,
      reminderTimeLabel: reminderTimeLabel ?? this.reminderTimeLabel,
    );
  }
}

final class GoalStore {
  GoalStore._();

  static final GoalStore instance = GoalStore._();

  final List<SavedGoal> _goals = <SavedGoal>[
    const SavedGoal(
      title: 'Read 1 Chapter Daily',
      subtitle: '',
      iconPath: 'assets/icons/bible.png',
      frequency: GoalFrequency.daily,
      loggedDays: 3,
      isReminderEnabled: false,
      selectedDays: <String>['M', 'T', 'W', 'T', 'F'],
      reminderTimeLabel: '09:00 AM',
    ),
    const SavedGoal(
      title: '5-Day Prayer Streak',
      subtitle: '',
      iconPath: 'assets/icons/prayer.png',
      frequency: GoalFrequency.weekly,
      loggedDays: 3,
      isReminderEnabled: true,
      selectedDays: <String>['S', 'M', 'T'],
      reminderTimeLabel: '07:00 AM',
    ),
    const SavedGoal(
      title: 'Memorize 10 Verses',
      subtitle: '',
      iconPath: 'assets/icons/memory.png',
      frequency: GoalFrequency.monthly,
      loggedDays: 0,
      isReminderEnabled: true,
      selectedDays: <String>['W'],
      reminderTimeLabel: '08:30 PM',
    ),
  ];

  List<SavedGoal> get goals => List<SavedGoal>.unmodifiable(_goals);

  void addGoal(SavedGoal goal) {
    _goals.insert(0, goal);
  }

  void logGoalAt(int index) {
    if (index < 0 || index >= _goals.length) {
      return;
    }

    final SavedGoal currentGoal = _goals[index];

    final int nextLoggedDays = currentGoal.loggedDays + 1;
    final int resetAwareLoggedDays =
        nextLoggedDays >= currentGoal.totalDaysTarget ? 0 : nextLoggedDays;

    _goals[index] = currentGoal.copyWith(
      loggedDays: resetAwareLoggedDays,
    );
  }

  void resetToDefaults() {
    _goals
      ..clear()
      ..addAll(<SavedGoal>[
        const SavedGoal(
          title: 'Read 1 Chapter Daily',
          subtitle: '',
          iconPath: 'assets/icons/bible.png',
          frequency: GoalFrequency.daily,
          loggedDays: 3,
          isReminderEnabled: false,
          selectedDays: <String>['M', 'T', 'W', 'T', 'F'],
          reminderTimeLabel: '09:00 AM',
        ),
        const SavedGoal(
          title: '5-Day Prayer Streak',
          subtitle: '',
          iconPath: 'assets/icons/prayer.png',
          frequency: GoalFrequency.weekly,
          loggedDays: 3,
          isReminderEnabled: true,
          selectedDays: <String>['S', 'M', 'T'],
          reminderTimeLabel: '07:00 AM',
        ),
        const SavedGoal(
          title: 'Memorize 10 Verses',
          subtitle: '',
          iconPath: 'assets/icons/memory.png',
          frequency: GoalFrequency.monthly,
          loggedDays: 0,
          isReminderEnabled: true,
          selectedDays: <String>['W'],
          reminderTimeLabel: '08:30 PM',
        ),
      ]);
  }
}

String goalIconPathForType(GoalType type) {
  switch (type) {
    case GoalType.bibleReading:
      return Assets.icons.bible.path;
    case GoalType.prayer:
      return Assets.icons.prayer.path;
    case GoalType.fasting:
      return Assets.icons.fasting.path;
    case GoalType.reflection:
      return Assets.icons.reflection.path;
    case GoalType.memoryVerses:
      return Assets.icons.memory.path;
    case GoalType.journaling:
      return Assets.icons.journaling.path;
    case GoalType.other:
      return Assets.icons.journalEmpty.path;
  }
}

String goalTitleForSelection(GoalType type, GoalFrequency frequency) {
  final String baseTitle;
  switch (type) {
    case GoalType.bibleReading:
      baseTitle = 'Bible Reading';
      break;
    case GoalType.prayer:
      baseTitle = 'Prayer';
      break;
    case GoalType.fasting:
      baseTitle = 'Fasting';
      break;
    case GoalType.reflection:
      baseTitle = 'Reflection';
      break;
    case GoalType.memoryVerses:
      baseTitle = 'Memory Verses';
      break;
    case GoalType.journaling:
      baseTitle = 'Journaling';
      break;
    case GoalType.other:
      baseTitle = 'Custom Goal';
      break;
  }

  switch (frequency) {
    case GoalFrequency.daily:
      return '$baseTitle Daily';
    case GoalFrequency.weekly:
      return '$baseTitle Weekly';
    case GoalFrequency.monthly:
      return '$baseTitle Monthly';
  }
}

String goalSubtitleForSelection(
  GoalFrequency frequency,
  List<String> selectedDays,
  bool isReminderEnabled,
  String reminderTimeLabel,
) {
  final int selectedDayCount = selectedDays.isEmpty ? 1 : selectedDays.length;
  final int totalTarget;

  switch (frequency) {
    case GoalFrequency.daily:
      totalTarget = 7;
      break;
    case GoalFrequency.weekly:
      totalTarget = selectedDayCount;
      break;
    case GoalFrequency.monthly:
      totalTarget = selectedDayCount * 4;
      break;
  }

  return '0/$totalTarget days';
}
