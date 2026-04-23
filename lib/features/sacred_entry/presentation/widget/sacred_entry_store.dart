import 'package:flutter/foundation.dart';

class SacredEntryItem {
  const SacredEntryItem({
    required this.id,
    required this.title,
    required this.content,
    required this.wordCount,
    required this.entryDate,
    required this.typeLabel,
    required this.typeIconAsset,
    this.selectedPrompt,
  });

  final String id;
  final String title;
  final String content;
  final int wordCount;
  final DateTime entryDate;
  final String typeLabel;
  final String typeIconAsset;
  final String? selectedPrompt;
}

class SacredEntryStore {
  SacredEntryStore._() {
    _initializeDefaultItems();
  }

  static final SacredEntryStore instance = SacredEntryStore._();

  final ValueNotifier<List<SacredEntryItem>> _itemsNotifier =
      ValueNotifier<List<SacredEntryItem>>(<SacredEntryItem>[]);

  void _initializeDefaultItems() {
    _itemsNotifier.value = <SacredEntryItem>[
      SacredEntryItem(
        id: '1',
        title: 'Gratitude in Small Things',
        content: 'Today I noticed God\'s presence in the little things — a kind smile, unexpected rest, and the reminder that peace comes from trusting Him. Even in the busy moments, there were small blessings that reminded me of His constant care.',
        wordCount: 42,
        entryDate: DateTime(2025, 9, 24),
        typeLabel: 'Journal',
        typeIconAsset: 'assets/icons/journaling.png',
        selectedPrompt: 'What are you grateful for today?',
      ),
      SacredEntryItem(
        id: '2',
        title: 'Lessons from Nature',
        content: 'Spent time in the garden and learned so much from the flowers blooming slowly. Patience and growth cannot be rushed. Just as flowers need time, sunlight, and nourishment, our faith also requires time and care to bloom beautifully.',
        wordCount: 35,
        entryDate: DateTime(2025, 9, 9),
        typeLabel: 'Reflection',
        typeIconAsset: 'assets/icons/reflection.png',
        selectedPrompt: 'What challenge did you overcome this week?',
      ),
      SacredEntryItem(
        id: '3',
        title: 'Scripture Memory: Psalm 42:11',
        content: 'Why, my soul, are you downcast? Why so disturbed within me? Put your hope in God, for I will yet praise him, my Savior and my God. This verse has become my anchor when doubts arise.',
        wordCount: 38,
        entryDate: DateTime(2025, 9, 15),
        typeLabel: 'Memory Verses',
        typeIconAsset: 'assets/icons/memory.png',
        selectedPrompt: null,
      ),
      SacredEntryItem(
        id: '4',
        title: 'Prayer for Guidance',
        content: 'Spent time this morning in deep prayer, seeking wisdom for the decisions ahead. As I prayed, I felt a sense of peace wash over me. I trust that God will reveal His path and I will follow with open heart and ears.',
        wordCount: 41,
        entryDate: DateTime(2025, 9, 20),
        typeLabel: 'Prayer',
        typeIconAsset: 'assets/icons/prayer.png',
        selectedPrompt: 'Which prayer felt most answered lately?',
      ),
      SacredEntryItem(
        id: '5',
        title: 'Daily Bible Reading: John 15',
        content: 'Today\'s reading spoke about abiding in Christ. The metaphor of the vine and branches reminded me that I cannot bear good fruit unless I remain connected to Jesus. He is the source of all strength and purpose.',
        wordCount: 39,
        entryDate: DateTime(2025, 9, 22),
        typeLabel: 'Bible Reading',
        typeIconAsset: 'assets/icons/bible.png',
        selectedPrompt: 'What scripture stayed with you this morning?',
      ),
    ];
  }

  ValueListenable<List<SacredEntryItem>> get itemsListenable => _itemsNotifier;

  void addItem({
    required String title,
    required String content,
    required int wordCount,
    required DateTime entryDate,
    required String typeLabel,
    required String typeIconAsset,
    String? selectedPrompt,
  }) {
    final SacredEntryItem newItem = SacredEntryItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: title,
      content: content,
      wordCount: wordCount,
      entryDate: entryDate,
      typeLabel: typeLabel,
      typeIconAsset: typeIconAsset,
      selectedPrompt: selectedPrompt,
    );

    final List<SacredEntryItem> currentItems =
        List<SacredEntryItem>.from(_itemsNotifier.value);
    _itemsNotifier.value = <SacredEntryItem>[newItem, ...currentItems];
  }
}
