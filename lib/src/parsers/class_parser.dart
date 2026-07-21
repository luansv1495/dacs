import '../dacs_style.dart';
import 'parser.dart';
import 'typography_parser.dart';
import 'color_parser.dart';
import 'spacing_parser.dart';
import 'border_parser.dart';
import 'layout_parser.dart';

class ClassParser {
  final List<DacsParser> _parsers;

  ClassParser()
    : _parsers = [
        TypographyParser(),
        ColorParser(),
        SpacingParser(),
        BorderParser(),
        LayoutParser(),
      ];

  DacsStyle parse(String input) {
    final style = DacsStyle();
    final tokens = input.split(' ');
    for (final token in tokens) {
      final trimmed = token.trim();
      if (trimmed.isEmpty) continue;
      for (final parser in _parsers) {
        if (parser.parse(trimmed, style)) break;
      }
    }
    return style;
  }
}
