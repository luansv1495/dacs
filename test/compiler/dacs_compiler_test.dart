import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Cache', () {
    test('identical objects for same string', () {
      final a = 'text-lg font-bold'.dBase;
      final b = 'text-lg font-bold'.dBase;
      expect(identical(a, b), isTrue);
    });

    test('different strings produce different objects', () {
      final a = 'text-lg font-bold'.dBase;
      final b = 'text-xl font-medium'.dBase;
      expect(identical(a, b), isFalse);
    });
  });

  group('DacsCompiler', () {
    test('compile parses without BuildContext', () {
      final sheet = DacsCompiler.compile('text-lg dark:md:hover:bg-red-500');

      expect(sheet.base.fontSize, 18);
      expect(sheet.rules.single.condition.name, 'dark:md:hover');
    });
  });

  group('cache', () {
    test('same string returns same cached object', () {
      final a = 'text-lg font-bold'.dBase;
      final b = 'text-lg font-bold'.dBase;
      expect(identical(a, b), isTrue);
    });

    test('different strings produce different objects', () {
      final a = 'text-lg'.dBase;
      final b = 'font-bold'.dBase;
      expect(identical(a, b), isFalse);
    });
  });
}
