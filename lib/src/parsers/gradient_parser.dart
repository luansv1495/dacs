// ignore_for_file: public_member_api_docs

import '../dacs_style.dart';
import '../tokens/colors.dart';
import 'parser.dart';

/// Parses gradient tokens: `bg-gradient-to-{direction}`, `from-{color}`,
/// `via-{color}`, `to-{color}` — including theme color variants.
class GradientParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final dirMatch = RegExp(
      r'^bg-gradient-to-(r|l|t|b|tr|tl|br|bl)$',
    ).firstMatch(token);
    if (dirMatch != null) {
      style.gradientDirection = _parseDirection(dirMatch.group(1)!);
      return true;
    }

    final fromMatch = RegExp(r'^from-(.+)$').firstMatch(token);
    if (fromMatch != null) {
      final color = parseDacsColor(fromMatch.group(1)!);
      if (color != null) {
        style.gradientFromColor = color;
        return true;
      }
      return false;
    }

    final viaMatch = RegExp(r'^via-(.+)$').firstMatch(token);
    if (viaMatch != null) {
      final color = parseDacsColor(viaMatch.group(1)!);
      if (color != null) {
        style.gradientViaColor = color;
        return true;
      }
      return false;
    }

    final toMatch = RegExp(r'^to-(.+)$').firstMatch(token);
    if (toMatch != null) {
      final color = parseDacsColor(toMatch.group(1)!);
      if (color != null) {
        style.gradientToColor = color;
        return true;
      }
      return false;
    }

    return false;
  }

  DacsGradientDirection _parseDirection(String dir) {
    switch (dir) {
      case 'r':
        return DacsGradientDirection.toR;
      case 'l':
        return DacsGradientDirection.toL;
      case 't':
        return DacsGradientDirection.toT;
      case 'b':
        return DacsGradientDirection.toB;
      case 'tr':
        return DacsGradientDirection.toTR;
      case 'tl':
        return DacsGradientDirection.toTL;
      case 'br':
        return DacsGradientDirection.toBR;
      case 'bl':
        return DacsGradientDirection.toBL;
      default:
        return DacsGradientDirection.toR;
    }
  }
}
