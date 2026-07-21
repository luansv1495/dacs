import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;
import 'package:dacs/dacs.dart';

void main() {
  group('DacsStyle parsing', () {
    test('parses text size', () {
      final style = 'text-2xl'.dStyle;
      expect(style.fontSize, 24);
    });

    test('parses font weight', () {
      final style = 'font-medium'.dStyle;
      expect(style.fontWeight, FontWeight.w500);
    });

    test('parses text color', () {
      final style = 'text-sky-500'.dStyle;
      expect(style.color, const Color(0xFF0EA5E9));
    });

    test('parses multiple classes', () {
      final textStyle = 'text-2xl font-medium text-sky-500'.dText;
      expect(textStyle.fontSize, 24);
      expect(textStyle.fontWeight, FontWeight.w500);
      expect(textStyle.color, const Color(0xFF0EA5E9));
    });

    test('parses background color', () {
      final box = 'bg-blue-500'.dBox;
      expect(box.color, const Color(0xFF3B82F6));
    });

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

    test('parses margin via dPads', () {
      final pad = 'mt-4'.dPads;
      expect(pad.top, 16);
    });

    test('parses border radius', () {
      final box = 'rounded-lg'.dBox;
      expect(box.borderRadius, isA<BorderRadius>());
      final br = box.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
    });

    test('parses rounded-full', () {
      final box = 'rounded-full'.dBox;
      final br = box.borderRadius as BorderRadius;
      expect(br.topLeft.x, 9999);
    });

    test('parses border width', () {
      final style = 'border-2'.dStyle;
      expect(style.borderWidth, 8);
    });

    test('parses width and height', () {
      final style = 'w-64 h-32'.dStyle;
      expect(style.width, 256);
      expect(style.height, 128);
    });

    test('parses opacity', () {
      final style = 'opacity-50'.dStyle;
      expect(style.opacity, 0.5);
    });

    test('parses italic', () {
      final style = 'italic'.dStyle;
      expect(style.fontStyle, FontStyle.italic);
    });

    test('parses underline', () {
      final style = 'underline'.dStyle;
      expect(style.textDecoration, TextDecoration.underline);
    });

    test('parses letter spacing', () {
      final style = 'tracking-wide'.dStyle;
      expect(style.letterSpacing, 0.025);
    });

    test('parses background with rounded and border color', () {
      final box = 'bg-red-500 rounded-lg border-2 border-blue-500'.dBox;
      expect(box.color, const Color(0xFFEF4444));
      expect(box.border, isNotNull);
    });

    test('handles empty string', () {
      final style = ''.dStyle;
      expect(style.fontSize, isNull);
      expect(style.color, isNull);
    });

    test('handles unknown classes gracefully', () {
      final style = 'text-unknown font-unknown'.dStyle;
      expect(style.fontSize, isNull);
      expect(style.fontWeight, isNull);
    });
  });

  group('Shadows', () {
    test('parses shadow-sm', () {
      final shadows = 'shadow-sm'.dShadow;
      expect(shadows.length, 1);
    });

    test('parses shadow', () {
      final shadows = 'shadow'.dShadow;
      expect(shadows.length, 2);
    });

    test('parses shadow-lg', () {
      final shadows = 'shadow-lg'.dShadow;
      expect(shadows.length, 2);
    });

    test('parses shadow-none gives empty list', () {
      final shadows = 'shadow-none'.dShadow;
      expect(shadows, isEmpty);
    });

    test('shadow in dBox', () {
      final box = 'shadow-lg'.dBox;
      expect(box.boxShadow, isNotNull);
      expect(box.boxShadow!.length, 2);
    });
  });

  group('Decoration styles', () {
    test('parses decoration-solid', () {
      final style = 'decoration-solid'.dStyle;
      expect(style.textDecorationStyle, TextDecorationStyle.solid);
    });

    test('parses decoration-wavy', () {
      final style = 'decoration-wavy'.dStyle;
      expect(style.textDecorationStyle, TextDecorationStyle.wavy);
    });

    test('parses decoration thickness', () {
      final style = 'decoration-2'.dStyle;
      expect(style.textDecorationThickness, 2);
    });

    test('parses decoration color', () {
      final style = 'decoration-red-500'.dStyle;
      expect(style.textDecorationColor, const Color(0xFFEF4444));
    });
  });

  group('dSize', () {
    test('parses width and height', () {
      final (w, h) = 'w-64 h-32'.dSize;
      expect(w, 256);
      expect(h, 128);
    });

    test('parses only width', () {
      final (w, h) = 'w-10'.dSize;
      expect(w, 40);
      expect(h, isNull);
    });

    test('parses full width', () {
      final (w, h) = 'w-full'.dSize;
      expect(w, double.infinity);
      expect(h, isNull);
    });
  });

  group('Position', () {
    test('parses inset-0', () {
      final (t, r, b, l) = 'inset-0'.dPosition;
      expect(t, 0);
      expect(r, 0);
      expect(b, 0);
      expect(l, 0);
    });

    test('parses inset-4', () {
      final (t, r, b, l) = 'inset-4'.dPosition;
      expect(t, 16);
      expect(r, 16);
      expect(b, 16);
      expect(l, 16);
    });

    test('parses inset-x-4 inset-y-2', () {
      final (t, r, b, l) = 'inset-x-4 inset-y-2'.dPosition;
      expect(t, 8);
      expect(r, 16);
      expect(b, 8);
      expect(l, 16);
    });

    test('parses top-4 left-2', () {
      final (t, r, b, l) = 'top-4 left-2'.dPosition;
      expect(t, 16);
      expect(l, 8);
      expect(r, isNull);
      expect(b, isNull);
    });

    test('parses bottom-0 right-0', () {
      final (t, r, b, l) = 'bottom-0 right-0'.dPosition;
      expect(b, 0);
      expect(r, 0);
      expect(t, isNull);
      expect(l, isNull);
    });

    test('position via dStyle', () {
      final style = 'inset-0 top-4'.dStyle;
      expect(style.insetTop, 16);
      expect(style.insetRight, 0);
      expect(style.insetBottom, 0);
      expect(style.insetLeft, 0);
    });
  });

  group('Transform', () {
    test('parses scale-125', () {
      final style = 'scale-125'.dStyle;
      expect(style.scaleX, 1.25);
      expect(style.scaleY, 1.25);
    });

    test('parses scale-x-150', () {
      final style = 'scale-x-150'.dStyle;
      expect(style.scaleX, 1.5);
      expect(style.scaleY, isNull);
    });

    test('parses rotate-45', () {
      final style = 'rotate-45'.dStyle;
      expect(style.rotateDegrees, 45);
    });

    test('parses translate-x-4', () {
      final style = 'translate-x-4'.dStyle;
      expect(style.translateX, 16);
    });

    test('parses translate-y-2', () {
      final style = 'translate-y-2'.dStyle;
      expect(style.translateY, 8);
    });

    test('parses skew-x-12', () {
      final style = 'skew-x-12'.dStyle;
      expect(style.skewX, 12);
    });

    test('toMatrix4 returns identity when no transforms', () {
      final matrix = ''.dTransform;
      expect(matrix, vmath.Matrix4.identity());
    });

    test('toMatrix4 applies scale', () {
      final matrix = 'scale-150'.dTransform;
      final expected = vmath.Matrix4.diagonal3Values(1.5, 1.5, 1);
      expect(matrix, expected);
    });

    test('combines scale and rotate', () {
      final style = 'scale-125 rotate-90'.dStyle;
      expect(style.scaleX, 1.25);
      expect(style.rotateDegrees, 90);
    });
  });

  group('Gradient', () {
    test('parses gradient direction', () {
      final style = 'bg-gradient-to-r'.dStyle;
      expect(style.gradientDirection, DacsGradientDirection.toR);
    });

    test('parses from-* and to-* colors', () {
      final style = 'from-red-500 to-indigo-600'.dStyle;
      expect(style.gradientFromColor, const Color(0xFFEF4444));
      expect(style.gradientToColor, const Color(0xFF4F46E5));
    });

    test('parses via color', () {
      final style = 'from-red-500 via-orange-500 to-yellow-500'.dStyle;
      expect(style.gradientViaColor, const Color(0xFFF97316));
    });

    test('dGradient returns null without to color', () {
      expect('bg-gradient-to-r from-blue-500'.dGradient, isNull);
    });

    test('dGradient builds LinearGradient', () {
      final gradient = 'bg-gradient-to-r from-red-500 to-blue-600'.dGradient;
      expect(gradient, isA<LinearGradient>());
      final lg = gradient as LinearGradient;
      expect(lg.colors.length, 2);
      expect(lg.colors[0], const Color(0xFFEF4444));
      expect(lg.colors[1], const Color(0xFF2563EB));
    });

    test('dGradient with via has 3 colors', () {
      final gradient =
          'bg-gradient-to-r from-red-500 via-orange-500 to-yellow-500'
              .dGradient;
      expect(gradient, isA<LinearGradient>());
      expect(gradient!.colors.length, 3);
    });

    test('dBox includes gradient', () {
      final box = 'bg-gradient-to-r from-blue-500 to-purple-600'.dBox;
      expect(box.gradient, isA<LinearGradient>());
    });

    test('all gradient directions', () {
      expect(
        'bg-gradient-to-r'.dStyle.gradientDirection,
        DacsGradientDirection.toR,
      );
      expect(
        'bg-gradient-to-l'.dStyle.gradientDirection,
        DacsGradientDirection.toL,
      );
      expect(
        'bg-gradient-to-t'.dStyle.gradientDirection,
        DacsGradientDirection.toT,
      );
      expect(
        'bg-gradient-to-b'.dStyle.gradientDirection,
        DacsGradientDirection.toB,
      );
      expect(
        'bg-gradient-to-tr'.dStyle.gradientDirection,
        DacsGradientDirection.toTR,
      );
      expect(
        'bg-gradient-to-tl'.dStyle.gradientDirection,
        DacsGradientDirection.toTL,
      );
      expect(
        'bg-gradient-to-br'.dStyle.gradientDirection,
        DacsGradientDirection.toBR,
      );
      expect(
        'bg-gradient-to-bl'.dStyle.gradientDirection,
        DacsGradientDirection.toBL,
      );
    });
  });

  group('Cache', () {
    test('identical objects for same string', () {
      final a = 'text-lg font-bold'.dStyle;
      final b = 'text-lg font-bold'.dStyle;
      expect(identical(a, b), isTrue);
    });

    test('different strings produce different objects', () {
      final a = 'text-lg font-bold'.dStyle;
      final b = 'text-xl font-medium'.dStyle;
      expect(identical(a, b), isFalse);
    });
  });

  group('Edge cases', () {
    test('parses text-xs', () {
      expect('text-xs'.dStyle.fontSize, 12);
    });

    test('parses text-9xl', () {
      expect('text-9xl'.dStyle.fontSize, 128);
    });

    test('parses all font weights', () {
      expect('font-thin'.dStyle.fontWeight, FontWeight.w100);
      expect('font-extralight'.dStyle.fontWeight, FontWeight.w200);
      expect('font-light'.dStyle.fontWeight, FontWeight.w300);
      expect('font-normal'.dStyle.fontWeight, FontWeight.w400);
      expect('font-medium'.dStyle.fontWeight, FontWeight.w500);
      expect('font-semibold'.dStyle.fontWeight, FontWeight.w600);
      expect('font-bold'.dStyle.fontWeight, FontWeight.w700);
      expect('font-extrabold'.dStyle.fontWeight, FontWeight.w800);
      expect('font-black'.dStyle.fontWeight, FontWeight.w900);
    });

    test('parses different color names', () {
      expect('text-red-500'.dStyle.color, const Color(0xFFEF4444));
      expect('text-green-500'.dStyle.color, const Color(0xFF22C55E));
      expect('text-indigo-500'.dStyle.color, const Color(0xFF6366F1));
      expect('text-purple-500'.dStyle.color, const Color(0xFFA855F7));
      expect('text-pink-500'.dStyle.color, const Color(0xFFEC4899));
    });

    test('parses opacity edge cases', () {
      expect('opacity-0'.dStyle.opacity, 0);
      expect('opacity-100'.dStyle.opacity, 1);
    });
  });

  group('Variants', () {
    test('parses dark: variant prefix', () {
      final style = 'dark:text-white dark:bg-gray-900'.dStyle;
      expect(style.variants, isNotNull);
      expect(style.variants!['dark'], isNotNull);
      expect(style.variants!['dark']!.color, const Color(0xFFFFFFFF));
      expect(style.variants!['dark']!.backgroundColor, const Color(0xFF111827));
    });

    test('parses light: variant prefix', () {
      final style = 'light:text-black light:bg-white'.dStyle;
      expect(style.variants!['light'], isNotNull);
      expect(style.variants!['light']!.color, const Color(0xFF000000));
    });

    test('parses responsive variant prefixes', () {
      final style =
          'sm:text-sm md:text-base lg:text-lg xl:text-xl 2xl:text-2xl'.dStyle;
      expect(style.variants!['sm']!.fontSize, 14);
      expect(style.variants!['md']!.fontSize, 16);
      expect(style.variants!['lg']!.fontSize, 18);
      expect(style.variants!['xl']!.fontSize, 20);
      expect(style.variants!['2xl']!.fontSize, 24);
    });

    test('mixes variant prefixes with base classes', () {
      final style =
          'text-base font-medium dark:text-white dark:font-bold'.dStyle;
      expect(style.fontSize, 16);
      expect(style.fontWeight, FontWeight.w500);
      expect(style.variants!['dark']!.color, const Color(0xFFFFFFFF));
      expect(style.variants!['dark']!.fontWeight, FontWeight.w700);
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

    test('px- py- and other compound tokens work with variants', () {
      final style = 'px-4 dark:px-8'.dStyle;
      expect(style.edgeInsets?.left, 16);
      expect(style.variants!['dark']!.edgeInsets?.left, 32);
    });

    test('dGradient with variants', () {
      final style =
          'bg-gradient-to-r from-blue-500 to-blue-700 dark:from-gray-900 dark:to-gray-700'
              .dStyle;
      expect(style.gradientFromColor, const Color(0xFF3B82F6));
      expect(
        style.variants!['dark']!.gradientFromColor,
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
  });
}
