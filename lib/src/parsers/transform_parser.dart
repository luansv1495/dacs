import '../dacs_style.dart';
import '../tokens/spacing.dart';
import 'parser.dart';

const Map<String, double> _dacsScaleValues = {
  '0': 0,
  '50': 0.5,
  '75': 0.75,
  '90': 0.9,
  '95': 0.95,
  '100': 1.0,
  '105': 1.05,
  '110': 1.1,
  '125': 1.25,
  '150': 1.5,
};

class TransformParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    if (token == 'scale-0') {
      style.scaleX = 0;
      style.scaleY = 0;
      return true;
    }

    final scaleMatch = RegExp(r'^scale(?:-([xy]))?-(.+)$').firstMatch(token);
    if (scaleMatch != null) {
      final axis = scaleMatch.group(1);
      final valueKey = scaleMatch.group(2)!;
      final value = _dacsScaleValues[valueKey];
      if (value == null) return false;

      switch (axis) {
        case 'x':
          style.scaleX = value;
        case 'y':
          style.scaleY = value;
        default:
          style.scaleX = value;
          style.scaleY = value;
      }
      return true;
    }

    final rotateMatch = RegExp(r'^rotate-(-?\d+)$').firstMatch(token);
    if (rotateMatch != null) {
      style.rotateDegrees = double.parse(rotateMatch.group(1)!);
      return true;
    }

    final translateMatch = RegExp(r'^translate-([xy])-(.+)$').firstMatch(token);
    if (translateMatch != null) {
      final axis = translateMatch.group(1)!;
      final sizeKey = translateMatch.group(2)!;

      if (sizeKey == 'auto') return false;

      final size = dacsSpacing(sizeKey);
      if (size == null) return false;

      switch (axis) {
        case 'x':
          style.translateX = _merge(style.translateX, size);
        case 'y':
          style.translateY = _merge(style.translateY, size);
      }
      return true;
    }

    final skewMatch = RegExp(r'^skew-([xy])-(-?\d+)$').firstMatch(token);
    if (skewMatch != null) {
      final axis = skewMatch.group(1)!;
      final degrees = double.parse(skewMatch.group(2)!);

      switch (axis) {
        case 'x':
          style.skewX = _merge(style.skewX, degrees);
        case 'y':
          style.skewY = _merge(style.skewY, degrees);
      }
      return true;
    }

    return false;
  }

  double _merge(double? existing, double incoming) =>
      (existing ?? 0) + incoming;
}
