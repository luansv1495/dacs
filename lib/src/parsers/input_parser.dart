// ignore_for_file: public_member_api_docs

import '../dacs_style.dart';
import 'parser.dart';

class InputParser extends DacsParser {
  static final _textToken =
      RegExp(r'^(label|hint|helper|error|prefix|suffix)-\[(.*)\]$');

  @override
  bool parse(String token, DacsStyle style) {
    switch (token) {
      case 'filled':
        style.inputFilled = true;
        return true;
      case 'not-filled':
        style.inputFilled = false;
        return true;
      case 'dense':
        style.inputDense = true;
        return true;
      case 'not-dense':
        style.inputDense = false;
        return true;
    }

    final match = _textToken.firstMatch(token);
    if (match == null) return false;

    final value = _decodeText(match.group(2)!);
    switch (match.group(1)!) {
      case 'label':
        style.inputLabelText = value;
        return true;
      case 'hint':
        style.inputHintText = value;
        return true;
      case 'helper':
        style.inputHelperText = value;
        return true;
      case 'error':
        style.inputErrorText = value;
        return true;
      case 'prefix':
        style.inputPrefixText = value;
        return true;
      case 'suffix':
        style.inputSuffixText = value;
        return true;
    }
    return false;
  }

  String _decodeText(String raw) {
    return raw
        .replaceAll(r'\]', ']')
        .replaceAll(r'\[', '[')
        .replaceAll(r'\:', ':');
  }
}
