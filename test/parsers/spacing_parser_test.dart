import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Spacing parser', () {
    test('parses padding', () {
      final pad = 'p-4'.dPads;
      expect(pad.left, 16);
      expect(pad.top, 16);
      expect(pad.right, 16);
      expect(pad.bottom, 16);
    });

    test('parses directional padding', () {
      final pad = 'px-4 py-2'.dPads;
      expect(pad.left, 16);
      expect(pad.right, 16);
      expect(pad.top, 8);
      expect(pad.bottom, 8);
    });

    test('parses margin via dMargin', () {
      final margin = 'mt-4'.dMargin;
      expect(margin.top, 16);
    });

    test('parses margin separately from padding', () {
      final style = 'p-2 m-4'.dBase;
      expect(style.padding?.left, 8);
      expect(style.margin?.left, 16);
    });
  });
}
