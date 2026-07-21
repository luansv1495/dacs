import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import '../tokens/spacing.dart';
import 'parser.dart';

/// Parses spacing tokens: padding (`p-*`, `px-*`, `py-*`, `pt-*`, etc.) and
/// margin (`m-*`, `mx-*`, `my-*`, `mt-*`, etc.) using the Tailwind spacing scale.
class SpacingParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final padMatch = RegExp(r'^p([xytblr])?-(.+)$').firstMatch(token);
    if (padMatch != null) {
      final direction = padMatch.group(1);
      final sizeKey = padMatch.group(2)!;
      final size = dacsSpacing(sizeKey);
      if (size == null) return false;
      style.padding = _mergeEdgeInsets(
        style.padding,
        _edgeInsets(direction, size),
      );
      return true;
    }

    final marginMatch = RegExp(r'^m([xytblr])?-(.+)$').firstMatch(token);
    if (marginMatch != null) {
      final direction = marginMatch.group(1);
      final sizeKey = marginMatch.group(2)!;
      if (sizeKey == 'auto') return false;
      final size = dacsSpacing(sizeKey);
      if (size == null) return false;
      style.margin = _mergeEdgeInsets(
        style.margin,
        _edgeInsets(direction, size),
      );
      return true;
    }

    final gapMatch = RegExp(r'^gap-(.+)$').firstMatch(token);
    if (gapMatch != null) {
      final sizeKey = gapMatch.group(1)!;
      final size = dacsSpacing(sizeKey);
      if (size == null) return false;
      style.gap = size;
      return true;
    }

    return false;
  }

  EdgeInsets _edgeInsets(String? direction, double size) {
    switch (direction) {
      case 'x':
        return EdgeInsets.symmetric(horizontal: size);
      case 'y':
        return EdgeInsets.symmetric(vertical: size);
      case 't':
        return EdgeInsets.only(top: size);
      case 'b':
        return EdgeInsets.only(bottom: size);
      case 'l':
        return EdgeInsets.only(left: size);
      case 'r':
        return EdgeInsets.only(right: size);
      default:
        return EdgeInsets.all(size);
    }
  }

  EdgeInsets _mergeEdgeInsets(EdgeInsets? existing, EdgeInsets incoming) {
    if (existing == null) return incoming;
    return EdgeInsets.only(
      left: existing.left + incoming.left,
      top: existing.top + incoming.top,
      right: existing.right + incoming.right,
      bottom: existing.bottom + incoming.bottom,
    );
  }
}
