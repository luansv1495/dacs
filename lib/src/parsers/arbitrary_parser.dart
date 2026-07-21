import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import 'parser.dart';

class ArbitraryParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final match = RegExp(r'^([a-z]+(?:-[a-z]+)*)-\[(.+)\]$').firstMatch(token);
    if (match == null) return false;
    final prefix = match.group(1)!;
    final raw = match.group(2)!;

    if (_isColor(raw)) {
      final color = _parseColorValue(raw);
      if (color == null) return false;
      return _setColor(prefix, style, color);
    }

    if (raw.endsWith('%')) {
      final pct = double.tryParse(raw.substring(0, raw.length - 1));
      if (pct == null) return false;
      return _setPercent(prefix, style, pct);
    }

    final numValue = double.tryParse(raw);
    if (numValue == null) return false;
    return _setNumeric(prefix, style, numValue);
  }

  bool _isColor(String value) =>
      value.startsWith('#') ||
      value.startsWith('rgb') ||
      value.startsWith('hsl');

  Color? _parseColorValue(String raw) {
    if (raw.startsWith('#')) {
      final hex = raw.substring(1);
      if (hex.length == 3) {
        final r = int.parse(hex[0], radix: 16) * 17;
        final g = int.parse(hex[1], radix: 16) * 17;
        final b = int.parse(hex[2], radix: 16) * 17;
        return Color.fromARGB(255, r, g, b);
      }
      if (hex.length == 6) return Color(int.parse('FF$hex', radix: 16));
      if (hex.length == 8) return Color(int.parse(hex, radix: 16));
      return null;
    }

    final rgba = RegExp(
      r'^rgba?\((\d+),\s*(\d+),\s*(\d+)(?:,\s*([0-9.]+))?\)$',
    ).firstMatch(raw);
    if (rgba != null) {
      final r = int.parse(rgba.group(1)!);
      final g = int.parse(rgba.group(2)!);
      final b = int.parse(rgba.group(3)!);
      final a = rgba.group(4) != null
          ? (double.parse(rgba.group(4)!) * 255).round()
          : 255;
      return Color.fromARGB(a, r, g, b);
    }
    return null;
  }

  bool _setPercent(String prefix, DacsStyle style, double value) {
    switch (prefix) {
      case 'w':
        style.width = value;
        return true;
      case 'h':
        style.height = value;
        return true;
      case 'opacity':
        style.opacity = (value / 100).clamp(0.0, 1.0);
        return true;
      case 'inset':
        style.insetTop = style.insetRight = style.insetBottom =
            style.insetLeft = value / 100;
        return true;
      case 'inset-x':
        style.insetLeft = style.insetRight = value / 100;
        return true;
      case 'inset-y':
        style.insetTop = style.insetBottom = value / 100;
        return true;
      case 'top':
        style.insetTop = value / 100;
        return true;
      case 'right':
        style.insetRight = value / 100;
        return true;
      case 'bottom':
        style.insetBottom = value / 100;
        return true;
      case 'left':
        style.insetLeft = value / 100;
        return true;
      case 'border':
        style.borderWidth = value;
        return true;
    }
    return false;
  }

  bool _setColor(String prefix, DacsStyle style, Color color) {
    switch (prefix) {
      case 'text':
        style.color = color;
        return true;
      case 'bg':
        style.backgroundColor = color;
        return true;
      case 'border':
        style.borderColor = color;
        return true;
      case 'decoration':
        style.textDecorationColor = color;
        return true;
      case 'from':
        style.gradientFromColor = color;
        return true;
      case 'via':
        style.gradientViaColor = color;
        return true;
      case 'to':
        style.gradientToColor = color;
        return true;
    }
    return false;
  }

  bool _setNumeric(String prefix, DacsStyle style, double value) {
    switch (prefix) {
      case 'p':
        style.padding = EdgeInsets.all(value);
        return true;
      case 'px':
        style.padding = _mergeEdgeInsets(
          style.padding,
          EdgeInsets.symmetric(horizontal: value),
        );
        return true;
      case 'py':
        style.padding = _mergeEdgeInsets(
          style.padding,
          EdgeInsets.symmetric(vertical: value),
        );
        return true;
      case 'pt':
        style.padding = _mergeEdgeInsets(
          style.padding,
          EdgeInsets.only(top: value),
        );
        return true;
      case 'pr':
        style.padding = _mergeEdgeInsets(
          style.padding,
          EdgeInsets.only(right: value),
        );
        return true;
      case 'pb':
        style.padding = _mergeEdgeInsets(
          style.padding,
          EdgeInsets.only(bottom: value),
        );
        return true;
      case 'pl':
        style.padding = _mergeEdgeInsets(
          style.padding,
          EdgeInsets.only(left: value),
        );
        return true;
      case 'm':
        style.margin = EdgeInsets.all(value);
        return true;
      case 'mx':
        style.margin = _mergeEdgeInsets(
          style.margin,
          EdgeInsets.symmetric(horizontal: value),
        );
        return true;
      case 'my':
        style.margin = _mergeEdgeInsets(
          style.margin,
          EdgeInsets.symmetric(vertical: value),
        );
        return true;
      case 'mt':
        style.margin = _mergeEdgeInsets(
          style.margin,
          EdgeInsets.only(top: value),
        );
        return true;
      case 'mr':
        style.margin = _mergeEdgeInsets(
          style.margin,
          EdgeInsets.only(right: value),
        );
        return true;
      case 'mb':
        style.margin = _mergeEdgeInsets(
          style.margin,
          EdgeInsets.only(bottom: value),
        );
        return true;
      case 'ml':
        style.margin = _mergeEdgeInsets(
          style.margin,
          EdgeInsets.only(left: value),
        );
        return true;
      case 'w':
        style.width = value;
        return true;
      case 'h':
        style.height = value;
        return true;
      case 'text':
        style.fontSize = value;
        return true;
      case 'opacity':
        style.opacity = value.clamp(0.0, 1.0);
        return true;
      case 'rounded':
        style.borderRadius = BorderRadius.circular(value);
        return true;
      case 'rounded-t':
        style.borderRadius = BorderRadius.vertical(top: Radius.circular(value));
        return true;
      case 'rounded-b':
        style.borderRadius = BorderRadius.vertical(
          bottom: Radius.circular(value),
        );
        return true;
      case 'rounded-l':
        style.borderRadius = BorderRadius.horizontal(
          left: Radius.circular(value),
        );
        return true;
      case 'rounded-r':
        style.borderRadius = BorderRadius.horizontal(
          right: Radius.circular(value),
        );
        return true;
      case 'rounded-tl':
        style.borderRadius = _addBorderRadius(
          style.borderRadius,
          (r) => r.copyWith(topLeft: Radius.circular(value)),
        );
        return true;
      case 'rounded-tr':
        style.borderRadius = _addBorderRadius(
          style.borderRadius,
          (r) => r.copyWith(topRight: Radius.circular(value)),
        );
        return true;
      case 'rounded-bl':
        style.borderRadius = _addBorderRadius(
          style.borderRadius,
          (r) => r.copyWith(bottomLeft: Radius.circular(value)),
        );
        return true;
      case 'rounded-br':
        style.borderRadius = _addBorderRadius(
          style.borderRadius,
          (r) => r.copyWith(bottomRight: Radius.circular(value)),
        );
        return true;
      case 'border':
        style.borderWidth = value;
        return true;
      case 'gap':
        return false;
      case 'inset':
        style.insetTop = style.insetRight = style.insetBottom =
            style.insetLeft = value;
        return true;
      case 'inset-x':
        style.insetLeft = style.insetRight = value;
        return true;
      case 'inset-y':
        style.insetTop = style.insetBottom = value;
        return true;
      case 'top':
        style.insetTop = value;
        return true;
      case 'right':
        style.insetRight = value;
        return true;
      case 'bottom':
        style.insetBottom = value;
        return true;
      case 'left':
        style.insetLeft = value;
        return true;
      case 'scale':
        style.scaleX = style.scaleY = value / 100;
        return true;
      case 'scale-x':
        style.scaleX = value / 100;
        return true;
      case 'scale-y':
        style.scaleY = value / 100;
        return true;
      case 'rotate':
        style.rotateDegrees = value;
        return true;
      case 'translate-x':
        style.translateX = value;
        return true;
      case 'translate-y':
        style.translateY = value;
        return true;
      case 'skew-x':
        style.skewX = value;
        return true;
      case 'skew-y':
        style.skewY = value;
        return true;
      case 'leading':
        style.lineHeight = value;
        return true;
      case 'tracking':
        style.letterSpacing = value;
        return true;
    }
    return false;
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

  BorderRadiusGeometry _addBorderRadius(
    BorderRadiusGeometry? existing,
    BorderRadiusGeometry Function(BorderRadius) update,
  ) {
    return update(existing is BorderRadius ? existing : BorderRadius.zero);
  }
}
