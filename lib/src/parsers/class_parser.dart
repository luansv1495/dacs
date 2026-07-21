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

class ClassParser {
  final List<DacsParser> _parsers;
  static final _cache = <String, DacsStyle>{};

  ClassParser()
    : _parsers = [
        TypographyParser(),
        ColorParser(),
        SpacingParser(),
        BorderParser(),
        PositionParser(),
        TransformParser(),
        GradientParser(),
        LayoutParser(),
      ];

  DacsStyle parse(String input) {
    if (input.isEmpty) return DacsStyle();
    return _cache.putIfAbsent(input, () => _doParse(input));
  }

  DacsStyle _doParse(String input) {
    final base = DacsStyle();
    final tokens = input.split(' ');
    for (final token in tokens) {
      final trimmed = token.trim();
      if (trimmed.isEmpty) continue;

      String? variantPrefix;
      String classPart = trimmed;

      final colonIdx = trimmed.indexOf(':');
      if (colonIdx > 0) {
        final prefix = trimmed.substring(0, colonIdx);
        if (dacsVariantPrefixes.contains(prefix)) {
          variantPrefix = prefix;
          classPart = trimmed.substring(colonIdx + 1);
        }
      }

      if (variantPrefix == null) {
        for (final parser in _parsers) {
          if (parser.parse(classPart, base)) break;
        }
      } else {
        base.variants ??= {};
        final variantStyle = base.variants!.putIfAbsent(
          variantPrefix,
          () => DacsStyle(),
        );
        for (final parser in _parsers) {
          if (parser.parse(classPart, variantStyle)) break;
        }
      }
    }
    return base;
  }

  static void clearCache() => _cache.clear();
}
