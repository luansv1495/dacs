import 'package:flutter/widgets.dart';

import 'dacs_config.dart';
import 'dacs_style_sheet.dart';
import 'parsers/class_parser.dart';

/// Compiles DACS class strings into context-free [DacsStyleSheet] objects.
///
/// Compilation parses the string and records conditional rules, but does not
/// read [BuildContext], theme, media query, brightness, width, or widget
/// states. Those runtime values are applied later by stylesheet resolution and
/// adapters.
class DacsCompiler {
  DacsCompiler._();

  static final _parser = ClassParser();
  static final _cache = <String, DacsStyleSheet>{};

  /// Compiles [classes] into a [DacsStyleSheet].
  ///
  /// Results are cached according to [Dacs.cacheSize]. Unknown utilities are
  /// reported via [Dacs.onUnknownUtility] and throw in [Dacs.strictMode].
  static DacsStyleSheet compile(String classes) {
    if (classes.isEmpty) return _parser.parse(classes);

    final cacheSize = Dacs.cacheSize;
    if (cacheSize > 0) {
      final cached = _cache[classes];
      if (cached != null) {
        _cache.remove(classes);
        _cache[classes] = cached;
        _reportUnknownUtilities(cached, classes);
        return cached;
      }
    }

    final result = _parser.parse(classes);

    _reportUnknownUtilities(result, classes);

    if (cacheSize > 0) {
      while (_cache.length >= cacheSize) {
        _cache.remove(_cache.keys.first);
      }
      _cache[classes] = result;
    }

    return result;
  }

  /// Clears all cached compiled stylesheets.
  static void clearCache() {
    _cache.clear();
  }

  static void _reportUnknownUtilities(DacsStyleSheet sheet, String classes) {
    for (final utility in sheet.unknownUtilities) {
      Dacs.onUnknownUtility?.call(utility);
      if (Dacs.strictMode) {
        throw DacsUnknownUtilityException(utility, classes);
      }
    }
  }
}
