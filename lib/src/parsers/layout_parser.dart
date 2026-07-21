import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import '../tokens/spacing.dart';
import '../tokens/shadows.dart';
import 'parser.dart';

/// Parses layout tokens: width (`w-*`), height (`h-*`), opacity (`opacity-*`),
/// overflow (`overflow-hidden`, `overflow-scroll`, …),
/// min/max width/height (`min-w-*`, `max-w-*`, `min-h-*`, `max-h-*`),
/// object fit (`object-cover`, `object-contain`, …),
/// and box shadows (`shadow-sm`…`shadow-2xl`, `shadow-inner`, `shadow-none`).
class LayoutParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    final overflowMatch = RegExp(r'^overflow-(.+)$').firstMatch(token);
    if (overflowMatch != null) {
      final v = _overflow(overflowMatch.group(1)!);
      if (v != null) {
        style.overflow = v;
        return true;
      }
      return false;
    }

    final widthMatch = RegExp(r'^w-(.+)$').firstMatch(token);
    if (widthMatch != null) {
      return _parseSize(widthMatch.group(1)!, (v) => style.width = v);
    }

    final heightMatch = RegExp(r'^h-(.+)$').firstMatch(token);
    if (heightMatch != null) {
      return _parseSize(heightMatch.group(1)!, (v) => style.height = v);
    }

    final minW = RegExp(r'^min-w-(.+)$').firstMatch(token);
    if (minW != null) {
      return _parseSize(minW.group(1)!, (v) => style.minWidth = v);
    }

    final maxW = RegExp(r'^max-w-(.+)$').firstMatch(token);
    if (maxW != null) {
      return _parseSize(maxW.group(1)!, (v) => style.maxWidth = v);
    }

    final minH = RegExp(r'^min-h-(.+)$').firstMatch(token);
    if (minH != null) {
      return _parseSize(minH.group(1)!, (v) => style.minHeight = v);
    }

    final maxH = RegExp(r'^max-h-(.+)$').firstMatch(token);
    if (maxH != null) {
      return _parseSize(maxH.group(1)!, (v) => style.maxHeight = v);
    }

    final objectMatch = RegExp(r'^object-(.+)$').firstMatch(token);
    if (objectMatch != null) {
      final v = _boxFit(objectMatch.group(1)!);
      if (v != null) {
        style.boxFit = v;
        return true;
      }
      return false;
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

  Clip? _overflow(String key) => switch (key) {
        'visible' => Clip.none,
        'hidden' => Clip.hardEdge,
        'clip' => Clip.antiAlias,
        'scroll' => Clip.hardEdge,
        _ => null,
      };

  BoxFit? _boxFit(String key) => switch (key) {
        'cover' => BoxFit.cover,
        'contain' => BoxFit.contain,
        'fill' => BoxFit.fill,
        'none' => BoxFit.none,
        'scale-down' => BoxFit.scaleDown,
        _ => null,
      };

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
