import '../dacs_style.dart';

abstract class DacsParser {
  bool parse(String token, DacsStyle style);
}
