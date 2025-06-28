import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => size.height;
  double get width => size.width;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double bottomPadding([double padding = 0]) {
    return mediaQuery.padding.bottom + padding;
  }

  double topPadding([double padding = 0]) {
    return mediaQuery.padding.top + padding;
  }

  double get keyboardHight => mediaQuery.viewInsets.bottom;
}
