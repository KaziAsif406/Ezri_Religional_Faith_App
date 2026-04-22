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
  SacredEntryStore._();

  static final SacredEntryStore instance = SacredEntryStore._();

  final ValueNotifier<List<SacredEntryItem>> _itemsNotifier =
      ValueNotifier<List<SacredEntryItem>>(<SacredEntryItem>[]);

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
