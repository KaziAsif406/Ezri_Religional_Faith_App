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
  late List<T> _items;

  @override
  void initState() {
    super.initState();
    _items = List<T>.from(widget.items);
  }

  @override
  void didUpdateWidget(covariant StackedSwipeDeck<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.items, widget.items)) {
      _items = List<T>.from(widget.items);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_items.isEmpty) {
      return widget.emptyBuilder?.call(context, _resetDeck) ?? const SizedBox.shrink();
    }

    final int visibleCount =
        _items.length < widget.maxVisibleCards ? _items.length : widget.maxVisibleCards;

    return SizedBox(
      height: widget.deckHeight,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: List<Widget>.generate(visibleCount, (int depthIndex) {
          final int cardIndex = visibleCount - 1 - depthIndex;
          final T item = _items[cardIndex];
          final bool isTopCard = cardIndex == 0;

          return AnimatedPositioned(
            duration: widget.stackAnimationDuration,
            curve: widget.stackAnimationCurve,
            top: depthIndex * widget.topOffsetStep,
            left: widget.horizontalInset,
            right: widget.horizontalInset,
            child: AnimatedScale(
              duration: widget.stackAnimationDuration,
              curve: widget.stackAnimationCurve,
              scale: 1 + (depthIndex * widget.scaleStep),
              child: isTopCard
                  ? Dismissible(
                      key: ValueKey<String>(widget.keyBuilder(item)),
                      direction: widget.dismissDirection,
                      dismissThresholds: <DismissDirection, double>{
                        DismissDirection.startToEnd: widget.dismissThreshold,
                        DismissDirection.endToStart: widget.dismissThreshold,
                      },
                      movementDuration: widget.movementDuration,
                      resizeDuration: widget.resizeDuration,
                      background: widget.dismissBackgroundBuilder?.call(context, item) ??
                          const SizedBox.shrink(),
                      secondaryBackground:
                          widget.dismissSecondaryBackgroundBuilder?.call(context, item),
                      onDismissed: (DismissDirection direction) {
                        _removeTopItem(direction);
                      },
                      child: widget.cardBuilder(context, item, true),
                    )
                  : IgnorePointer(child: widget.cardBuilder(context, item, false)),
            ),
          );
        }),
      ),
    );
  }

  void _removeTopItem(DismissDirection direction) {
    if (_items.isEmpty) {
      return;
    }

    final T removedItem = _items.first;
    setState(() {
      _items.removeAt(0);
    });
    widget.onItemDismissed?.call(removedItem, direction);
  }

  void _resetDeck() {
    if (_items.isNotEmpty) {
      return;
    }

    setState(() {
      _items = List<T>.from(widget.items);
    });
  }
}
