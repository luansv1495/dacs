import '../dacs_style.dart';
import '../tokens/colors.dart';
import 'parser.dart';

class ColorParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final textMatch = RegExp(r'^text-(.+)$').firstMatch(token);
    if (textMatch != null) {
      final colorKey = textMatch.group(1)!;
      final color = parseDacsColor(colorKey);
      if (color != null) {
        style.color = color;
        return true;
      }
      return false;
    }

    final bgMatch = RegExp(r'^bg-(.+)$').firstMatch(token);
    if (bgMatch != null) {
      final colorKey = bgMatch.group(1)!;
      final color = parseDacsColor(colorKey);
      if (color != null) {
        style.backgroundColor = color;
        return true;
      }
      return false;
    }

    final borderMatch = RegExp(r'^border-(.+)$').firstMatch(token);
    if (borderMatch != null) {
      final colorKey = borderMatch.group(1)!;
      final color = parseDacsColor(colorKey);
      if (color != null) {
        style.borderColor = color;
        return true;
      }
      return false;
    }

    final decorationMatch = RegExp(r'^decoration-(.+)$').firstMatch(token);
    if (decorationMatch != null) {
      final colorKey = decorationMatch.group(1)!;
      final color = parseDacsColor(colorKey);
      if (color != null) {
        style.textDecorationColor = color;
        return true;
      }
      return false;
    }

    return false;
  }
}
