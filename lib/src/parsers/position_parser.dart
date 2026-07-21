import '../dacs_style.dart';
import '../tokens/spacing.dart';
import 'parser.dart';

class PositionParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    var match = RegExp(r'^inset(?:-([xytblr]))?(?:-(.+))?$').firstMatch(token);
    if (match != null) {
      final axis = match.group(1);
      final sizeKey = match.group(2) ?? '0';

      if (sizeKey == 'auto') return false;

      final size = dacsSpacing(sizeKey);
      if (size == null) return false;

      switch (axis) {
        case 'x':
          style.insetLeft = _merge(style.insetLeft, size);
          style.insetRight = _merge(style.insetRight, size);
        case 'y':
          style.insetTop = _merge(style.insetTop, size);
          style.insetBottom = _merge(style.insetBottom, size);
        case 't':
          style.insetTop = _merge(style.insetTop, size);
        case 'b':
          style.insetBottom = _merge(style.insetBottom, size);
        case 'l':
          style.insetLeft = _merge(style.insetLeft, size);
        case 'r':
          style.insetRight = _merge(style.insetRight, size);
        default:
          style.insetTop = _merge(style.insetTop, size);
          style.insetRight = _merge(style.insetRight, size);
          style.insetBottom = _merge(style.insetBottom, size);
          style.insetLeft = _merge(style.insetLeft, size);
      }
      return true;
    }

    match = RegExp(r'^(top|right|bottom|left)-(.+)$').firstMatch(token);
    if (match != null) {
      final side = match.group(1)!;
      final sizeKey = match.group(2)!;

      if (sizeKey == 'auto') return false;

      final size = dacsSpacing(sizeKey);
      if (size == null) return false;

      switch (side) {
        case 'top':
          style.insetTop = _merge(style.insetTop, size);
        case 'right':
          style.insetRight = _merge(style.insetRight, size);
        case 'bottom':
          style.insetBottom = _merge(style.insetBottom, size);
        case 'left':
          style.insetLeft = _merge(style.insetLeft, size);
      }
      return true;
    }

    return false;
  }

  double _merge(double? existing, double incoming) =>
      (existing ?? 0) + incoming;
}
