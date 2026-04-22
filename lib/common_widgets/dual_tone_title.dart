import 'package:flutter/material.dart';

class DualToneTitle extends StatelessWidget {
  const DualToneTitle({
    super.key,
    required this.lightText,
    required this.darkText,
    required this.lightTextStyle,
    required this.darkTextStyle,
  });

  final String lightText;
  final String darkText;
  final TextStyle lightTextStyle;
  final TextStyle darkTextStyle;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '$lightText ',
            style: lightTextStyle,
          ),
          TextSpan(
            text: darkText,
            style: darkTextStyle,
          ),
        ],
      ),
    );
  }
}
