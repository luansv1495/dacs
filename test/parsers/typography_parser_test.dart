import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Typography parser', () {
    test('parses text size', () {
      final style = 'text-2xl'.dBase;
      expect(style.fontSize, 24);
    });

    test('parses font weight', () {
      final style = 'font-medium'.dBase;
      expect(style.fontWeight, FontWeight.w500);
    });

    test('parses multiple classes', () {
      final textStyle = 'text-2xl font-medium text-sky-500'.dText;
      expect(textStyle.fontSize, 24);
      expect(textStyle.fontWeight, FontWeight.w500);
      expect(textStyle.color, const Color(0xFF0EA5E9));
    });

    test('parses italic', () {
      final style = 'italic'.dBase;
      expect(style.fontStyle, FontStyle.italic);
    });

    test('parses underline', () {
      final style = 'underline'.dBase;
      expect(style.textDecoration, TextDecoration.underline);
    });

    test('parses letter spacing', () {
      final style = 'tracking-wide'.dBase;
      expect(style.letterSpacing, 0.025);
    });

    test('handles empty string', () {
      final style = ''.dBase;
      expect(style.fontSize, isNull);
      expect(style.color, isNull);
    });

    test('handles unknown classes gracefully', () {
      final style = 'text-unknown font-unknown'.dBase;
      expect(style.fontSize, isNull);
      expect(style.fontWeight, isNull);
    });

    test('parses not-italic', () {
      final style = 'not-italic'.dBase;
      expect(style.fontStyle, FontStyle.normal);
    });

    test('parses line-through', () {
      final style = 'line-through'.dBase;
      expect(style.textDecoration, TextDecoration.lineThrough);
    });

    test('parses no-underline', () {
      final style = 'no-underline'.dBase;
      expect(style.textDecoration, TextDecoration.none);
    });

    test('parses decoration-double', () {
      expect(
        'decoration-double'.dBase.textDecorationStyle,
        TextDecorationStyle.double,
      );
    });

    test('parses decoration-dotted', () {
      expect(
        'decoration-dotted'.dBase.textDecorationStyle,
        TextDecorationStyle.dotted,
      );
    });

    test('parses decoration-dashed', () {
      expect(
        'decoration-dashed'.dBase.textDecorationStyle,
        TextDecorationStyle.dashed,
      );
    });

    test('parses text-3xl through text-8xl', () {
      expect('text-3xl'.dBase.fontSize, 30);
      expect('text-4xl'.dBase.fontSize, 36);
      expect('text-5xl'.dBase.fontSize, 48);
      expect('text-6xl'.dBase.fontSize, 60);
      expect('text-7xl'.dBase.fontSize, 72);
      expect('text-8xl'.dBase.fontSize, 96);
    });

    test('parses text-sm and text-base', () {
      expect('text-sm'.dBase.fontSize, 14);
      expect('text-base'.dBase.fontSize, 16);
    });

    test('parses absolute leading values', () {
      final style = 'text-base leading-6'.dBase;
      expect(style.lineHeight, 24 / 16);
    });

    test('parses relative leading values', () {
      expect('leading-none'.dBase.lineHeight, 1.0);
      expect('leading-tight'.dBase.lineHeight, 1.25);
      expect('leading-snug'.dBase.lineHeight, 1.375);
      expect('leading-normal'.dBase.lineHeight, 1.5);
      expect('leading-relaxed'.dBase.lineHeight, 1.625);
      expect('leading-loose'.dBase.lineHeight, 2.0);
    });

    test('parses all tracking values', () {
      expect('tracking-tighter'.dBase.letterSpacing, -0.05);
      expect('tracking-tight'.dBase.letterSpacing, -0.025);
      expect('tracking-normal'.dBase.letterSpacing, 0.0);
      expect('tracking-wide'.dBase.letterSpacing, 0.025);
      expect('tracking-wider'.dBase.letterSpacing, 0.05);
      expect('tracking-widest'.dBase.letterSpacing, 0.1);
    });

    test('parses text-xs', () {
      expect('text-xs'.dBase.fontSize, 12);
    });

    test('parses text-9xl', () {
      expect('text-9xl'.dBase.fontSize, 128);
    });

    test('parses all font weights', () {
      expect('font-thin'.dBase.fontWeight, FontWeight.w100);
      expect('font-extralight'.dBase.fontWeight, FontWeight.w200);
      expect('font-light'.dBase.fontWeight, FontWeight.w300);
      expect('font-normal'.dBase.fontWeight, FontWeight.w400);
      expect('font-medium'.dBase.fontWeight, FontWeight.w500);
      expect('font-semibold'.dBase.fontWeight, FontWeight.w600);
      expect('font-bold'.dBase.fontWeight, FontWeight.w700);
      expect('font-extrabold'.dBase.fontWeight, FontWeight.w800);
      expect('font-black'.dBase.fontWeight, FontWeight.w900);
    });
  });

  group('Decoration styles', () {
    test('parses decoration-solid', () {
      final style = 'decoration-solid'.dBase;
      expect(style.textDecorationStyle, TextDecorationStyle.solid);
    });

    test('parses decoration-wavy', () {
      final style = 'decoration-wavy'.dBase;
      expect(style.textDecorationStyle, TextDecorationStyle.wavy);
    });

    test('parses decoration thickness', () {
      final style = 'decoration-2'.dBase;
      expect(style.textDecorationThickness, 2);
    });

    test('parses decoration color', () {
      final style = 'decoration-red-500'.dBase;
      expect(style.textDecorationColor, const Color(0xFFEF4444));
    });
  });
}
