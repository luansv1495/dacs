import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  group('DacsStyle parsing', () {
    test('parses text size', () {
      final style = 'text-2xl'.dacsStyle;
      expect(style.fontSize, 24);
    });

    test('parses font weight', () {
      final style = 'font-medium'.dacsStyle;
      expect(style.fontWeight, FontWeight.w500);
    });

    test('parses text color', () {
      final style = 'text-sky-500'.dacsStyle;
      expect(style.color, const Color(0xFF0EA5E9));
    });

    test('parses multiple classes', () {
      final textStyle = 'text-2xl font-medium text-sky-500'.dacsText;
      expect(textStyle.fontSize, 24);
      expect(textStyle.fontWeight, FontWeight.w500);
      expect(textStyle.color, const Color(0xFF0EA5E9));
    });

    test('parses background color', () {
      final box = 'bg-blue-500'.dacsBox;
      expect(box.color, const Color(0xFF3B82F6));
    });

    test('parses padding', () {
      final pad = 'p-4'.dacsPad;
      expect(pad.left, 16);
      expect(pad.top, 16);
      expect(pad.right, 16);
      expect(pad.bottom, 16);
    });

    test('parses directional padding', () {
      final pad = 'px-4 py-2'.dacsPad;
      expect(pad.left, 16);
      expect(pad.right, 16);
      expect(pad.top, 8);
      expect(pad.bottom, 8);
    });

    test('parses margin', () {
      final margin = 'mt-4'.dacsMargin;
      expect(margin.top, 16);
    });

    test('parses border radius', () {
      final box = 'rounded-lg'.dacsBox;
      expect(box.borderRadius, isA<BorderRadius>());
      final br = box.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
    });

    test('parses rounded-full', () {
      final box = 'rounded-full'.dacsBox;
      final br = box.borderRadius as BorderRadius;
      expect(br.topLeft.x, 9999);
    });

    test('parses border width', () {
      final style = 'border-2'.dacsStyle;
      expect(style.borderWidth, 8);
    });

    test('parses width and height', () {
      final style = 'w-64 h-32'.dacsStyle;
      expect(style.width, 256);
      expect(style.height, 128);
    });

    test('parses opacity', () {
      final style = 'opacity-50'.dacsStyle;
      expect(style.opacity, 0.5);
    });

    test('parses italic', () {
      final style = 'italic'.dacsStyle;
      expect(style.fontStyle, FontStyle.italic);
    });

    test('parses underline', () {
      final style = 'underline'.dacsStyle;
      expect(style.textDecoration, TextDecoration.underline);
    });

    test('parses letter spacing', () {
      final style = 'tracking-wide'.dacsStyle;
      expect(style.letterSpacing, 0.025);
    });

    test('parses background with rounded and border color', () {
      final box = 'bg-red-500 rounded-lg border-2 border-blue-500'.dacsBox;
      expect(box.color, const Color(0xFFEF4444));
      expect(box.border, isNotNull);
    });

    test('handles empty string', () {
      final style = ''.dacsStyle;
      expect(style.fontSize, isNull);
      expect(style.color, isNull);
    });

    test('handles unknown classes gracefully', () {
      final style = 'text-unknown font-unknown'.dacsStyle;
      expect(style.fontSize, isNull);
      expect(style.fontWeight, isNull);
    });
  });

  group('Edge cases', () {
    test('parses text-xs', () {
      expect('text-xs'.dacsStyle.fontSize, 12);
    });

    test('parses text-9xl', () {
      expect('text-9xl'.dacsStyle.fontSize, 128);
    });

    test('parses all font weights', () {
      expect('font-thin'.dacsStyle.fontWeight, FontWeight.w100);
      expect('font-extralight'.dacsStyle.fontWeight, FontWeight.w200);
      expect('font-light'.dacsStyle.fontWeight, FontWeight.w300);
      expect('font-normal'.dacsStyle.fontWeight, FontWeight.w400);
      expect('font-medium'.dacsStyle.fontWeight, FontWeight.w500);
      expect('font-semibold'.dacsStyle.fontWeight, FontWeight.w600);
      expect('font-bold'.dacsStyle.fontWeight, FontWeight.w700);
      expect('font-extrabold'.dacsStyle.fontWeight, FontWeight.w800);
      expect('font-black'.dacsStyle.fontWeight, FontWeight.w900);
    });

    test('parses different color names', () {
      expect('text-red-500'.dacsStyle.color, const Color(0xFFEF4444));
      expect('text-green-500'.dacsStyle.color, const Color(0xFF22C55E));
      expect('text-indigo-500'.dacsStyle.color, const Color(0xFF6366F1));
      expect('text-purple-500'.dacsStyle.color, const Color(0xFFA855F7));
      expect('text-pink-500'.dacsStyle.color, const Color(0xFFEC4899));
    });

    test('parses opacity edge cases', () {
      expect('opacity-0'.dacsStyle.opacity, 0);
      expect('opacity-100'.dacsStyle.opacity, 1);
    });
  });
}
