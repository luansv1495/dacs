// ignore_for_file: public_member_api_docs

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

/// Parses border tokens: border radius (`rounded-*` with directional variants
/// including RTL-aware logical corners) and border width (`border`,
/// `border-2`…`border-8`).
class BorderParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final roundedRtlMatch = RegExp(
      r'^rounded-(ts|te|bs|be|ss|se|es|ee)(-(.+))?$',
    ).firstMatch(token);
    if (roundedRtlMatch != null) {
      final corner = roundedRtlMatch.group(1)!;
      final sizeKey = roundedRtlMatch.group(3) ?? '';
      final size = _radiusSize(sizeKey);
      if (size == null) return false;
      style.borderRadius = _buildRtlRadius(corner, size);
      return true;
    }

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

  BorderRadiusGeometry _buildRtlRadius(String corner, double size) {
    return switch (corner) {
      'ts' => BorderRadius.only(topLeft: Radius.circular(size)),
      'te' => BorderRadius.only(topRight: Radius.circular(size)),
      'bs' => BorderRadius.only(bottomLeft: Radius.circular(size)),
      'be' => BorderRadius.only(bottomRight: Radius.circular(size)),
      'ss' => BorderRadiusDirectional.only(topStart: Radius.circular(size)),
      'se' => BorderRadiusDirectional.only(topEnd: Radius.circular(size)),
      'es' => BorderRadiusDirectional.only(bottomStart: Radius.circular(size)),
      'ee' => BorderRadiusDirectional.only(bottomEnd: Radius.circular(size)),
      _ => BorderRadius.circular(size),
    };
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
