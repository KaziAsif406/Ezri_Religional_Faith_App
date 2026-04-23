import 'package:flutter/foundation.dart';

class FaithAnchorItem {
  const FaithAnchorItem({
    required this.id,
    required this.type,
    required this.reference,
    required this.content,
    required this.personalNote,
  });

  final String id;
  final String type;
  final String reference;
  final String content;
  final String personalNote;
}

class FaithAnchorStore {
  FaithAnchorStore._() {
    _initializeDefaultItems();
  }

  static final FaithAnchorStore instance = FaithAnchorStore._();

  final ValueNotifier<List<FaithAnchorItem>> _itemsNotifier =
      ValueNotifier<List<FaithAnchorItem>>(<FaithAnchorItem>[]);

  void _initializeDefaultItems() {
    _itemsNotifier.value = <FaithAnchorItem>[
      const FaithAnchorItem(
        id: '1',
        type: 'Verse',
        reference: 'Philippians 4:6-7',
        content: 'Do not be anxious about anything, but in every situation, by prayer and petition, with thanksgiving, present your requests to God.',
        personalNote: 'A reminder to bring all my worries to God with gratitude and trust that He will guide me.',
      ),
      const FaithAnchorItem(
        id: '2',
        type: 'Promise',
        reference: 'Isaiah 26:3',
        content: 'You will keep in perfect peace those whose minds are steadfast, because they trust in you.',
        personalNote: 'When I feel overwhelmed, I remember that God promises peace when I trust Him completely.',
      ),
      const FaithAnchorItem(
        id: '3',
        type: 'Verse',
        reference: 'Proverbs 3:5-6',
        content: 'Trust in the Lord with all your heart and lean not on your own understanding.',
        personalNote: 'A daily reminder to surrender my plans and trust in God\'s perfect wisdom and guidance.',
      ),
      const FaithAnchorItem(
        id: '4',
        type: 'Reflection',
        reference: 'Psalm 23:1',
        content: 'The Lord is my shepherd, I lack nothing.',
        personalNote: 'God provides everything I need. I am safe and cared for under His protection.',
      ),
      const FaithAnchorItem(
        id: '5',
        type: 'Promise',
        reference: 'John 14:27',
        content: 'Peace I leave with you; my peace I give to you.',
        personalNote: 'The peace Christ offers is different from worldly peace - it surpasses all understanding.',
      ),
    ];
  }

  ValueListenable<List<FaithAnchorItem>> get itemsListenable => _itemsNotifier;

  void addItem({
    required String type,
    required String reference,
    required String content,
    required String personalNote,
  }) {
    final FaithAnchorItem newItem = FaithAnchorItem(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      type: type,
      reference: reference,
      content: content,
      personalNote: personalNote,
    );

    final List<FaithAnchorItem> currentItems = List<FaithAnchorItem>.from(_itemsNotifier.value);
    _itemsNotifier.value = <FaithAnchorItem>[newItem, ...currentItems];
  }

  void removeItemById(String id) {
    final List<FaithAnchorItem> updated = _itemsNotifier.value
        .where((FaithAnchorItem item) => item.id != id)
        .toList();
    _itemsNotifier.value = updated;
  }
}
