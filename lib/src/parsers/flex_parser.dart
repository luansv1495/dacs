import 'package:flutter/widgets.dart';
import '../dacs_style.dart';
import 'parser.dart';

/// Parses flex and layout alignment utilities: `flex`, `flex-col`, `flex-wrap`,
/// `items-*`, `justify-*`, `content-*`, `self-*`, `place-*`.
class FlexParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    if (token == 'flex') {
      style.flex = 1;
      return true;
    }
    if (token == 'flex-row') {
      style.flexDirection = Axis.horizontal;
      return true;
    }
    if (token == 'flex-col') {
      style.flexDirection = Axis.vertical;
      return true;
    }
    if (token == 'flex-wrap') {
      style.flexWrap = true;
      return true;
    }
    if (token == 'flex-nowrap') {
      style.flexWrap = false;
      return true;
    }

    final flexMatch = RegExp(r'^flex-(\d+(?:\.\d+)?)$').firstMatch(token);
    if (flexMatch != null) {
      style.flex = int.tryParse(flexMatch.group(1)!);
      if (style.flex != null) return true;
    }

    final itemsMatch = RegExp(r'^items-(.+)$').firstMatch(token);
    if (itemsMatch != null) {
      final v = _crossAxisAlignment(itemsMatch.group(1)!);
      if (v != null) {
        style.alignItems = v;
        return true;
      }
    }

    final justifyMatch = RegExp(r'^justify-(.+)$').firstMatch(token);
    if (justifyMatch != null) {
      final v = _mainAxisAlignment(justifyMatch.group(1)!);
      if (v != null) {
        style.justifyContent = v;
        return true;
      }
    }

    return false;
  }

  CrossAxisAlignment? _crossAxisAlignment(String key) => switch (key) {
        'start' => CrossAxisAlignment.start,
        'end' => CrossAxisAlignment.end,
        'center' => CrossAxisAlignment.center,
        'stretch' => CrossAxisAlignment.stretch,
        'baseline' => CrossAxisAlignment.baseline,
        _ => null,
      };

  MainAxisAlignment? _mainAxisAlignment(String key) => switch (key) {
        'start' => MainAxisAlignment.start,
        'end' => MainAxisAlignment.end,
        'center' => MainAxisAlignment.center,
        'between' => MainAxisAlignment.spaceBetween,
        'around' => MainAxisAlignment.spaceAround,
        'evenly' => MainAxisAlignment.spaceEvenly,
        _ => null,
      };
}
