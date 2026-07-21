import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('DacsConfig', () {
    test('uses configured cache size', () {
      Dacs.configure(cacheSize: 1);

      final first = DacsCompiler.compile('text-sm');
      final second = DacsCompiler.compile('text-lg');
      final third = DacsCompiler.compile('text-sm');

      expect(identical(first, second), isFalse);
      expect(identical(first, third), isFalse);
      expect(third.base.fontSize, 14);
    });

    test('cache can be disabled', () {
      Dacs.configure(cacheSize: 0);

      final a = DacsCompiler.compile('text-sm');
      final b = DacsCompiler.compile('text-sm');

      expect(identical(a, b), isFalse);
    });

    test('reports unknown utilities through callback', () {
      final unknown = <String>[];
      Dacs.configure(onUnknownUtility: unknown.add);

      final sheet = DacsCompiler.compile('text-sm bg-missing-950');

      expect(sheet.base.fontSize, 14);
      expect(sheet.unknownUtilities, ['bg-missing-950']);
      expect(unknown, ['bg-missing-950']);
    });

    test('reports unknown utilities from cache hits', () {
      final first = <String>[];
      final second = <String>[];

      Dacs.configure(onUnknownUtility: first.add);
      DacsCompiler.compile('text-sm bg-missing-950');
      Dacs.configure(onUnknownUtility: second.add);
      DacsCompiler.compile('text-sm bg-missing-950');

      expect(first, ['bg-missing-950']);
      expect(second, ['bg-missing-950']);
    });

    test('strict mode throws on unknown utility', () {
      Dacs.configure(strictMode: true);

      expect(
        () => DacsCompiler.compile('text-sm bg-missing-950'),
        throwsA(isA<DacsUnknownUtilityException>()),
      );
    });

    test('unknown conditional utilities include their prefixes', () {
      final unknown = <String>[];
      Dacs.configure(onUnknownUtility: unknown.add);

      final sheet = DacsCompiler.compile('hover:bg-missing-950');

      expect(sheet.unknownUtilities, ['hover:bg-missing-950']);
      expect(unknown, ['hover:bg-missing-950']);
      expect(sheet.rules, isEmpty);
    });
  });
}
