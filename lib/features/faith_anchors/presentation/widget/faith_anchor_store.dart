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
  FaithAnchorStore._();

  static final FaithAnchorStore instance = FaithAnchorStore._();

  final ValueNotifier<List<FaithAnchorItem>> _itemsNotifier =
      ValueNotifier<List<FaithAnchorItem>>(<FaithAnchorItem>[]);

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
