import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StackedSwipeDeck<T> extends StatefulWidget {
  const StackedSwipeDeck({
    super.key,
    required this.items,
    required this.keyBuilder,
    required this.cardBuilder,
    this.emptyBuilder,
    this.maxVisibleCards = 3,
    this.deckHeight = 160,
    this.topOffsetStep = -15,
    this.scaleStep = 0.09,
    this.horizontalInset = 30,
    this.dismissDirection = DismissDirection.horizontal,
    this.dismissThreshold = 0.24,
    this.movementDuration = const Duration(milliseconds: 190),
    this.resizeDuration = const Duration(milliseconds: 170),
    this.stackAnimationDuration = const Duration(milliseconds: 320),
    this.stackAnimationCurve = Curves.easeOut,
    this.dismissBackgroundBuilder,
    this.dismissSecondaryBackgroundBuilder,
    this.onItemDismissed,
  });

  final List<T> items;
  final String Function(T item) keyBuilder;
  final Widget Function(BuildContext context, T item, bool isTopCard) cardBuilder;
  final Widget Function(BuildContext context, VoidCallback resetDeck)? emptyBuilder;

  final int maxVisibleCards;
  final double deckHeight;
  final double topOffsetStep;
  final double scaleStep;
  final double horizontalInset;

  final DismissDirection dismissDirection;
  final double dismissThreshold;
  final Duration movementDuration;
  final Duration resizeDuration;
  final Duration stackAnimationDuration;
  final Curve stackAnimationCurve;

  final Widget Function(BuildContext context, T item)? dismissBackgroundBuilder;
  final Widget Function(BuildContext context, T item)? dismissSecondaryBackgroundBuilder;
  final void Function(T item, DismissDirection direction)? onItemDismissed;

  @override
  State<StackedSwipeDeck<T>> createState() => _StackedSwipeDeckState<T>();
}

class _StackedSwipeDeckState<T> extends State<StackedSwipeDeck<T>> {
  late List<_StackedDeckEntry<T>> _entries;

  @override
  void initState() {
    super.initState();
    _entries = _buildEntries(widget.items);
  }

  @override
  void didUpdateWidget(covariant StackedSwipeDeck<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.items, widget.items)) {
      _entries = _buildEntries(widget.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_entries.isEmpty) {
      return widget.emptyBuilder?.call(context, _resetDeck) ?? const SizedBox.shrink();
    }

    final int visibleCount =
        _entries.length < widget.maxVisibleCards ? _entries.length : widget.maxVisibleCards;
    final List<_StackedDeckEntry<T>> visibleEntries = _entries.take(visibleCount).toList();

    return SizedBox(
      height: widget.deckHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: List<Widget>.generate(visibleCount, (int displayIndex) {
          final _StackedDeckEntry<T> entry = visibleEntries[visibleCount - 1 - displayIndex];
          final String itemKey = widget.keyBuilder(entry.item);
          final bool isTopCard = entry.depth == 0;
          final int scaleDepth = (widget.maxVisibleCards - 1 - entry.depth)
              .clamp(0, widget.maxVisibleCards - 1)
              .toInt();

          return AnimatedPositioned(
            key: ValueKey<String>(itemKey),
            duration: widget.stackAnimationDuration,
            curve: widget.stackAnimationCurve,
            top: entry.depth * widget.topOffsetStep,
            left: widget.horizontalInset,
            right: widget.horizontalInset,
            child: AnimatedScale(
              duration: widget.stackAnimationDuration,
              curve: widget.stackAnimationCurve,
              scale: 1 + (scaleDepth * widget.scaleStep),
              child: isTopCard
                  ? Dismissible(
                      key: ValueKey<String>(itemKey),
                      direction: widget.dismissDirection,
                      dismissThresholds: <DismissDirection, double>{
                        DismissDirection.startToEnd: widget.dismissThreshold,
                        DismissDirection.endToStart: widget.dismissThreshold,
                      },
                      movementDuration: widget.movementDuration,
                      resizeDuration: widget.resizeDuration,
                      background: widget.dismissBackgroundBuilder?.call(context, entry.item) ??
                          const SizedBox.shrink(),
                      secondaryBackground:
                          widget.dismissSecondaryBackgroundBuilder?.call(context, entry.item),
                      onDismissed: (DismissDirection direction) {
                        _removeTopItem(direction);
                      },
                      child: widget.cardBuilder(context, entry.item, true),
                    )
                  : IgnorePointer(child: widget.cardBuilder(context, entry.item, false)),
            ),
          );
        }),
      ),
    );
  }

  void _removeTopItem(DismissDirection direction) {
    if (_entries.isEmpty) {
      return;
    }

    final _StackedDeckEntry<T> removedEntry = _entries.first;
    setState(() {
      _entries.removeAt(0);
      for (int index = 0; index < _entries.length; index++) {
        _entries[index] = _entries[index].copyWith(depth: index);
      }
    });
    widget.onItemDismissed?.call(removedEntry.item, direction);
  }

  void _resetDeck() {
    if (_entries.isNotEmpty) {
      return;
    }

    setState(() {
      _entries = _buildEntries(widget.items);
    });
  }

  List<_StackedDeckEntry<T>> _buildEntries(List<T> items) {
    return List<_StackedDeckEntry<T>>.generate(
      items.length,
      (int index) => _StackedDeckEntry<T>(item: items[index], depth: index),
    );
  }
}

class _StackedDeckEntry<T> {
  const _StackedDeckEntry({
    required this.item,
    required this.depth,
  });

  final T item;
  final int depth;

  _StackedDeckEntry<T> copyWith({
    T? item,
    int? depth,
  }) {
    return _StackedDeckEntry<T>(
      item: item ?? this.item,
      depth: depth ?? this.depth,
    );
  }
}
