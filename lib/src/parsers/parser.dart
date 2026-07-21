// ignore_for_file: public_member_api_docs

import '../dacs_style.dart';

/// Parses a single utility class token into a [DacsStyle].
abstract class DacsParser {
  /// Applies the parsed values from [token] onto [style].
  bool parse(String token, DacsStyle style);
}
