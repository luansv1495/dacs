import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import '../tokens/typography.dart';
import 'parser.dart';

class TypographyParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    if (token == 'italic') {
      style.fontStyle = FontStyle.italic;
      return true;
    }
    if (token == 'not-italic') {
      style.fontStyle = FontStyle.normal;
      return true;
    }
    if (token == 'underline') {
      style.textDecoration = TextDecoration.underline;
      return true;
    }
    if (token == 'line-through') {
      style.textDecoration = TextDecoration.lineThrough;
      return true;
    }
    if (token == 'no-underline') {
      style.textDecoration = TextDecoration.none;
      return true;
    }

    final textMatch = RegExp(r'^text-(.+)$').firstMatch(token);
    if (textMatch != null) {
      final size = textMatch.group(1)!;
      if (dacsFontSizes.containsKey(size)) {
        style.fontSize = dacsFontSizes[size];
        return true;
      }
      return false;
    }

    final fontMatch = RegExp(r'^font-(.+)$').firstMatch(token);
    if (fontMatch != null) {
      final weight = fontMatch.group(1)!;
      if (dacsFontWeights.containsKey(weight)) {
        style.fontWeight = dacsFontWeights[weight];
        return true;
      }
      return false;
    }

    final leadingMatch = RegExp(r'^leading-(.+)$').firstMatch(token);
    if (leadingMatch != null) {
      final key = leadingMatch.group(1)!;
      if (dacsLineHeights.containsKey(key)) {
        style.lineHeight = dacsLineHeights[key]! / style.fontSize!;
        return true;
      }
      if (dacsLineHeightRelative.containsKey(key)) {
        style.lineHeight = dacsLineHeightRelative[key];
        return true;
      }
      return false;
    }

    final trackingMatch = RegExp(r'^tracking-(.+)$').firstMatch(token);
    if (trackingMatch != null) {
      final key = trackingMatch.group(1)!;
      if (dacsLetterSpacing.containsKey(key)) {
        style.letterSpacing = dacsLetterSpacing[key];
        return true;
      }
      return false;
    }

    return false;
  }
}
