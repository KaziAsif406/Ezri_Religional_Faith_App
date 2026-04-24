import 'package:template_flutter/features/goals/presentation/widget/frequency_selector.dart';
import 'package:template_flutter/features/goals/presentation/widget/goal_type_selector.dart';
import 'package:template_flutter/gen/assets.gen.dart';

class SavedGoal {
  const SavedGoal({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.frequency,
    required this.progress,
    required this.isLocked,
    required this.isReminderEnabled,
    required this.selectedDays,
    required this.reminderTimeLabel,
  });

  final String title;
  final String subtitle;
  final String iconPath;
  final GoalFrequency frequency;
  final double progress;
  final bool isLocked;
  final bool isReminderEnabled;
  final List<String> selectedDays;
  final String reminderTimeLabel;

  SavedGoal copyWith({
    String? title,
    String? subtitle,
    String? iconPath,
    GoalFrequency? frequency,
    double? progress,
    bool? isLocked,
    bool? isReminderEnabled,
    List<String>? selectedDays,
    String? reminderTimeLabel,
  }) {
    return SavedGoal(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      iconPath: iconPath ?? this.iconPath,
      frequency: frequency ?? this.frequency,
      progress: progress ?? this.progress,
      isLocked: isLocked ?? this.isLocked,
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
      subtitle: '3/7 days',
      iconPath: 'assets/icons/bible.png',
      frequency: GoalFrequency.daily,
      progress: 0.43,
      isLocked: false,
      isReminderEnabled: false,
      selectedDays: <String>['M', 'T', 'W', 'T', 'F'],
      reminderTimeLabel: '09:00 AM',
    ),
    const SavedGoal(
      title: '5-Day Prayer Streak',
      subtitle: '3/5 days',
      iconPath: 'assets/icons/prayer.png',
      frequency: GoalFrequency.weekly,
      progress: 0.60,
      isLocked: false,
      isReminderEnabled: true,
      selectedDays: <String>['S', 'M', 'T'],
      reminderTimeLabel: '07:00 AM',
    ),
    const SavedGoal(
      title: 'Memorize 10 Verses',
      subtitle: '0/10 complete',
      iconPath: 'assets/icons/memory.png',
      frequency: GoalFrequency.monthly,
      progress: 0.0,
      isLocked: true,
      isReminderEnabled: true,
      selectedDays: <String>['W'],
      reminderTimeLabel: '08:30 PM',
    ),
  ];

  List<SavedGoal> get goals => List<SavedGoal>.unmodifiable(_goals);

  void addGoal(SavedGoal goal) {
    _goals.insert(0, goal);
  }

  void resetToDefaults() {
    _goals
      ..clear()
      ..addAll(<SavedGoal>[
        const SavedGoal(
          title: 'Read 1 Chapter Daily',
          subtitle: '3/7 days',
          iconPath: 'assets/icons/bible.png',
          frequency: GoalFrequency.daily,
          progress: 0.43,
          isLocked: false,
          isReminderEnabled: false,
          selectedDays: <String>['M', 'T', 'W', 'T', 'F'],
          reminderTimeLabel: '09:00 AM',
        ),
        const SavedGoal(
          title: '5-Day Prayer Streak',
          subtitle: '3/5 days',
          iconPath: 'assets/icons/prayer.png',
          frequency: GoalFrequency.weekly,
          progress: 0.60,
          isLocked: false,
          isReminderEnabled: true,
          selectedDays: <String>['S', 'M', 'T'],
          reminderTimeLabel: '07:00 AM',
        ),
        const SavedGoal(
          title: 'Memorize 10 Verses',
          subtitle: '0/10 complete',
          iconPath: 'assets/icons/memory.png',
          frequency: GoalFrequency.monthly,
          progress: 0.0,
          isLocked: true,
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
  final String daySummary =
      selectedDays.isEmpty ? 'No days selected' : selectedDays.join(', ');
  final String reminderSummary =
      isReminderEnabled ? 'Reminder $reminderTimeLabel' : 'No reminder';

  switch (frequency) {
    case GoalFrequency.daily:
      return '$daySummary · $reminderSummary';
    case GoalFrequency.weekly:
    case GoalFrequency.monthly:
      return '$daySummary · $reminderSummary';
  }
}
