import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Input utility parsing', () {
    test('parses text slots with spaces inside brackets', () {
      final style =
          'label-[Email address] helper-[Use your work email] suffix-[per month]'
              .dBase;

      expect(style.inputLabelText, 'Email address');
      expect(style.inputHelperText, 'Use your work email');
      expect(style.inputSuffixText, 'per month');
    });

    test('parses escaped bracket and colon characters in input text', () {
      final style = r'label-[Amount \[USD\]] helper-[Format\: 10.00]'.dBase;

      expect(style.inputLabelText, 'Amount [USD]');
      expect(style.inputHelperText, 'Format: 10.00');
    });

    test('parses filled and dense flags including explicit false values', () {
      final style = 'filled dense not-filled not-dense'.dBase;

      expect(style.inputFilled, isFalse);
      expect(style.inputDense, isFalse);
    });

    test('input fields clone and merge correctly', () {
      final base = DacsStyle()
        ..inputLabelText = 'Name'
        ..inputFilled = true;
      final override = DacsStyle()
        ..inputHintText = 'Full name'
        ..inputDense = true;

      final merged = base.copyWith(override);

      expect(merged.inputLabelText, 'Name');
      expect(merged.inputHintText, 'Full name');
      expect(merged.inputFilled, isTrue);
      expect(merged.inputDense, isTrue);
    });
  });
}
