import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import '../tokens/spacing.dart';
import 'parser.dart';

const Map<String, double> _dacsBorderRadius = {
  'none': 0,
  'sm': 2,
  '': 4,
  'md': 6,
  'lg': 8,
  'xl': 12,
  '2xl': 16,
  '3xl': 24,
  'full': 9999,
};

double? _radiusSize(String key) {
  if (_dacsBorderRadius.containsKey(key)) {
    return _dacsBorderRadius[key];
  }
  return dacsSpacing(key);
}

class BorderParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final roundedMatch = RegExp(
      r'^rounded(-(t|b|l|r|tl|tr|bl|br))?(-(.+))?$',
    ).firstMatch(token);
    if (roundedMatch != null) {
      final direction = roundedMatch.group(2);
      final sizeKey = roundedMatch.group(4) ?? '';
      final size = _radiusSize(sizeKey);
      if (size == null) return false;

      style.borderRadius = _buildBorderRadius(direction, size);
      return true;
    }

    if (token == 'border') {
      style.borderWidth = 1;
      return true;
    }

    final borderWidthMatch = RegExp(
      r'^border-(\d+(?:\.\d+)?)$',
    ).firstMatch(token);
    if (borderWidthMatch != null) {
      final sizeKey = borderWidthMatch.group(1)!;
      final size = dacsSpacing(sizeKey);
      if (size != null) {
        style.borderWidth = size;
        return true;
      }
      return false;
    }

    return false;
  }

  BorderRadiusGeometry _buildBorderRadius(String? direction, double size) {
    switch (direction) {
      case 't':
        return BorderRadius.only(
          topLeft: Radius.circular(size),
          topRight: Radius.circular(size),
        );
      case 'b':
        return BorderRadius.only(
          bottomLeft: Radius.circular(size),
          bottomRight: Radius.circular(size),
        );
      case 'l':
        return BorderRadius.only(
          topLeft: Radius.circular(size),
          bottomLeft: Radius.circular(size),
        );
      case 'r':
        return BorderRadius.only(
          topRight: Radius.circular(size),
          bottomRight: Radius.circular(size),
        );
      case 'tl':
        return BorderRadius.only(topLeft: Radius.circular(size));
      case 'tr':
        return BorderRadius.only(topRight: Radius.circular(size));
      case 'bl':
        return BorderRadius.only(bottomLeft: Radius.circular(size));
      case 'br':
        return BorderRadius.only(bottomRight: Radius.circular(size));
      default:
        return BorderRadius.circular(size);
    }
  }
}
