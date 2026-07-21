import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import 'parser.dart';

/// Parses alignment tokens (`align-center`, `align-topLeft`, etc.).
class AlignmentParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final match = RegExp(r'^align-(.+)$').firstMatch(token);
    if (match == null) return false;

    final v = _alignment(match.group(1)!);
    if (v != null) {
      style.alignment = v;
      return true;
    }
    return false;
  }

  AlignmentGeometry? _alignment(String key) => switch (key) {
        'topLeft' => Alignment.topLeft,
        'topCenter' || 'top' => Alignment.topCenter,
        'topRight' => Alignment.topRight,
        'centerLeft' || 'left' => Alignment.centerLeft,
        'center' => Alignment.center,
        'centerRight' || 'right' => Alignment.centerRight,
        'bottomLeft' => Alignment.bottomLeft,
        'bottomCenter' || 'bottom' => Alignment.bottomCenter,
        'bottomRight' => Alignment.bottomRight,
        _ => null,
      };
}
