import '../dacs_style.dart';
import '../tokens/spacing.dart';
import '../tokens/shadows.dart';
import 'parser.dart';

/// Parses layout tokens: width (`w-*`), height (`h-*`), opacity (`opacity-*`),
/// and box shadows (`shadow-sm`…`shadow-2xl`, `shadow-inner`, `shadow-none`).
class LayoutParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    if (token == 'flex') return true;
    if (token == 'flex-row') return true;
    if (token == 'flex-col') return true;
    if (token == 'flex-wrap') return true;
    if (token == 'flex-nowrap') return true;

    final widthMatch = RegExp(r'^w-(.+)$').firstMatch(token);
    if (widthMatch != null) {
      return _parseSize(widthMatch.group(1)!, (v) => style.width = v);
    }

    final heightMatch = RegExp(r'^h-(.+)$').firstMatch(token);
    if (heightMatch != null) {
      return _parseSize(heightMatch.group(1)!, (v) => style.height = v);
    }

    final opacityMatch = RegExp(r'^opacity-(\d+)$').firstMatch(token);
    if (opacityMatch != null) {
      final value = int.parse(opacityMatch.group(1)!);
      if (value >= 0 && value <= 100) {
        style.opacity = value / 100;
        return true;
      }
      return false;
    }

    final shadowMatch = RegExp(r'^shadow-(.+)$').firstMatch(token);
    if (shadowMatch != null) {
      final key = shadowMatch.group(1)!;
      if (key == 'none') return true;
      if (dacsShadows.containsKey(key)) {
        style.boxShadow = dacsShadows[key];
        return true;
      }
      return false;
    }

    if (token == 'shadow') {
      style.boxShadow = dacsShadows['DEFAULT'];
      return true;
    }

    return false;
  }

  bool _parseSize(String key, void Function(double?) setter) {
    if (key == 'full') {
      setter(double.infinity);
      return true;
    }
    if (key == 'auto') {
      setter(0);
      return true;
    }
    final size = dacsSpacing(key);
    if (size != null) {
      setter(size);
      return true;
    }
    return false;
  }
}
