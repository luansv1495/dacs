import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Color parser', () {
    test('parses text color', () {
      final style = 'text-sky-500'.dBase;
      expect(style.color, const Color(0xFF0EA5E9));
    });

    test('parses background color', () {
      final box = 'bg-blue-500'.dBox;
      expect(box.color, const Color(0xFF3B82F6));
    });

    test('parses text-black, text-white, text-transparent', () {
      expect('text-black'.dBase.color, const Color(0xFF000000));
      expect('text-white'.dBase.color, const Color(0xFFFFFFFF));
      expect('text-transparent'.dBase.color, const Color(0x00000000));
    });

    test('parses more color families', () {
      expect('text-slate-500'.dBase.color, const Color(0xFF64748B));
      expect('text-gray-500'.dBase.color, const Color(0xFF6B7280));
      expect('text-zinc-500'.dBase.color, const Color(0xFF71717A));
      expect('text-neutral-500'.dBase.color, const Color(0xFF737373));
      expect('text-stone-500'.dBase.color, const Color(0xFF78716C));
      expect('text-orange-500'.dBase.color, const Color(0xFFF97316));
      expect('text-amber-500'.dBase.color, const Color(0xFFF59E0B));
      expect('text-yellow-500'.dBase.color, const Color(0xFFEAB308));
      expect('text-lime-500'.dBase.color, const Color(0xFF84CC16));
      expect('text-emerald-500'.dBase.color, const Color(0xFF10B981));
      expect('text-teal-500'.dBase.color, const Color(0xFF14B8A6));
      expect('text-cyan-500'.dBase.color, const Color(0xFF06B6D4));
      expect('text-violet-500'.dBase.color, const Color(0xFF8B5CF6));
      expect('text-fuchsia-500'.dBase.color, const Color(0xFFD946EF));
      expect('text-rose-500'.dBase.color, const Color(0xFFF43F5E));
    });

    test('parses color with different shades', () {
      expect('text-blue-50'.dBase.color, const Color(0xFFEFF6FF));
      expect('text-blue-100'.dBase.color, const Color(0xFFDBEAFE));
      expect('text-blue-200'.dBase.color, const Color(0xFFBFDBFE));
      expect('text-blue-700'.dBase.color, const Color(0xFF1D4ED8));
      expect('text-blue-800'.dBase.color, const Color(0xFF1E40AF));
      expect('text-blue-900'.dBase.color, const Color(0xFF1E3A8A));
      expect('text-blue-950'.dBase.color, const Color(0xFF172554));
    });

    test('parses different color names', () {
      expect('text-red-500'.dBase.color, const Color(0xFFEF4444));
      expect('text-green-500'.dBase.color, const Color(0xFF22C55E));
      expect('text-indigo-500'.dBase.color, const Color(0xFF6366F1));
      expect('text-purple-500'.dBase.color, const Color(0xFFA855F7));
      expect('text-pink-500'.dBase.color, const Color(0xFFEC4899));
    });
  });

  group('Theme colors', () {
    test('text-primary sets theme key', () {
      final style = 'text-primary'.dBase;
      expect(style.color, isNull);
      expect(style.textThemeColor, 'primary');
    });

    test('bg-surface sets bg theme key', () {
      final style = 'bg-surface'.dBase;
      expect(style.backgroundColor, isNull);
      expect(style.bgThemeColor, 'surface');
    });

    test('all theme color prefixes work', () {
      final style = 'text-onPrimary bg-secondaryContainer border-error'.dBase;
      expect(style.textThemeColor, 'onPrimary');
      expect(style.bgThemeColor, 'secondaryContainer');
      expect(style.borderThemeColor, 'error');
    });

    test('theme color does not conflict with regular colors', () {
      final style = 'text-blue-500'.dBase;
      expect(style.textThemeColor, isNull);
      expect(style.color, const Color(0xFF3B82F6));
    });

    test('parses decoration theme color', () {
      final style = 'decoration-primary'.dBase;
      expect(style.decorationThemeColor, 'primary');
    });

    test('parses from-theme, via-theme, to-theme gradient colors', () {
      final style = 'from-primary via-secondary to-tertiary'.dBase;
      expect(style.gradientFromThemeColor, 'primary');
      expect(style.gradientViaThemeColor, 'secondary');
      expect(style.gradientToThemeColor, 'tertiary');
    });
  });
}
