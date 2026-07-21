// ignore_for_file: public_member_api_docs

import '../dacs_style.dart';
import '../dacs_condition.dart';
import '../dacs_conditional_rule.dart';
import '../dacs_style_sheet.dart';
import '../tokens/variants.dart';
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
import 'input_parser.dart';

/// Orchestrates parsing of utility class strings into [DacsStyleSheet] objects.
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
          InputParser(),
          ArbitraryParser(),
        ];

  final List<DacsParser> _parsers;

  /// Parses a space-separated string of utility classes into a
  /// [DacsStyleSheet].
  ///
  /// An empty string returns a [DacsStyleSheet] with an empty base and no
  /// rules.
  DacsStyleSheet parse(String input) {
    if (input.isEmpty) return DacsStyleSheet(DacsStyle(), []);
    final base = DacsStyle();
    final rules = <DacsConditionalRule>[];
    final unknownUtilities = <String>[];
    final tokens = _tokenize(input);
    var sourceOrder = 0;

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

      bool applyTo(DacsStyle target) {
        if (isImportant) target.isImportant = true;
        for (final parser in _parsers) {
          if (parser.parse(classPart, target)) return true;
        }
        return false;
      }

      if (variantPrefixes == null) {
        if (!applyTo(base)) unknownUtilities.add(clean);
      } else {
        final condition = DacsCondition.fromPrefixes(variantPrefixes);
        final ruleStyle = DacsStyle();
        if (!applyTo(ruleStyle)) {
          unknownUtilities.add(clean);
        } else {
          rules.add(
            DacsConditionalRule(
              condition: condition,
              style: ruleStyle,
              sourceOrder: sourceOrder++,
            ),
          );
        }
      }
      sourceOrder++;
    }

    return DacsStyleSheet(base, rules, unknownUtilities);
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
    final tokens = <String>[];
    final buffer = StringBuffer();
    var bracketDepth = 0;

    for (var i = 0; i < input.length; i++) {
      final char = input[i];
      if (char == '[') bracketDepth++;
      if (char == ']' && bracketDepth > 0) bracketDepth--;

      if (char == ' ' && bracketDepth == 0) {
        if (buffer.isNotEmpty) {
          tokens.add(buffer.toString());
          buffer.clear();
        }
      } else {
        buffer.write(char);
      }
    }

    if (buffer.isNotEmpty) tokens.add(buffer.toString());
    return tokens;
  }
}
