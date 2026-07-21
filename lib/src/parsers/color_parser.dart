import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import '../tokens/colors.dart';
import 'parser.dart';

Color? _parseDacsColor(String token) {
  if (token == 'black') return const Color(0xFF000000);
  if (token == 'white') return const Color(0xFFFFFFFF);
  if (token == 'transparent') return const Color(0x00000000);

  final match = RegExp(r'^([a-z]+)-(\d+)$').firstMatch(token);
  if (match != null) {
    final colorName = match.group(1)!;
    final shade = int.parse(match.group(2)!);
    final color = DacsColors.all[colorName];
    if (color != null) {
      return color[shade];
    }
  }
  return null;
}

class ColorParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final textMatch = RegExp(r'^text-(.+)$').firstMatch(token);
    if (textMatch != null) {
      final colorKey = textMatch.group(1)!;
      final color = _parseDacsColor(colorKey);
      if (color != null) {
        style.color = color;
        return true;
      }
      return false;
    }

    final bgMatch = RegExp(r'^bg-(.+)$').firstMatch(token);
    if (bgMatch != null) {
      final colorKey = bgMatch.group(1)!;
      final color = _parseDacsColor(colorKey);
      if (color != null) {
        style.backgroundColor = color;
        return true;
      }
      return false;
    }

    final borderMatch = RegExp(r'^border-(.+)$').firstMatch(token);
    if (borderMatch != null) {
      final colorKey = borderMatch.group(1)!;
      final color = _parseDacsColor(colorKey);
      if (color != null) {
        style.borderColor = color;
        return true;
      }
      return false;
    }

    return false;
  }
}
