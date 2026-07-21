import '../tokens/variants.dart';
import '../dacs_style.dart';
import 'parser.dart';
import 'typography_parser.dart';
import 'color_parser.dart';
import 'spacing_parser.dart';
import 'border_parser.dart';
import 'layout_parser.dart';
import 'position_parser.dart';
import 'transform_parser.dart';
import 'gradient_parser.dart';
import 'arbitrary_parser.dart';
import 'flex_parser.dart';
import 'aspect_parser.dart';
import 'alignment_parser.dart';

/// Orchestrates parsing of utility class strings into [DacsStyle] objects.
///
/// Maintains an internal LRU cache (up to 750 entries) keyed by input string
/// to avoid redundant parsing. Shared across the entire app via singleton
/// factory constructor.
class ClassParser {
  static final _instance = ClassParser._();
  factory ClassParser() => _instance;
  ClassParser._()
      : _parsers = [
          TypographyParser(),
          ColorParser(),
          SpacingParser(),
          BorderParser(),
          PositionParser(),
          TransformParser(),
          GradientParser(),
          LayoutParser(),
          FlexParser(),
          AspectParser(),
          AlignmentParser(),
          ArbitraryParser(),
        ];

  final List<DacsParser> _parsers;
  static final _cache = <String, DacsStyle>{};
  static const _maxCacheSize = 750;

  /// Parses a space-separated string of utility classes into a [DacsStyle].
  ///
  /// Returns a cached [DacsStyle] if [input] has been parsed before.
  /// An empty string returns a default [DacsStyle] with no values set.
  DacsStyle parse(String input) {
    if (input.isEmpty) return DacsStyle();
    final cached = _cache[input];
    if (cached != null) {
      _cache.remove(input);
      _cache[input] = cached;
      return cached;
    }
    final style = _doParse(input);
    if (_cache.length >= _maxCacheSize) {
      _cache.remove(_cache.keys.first);
    }
    _cache[input] = style;
    return style;
  }

  DacsStyle _doParse(String input) {
    final base = DacsStyle();
    final tokens = _tokenize(input);
    for (final token in tokens) {
      final trimmed = token.trim();
      if (trimmed.isEmpty) continue;

      bool isImportant = trimmed.endsWith('!');
      final clean =
          isImportant ? trimmed.substring(0, trimmed.length - 1) : trimmed;

      List<String>? variantPrefixes;
      String classPart = clean;

      final parts = clean.split(':');
      if (parts.length > 1) {
        final last = parts.last;
        final prefixes = parts.take(parts.length - 1).toList();
        if (prefixes.every((p) => dacsVariantPrefixes.contains(p))) {
          variantPrefixes = prefixes;
          classPart = last;
        } else if (parts.length == 2 &&
            dacsVariantPrefixes.contains(parts.first)) {
          variantPrefixes = [parts.first];
          classPart = parts.last;
        }
      }

      void applyTo(DacsStyle target) {
        if (isImportant) target.isImportant = true;
        for (final parser in _parsers) {
          if (parser.parse(classPart, target)) break;
        }
      }

      if (variantPrefixes == null) {
        applyTo(base);
      } else {
        final key = variantPrefixes.join(':');
        base.variants ??= {};
        final variantStyle = base.variants!.putIfAbsent(key, () => DacsStyle());
        applyTo(variantStyle);
      }
    }
    return base;
  }

  List<String> _tokenize(String input) {
    final md = RegExp(r'^d/responsive\((.+)\)$').firstMatch(input.trim());
    if (md != null) {
      final inner = md.group(1)!;
      return inner
          .split('_')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }
    return input.split(' ');
  }
}
