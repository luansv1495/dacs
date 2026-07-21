import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/style_sheet_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Variants', () {
    test('parses dark: variant prefix', () {
      final sheet = 'dark:text-white dark:bg-gray-900'.dStyle;
      final dark = ruleStyle(sheet, 'dark');

      expect(dark.color, const Color(0xFFFFFFFF));
      expect(dark.backgroundColor, const Color(0xFF111827));
    });

    test('parses light: variant prefix', () {
      final sheet = 'light:text-black light:bg-white'.dStyle;
      expect(ruleStyle(sheet, 'light').color, const Color(0xFF000000));
    });

    test('parses responsive variant prefixes', () {
      final sheet =
          'sm:text-sm md:text-base lg:text-lg xl:text-xl 2xl:text-2xl'.dStyle;
      expect(ruleStyle(sheet, 'sm').fontSize, 14);
      expect(ruleStyle(sheet, 'md').fontSize, 16);
      expect(ruleStyle(sheet, 'lg').fontSize, 18);
      expect(ruleStyle(sheet, 'xl').fontSize, 20);
      expect(ruleStyle(sheet, '2xl').fontSize, 24);
    });

    test('parses hover variant prefix', () {
      final sheet = 'bg-blue-500 hover:bg-blue-700'.dStyle;
      expect(sheet.base.backgroundColor, const Color(0xFF3B82F6));
      expect(
        ruleStyle(sheet, 'hover').backgroundColor,
        const Color(0xFF1D4ED8),
      );
    });

    test('parses focus and active variant prefixes', () {
      final sheet = 'bg-blue-500 focus:border-2 active:bg-blue-800'.dStyle;
      expect(ruleStyle(sheet, 'focus').borderWidth, 8);
      expect(
        ruleStyle(sheet, 'active').backgroundColor,
        const Color(0xFF1E40AF),
      );
    });

    test('mixes variant prefixes with base classes', () {
      final sheet =
          'text-base font-medium dark:text-white dark:font-bold'.dStyle;
      final dark = ruleStyle(sheet, 'dark');

      expect(sheet.base.fontSize, 16);
      expect(sheet.base.fontWeight, FontWeight.w500);
      expect(dark.color, const Color(0xFFFFFFFF));
      expect(dark.fontWeight, FontWeight.w700);
    });

    test('resolve applies no variant when none set', () {
      final style = 'text-lg font-bold'.dStyle.resolve();
      expect(style.fontSize, 18);
      expect(style.fontWeight, FontWeight.w700);
    });

    test('resolve applies dark mode variant', () {
      final style = 'text-lg dark:text-white'.dStyle.resolve(
            brightness: Brightness.dark,
          );
      expect(style.fontSize, 18);
      expect(style.color, const Color(0xFFFFFFFF));
    });

    test('resolve applies light mode variant', () {
      final style = 'text-lg dark:text-white light:text-black'.dStyle.resolve(
            brightness: Brightness.light,
          );
      expect(style.fontSize, 18);
      expect(style.color, const Color(0xFF000000));
    });

    test('resolve does not apply dark variant in light mode', () {
      final style = 'text-lg dark:text-white'.dStyle.resolve(
            brightness: Brightness.light,
          );
      expect(style.color, isNull);
    });

    test('resolve applies breakpoint variants', () {
      final style = 'text-sm md:text-lg'.dStyle.resolve(screenWidth: 800);
      expect(style.fontSize, 18);
    });

    test('resolve ignores breakpoint below threshold', () {
      final style = 'text-sm md:text-lg'.dStyle.resolve(screenWidth: 700);
      expect(style.fontSize, 14);
    });

    test('resolve applies overlapping breakpoints (latest wins)', () {
      final style = 'sm:text-sm md:text-base lg:text-lg'.dStyle.resolve(
            screenWidth: 1200,
          );
      expect(style.fontSize, 18);
    });

    test('resolve merges dark variant over breakpoint', () {
      final style = 'text-sm md:text-lg dark:text-xl'.dStyle.resolve(
            brightness: Brightness.dark,
            screenWidth: 900,
          );
      expect(style.fontSize, 20);
    });

    test('resolve preserves base when only breakpoint applies', () {
      final style = 'text-sm lg:text-lg'.dStyle.resolve(screenWidth: 700);
      expect(style.fontSize, 14);
    });

    test('resolve handles empty variants', () {
      final style = ''.dStyle.resolve(brightness: Brightness.dark);
      expect(style.fontSize, isNull);
    });

    test('padding and margin work with variants', () {
      final sheet = 'px-4 dark:px-8 mt-2 dark:mt-4'.dStyle;
      final dark = ruleStyle(sheet, 'dark');

      expect(sheet.base.padding?.left, 16);
      expect(dark.padding?.left, 32);
      expect(sheet.base.margin?.top, 8);
      expect(dark.margin?.top, 16);
    });

    test('dGradient with variants', () {
      final sheet =
          'bg-gradient-to-r from-blue-500 to-blue-700 dark:from-gray-900 dark:to-gray-700'
              .dStyle;
      expect(sheet.base.gradientFromColor, const Color(0xFF3B82F6));
      expect(
        ruleStyle(sheet, 'dark').gradientFromColor,
        const Color(0xFF111827),
      );
    });

    test('clone and mergeFrom produce correct result', () {
      final a = DacsStyle()..fontSize = 16;
      final b = DacsStyle()..fontWeight = FontWeight.w700;
      a.mergeFrom(b);
      expect(a.fontSize, 16);
      expect(a.fontWeight, FontWeight.w700);
    });

    test('clone does not share references', () {
      final a = DacsStyle()..fontSize = 16;
      final b = a.clone();
      a.fontSize = 20;
      expect(b.fontSize, 16);
    });

    test('parses pressed variant prefix', () {
      final sheet = 'bg-blue-500 pressed:bg-blue-800'.dStyle;
      expect(
        ruleStyle(sheet, 'pressed').backgroundColor,
        const Color(0xFF1E40AF),
      );
    });

    test('parses disabled variant prefix', () {
      final sheet = 'opacity-100 disabled:opacity-50'.dStyle;
      expect(ruleStyle(sheet, 'disabled').opacity, 0.5);
    });

    test('parses selected variant prefix', () {
      final sheet = 'bg-blue-500 selected:bg-blue-700'.dStyle;
      expect(
        ruleStyle(sheet, 'selected').backgroundColor,
        const Color(0xFF1D4ED8),
      );
    });

    test('parses error variant prefix', () {
      final sheet = 'border-gray-300 error:border-red-500'.dStyle;
      expect(ruleStyle(sheet, 'error').borderColor, const Color(0xFFEF4444));
    });

    test('parses dragged variant prefix', () {
      final sheet = 'opacity-100 dragged:opacity-75'.dStyle;
      expect(ruleStyle(sheet, 'dragged').opacity, 0.75);
    });

    test('parses scrolledUnder variant prefix', () {
      final sheet = 'shadow-sm scrolledUnder:shadow-lg'.dStyle;
      expect(ruleStyle(sheet, 'scrolledUnder').boxShadow?.length, 2);
    });

    test('parses variants with arbitrary values', () {
      final sheet = 'text-[#ff0000] dark:text-[#00ff00]'.dStyle;
      expect(sheet.base.color, const Color(0xFFFF0000));
      expect(ruleStyle(sheet, 'dark').color, const Color(0xFF00FF00));
    });

    test('parses variants with leading classes', () {
      final sheet = 'leading-normal dark:leading-loose'.dStyle;
      expect(ruleStyle(sheet, 'dark').lineHeight, 2.0);
    });

    test('parses chained variant prefix dark:hover:', () {
      final sheet = 'bg-blue-500 dark:hover:bg-blue-700'.dStyle;
      expect(
        ruleStyle(sheet, 'dark:hover').backgroundColor,
        const Color(0xFF1D4ED8),
      );
    });

    test('parses chained variant md:focus:', () {
      final sheet = 'border-0 md:focus:border-2'.dStyle;
      expect(ruleStyle(sheet, 'md:focus').borderWidth, 8);
    });

    test('parses chained variant dark:md:hover:', () {
      final sheet = 'text-sm dark:md:hover:text-lg'.dStyle;
      expect(ruleStyle(sheet, 'dark:md:hover').fontSize, 18);
    });

    test('resolve applies chained dark:md variant', () {
      final style = 'text-sm dark:md:text-lg'.dStyle.resolve(
            brightness: Brightness.dark,
            screenWidth: 800,
          );
      expect(style.fontSize, 18);
    });

    test('resolve does not apply chained dark:md in wrong brightness', () {
      final style = 'text-sm dark:md:text-lg'.dStyle.resolve(
            brightness: Brightness.light,
            screenWidth: 800,
          );
      expect(style.fontSize, 14);
    });

    test('resolve does not apply chained dark:md at small screen', () {
      final style = 'text-sm dark:md:text-lg'.dStyle.resolve(
            brightness: Brightness.dark,
            screenWidth: 700,
          );
      expect(style.fontSize, 14);
    });

    test('resolve re-maps chained variant with WidgetState condition', () {
      final result = 'bg-blue-500 dark:hover:bg-blue-700'.dStyle.resolve(
            brightness: Brightness.dark,
          );
      expect(result.backgroundColor, const Color(0xFF3B82F6));
      expect(result.variants, isNotNull);
      expect(result.variants!['hover'], isNotNull);
      expect(
        result.variants!['hover']!.backgroundColor,
        const Color(0xFF1D4ED8),
      );
    });

    test('resolve does not merge WidgetState compound variant into base', () {
      final result = 'bg-blue-500 dark:hover:bg-blue-700'.dStyle.resolve(
            brightness: Brightness.dark,
          );
      expect(result.backgroundColor, const Color(0xFF3B82F6));
    });
  });
}
