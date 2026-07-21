import '../dacs_style.dart';
import 'parser.dart';

/// Parses aspect ratio tokens (`aspect-square`, `aspect-video`, `aspect-[4/3]`).
class AspectParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final match = RegExp(r'^aspect-(.+)$').firstMatch(token);
    if (match == null) return false;

    final key = match.group(1)!;
    if (key == 'square') {
      style.aspectRatio = 1.0;
      return true;
    }
    if (key == 'video') {
      style.aspectRatio = 16 / 9;
      return true;
    }

    // Arbitrary aspect-[w/h]
    final arb =
        RegExp(r'^\[(\d+(?:\.\d+)?)\s*/\s*(\d+(?:\.\d+)?)\]$').firstMatch(key);
    if (arb != null) {
      final w = double.tryParse(arb.group(1)!);
      final h = double.tryParse(arb.group(2)!);
      if (w != null && h != null && h != 0) {
        style.aspectRatio = w / h;
        return true;
      }
    }

    return false;
  }
}
