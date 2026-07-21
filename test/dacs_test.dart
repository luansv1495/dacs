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

    test('parses margin via dMargin', () {
      final margin = 'mt-4'.dMargin;
      expect(margin.top, 16);
    });

    test('parses margin separately from padding', () {
      final style = 'p-2 m-4'.dStyle;
      expect(style.padding?.left, 8);
      expect(style.margin?.left, 16);
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

    test('parses not-italic', () {
      final style = 'not-italic'.dStyle;
      expect(style.fontStyle, FontStyle.normal);
    });

    test('parses line-through', () {
      final style = 'line-through'.dStyle;
      expect(style.textDecoration, TextDecoration.lineThrough);
    });

    test('parses no-underline', () {
      final style = 'no-underline'.dStyle;
      expect(style.textDecoration, TextDecoration.none);
    });

    test('parses decoration-double', () {
      expect(
        'decoration-double'.dStyle.textDecorationStyle,
        TextDecorationStyle.double,
      );
    });

    test('parses decoration-dotted', () {
      expect(
        'decoration-dotted'.dStyle.textDecorationStyle,
        TextDecorationStyle.dotted,
      );
    });

    test('parses decoration-dashed', () {
      expect(
        'decoration-dashed'.dStyle.textDecorationStyle,
        TextDecorationStyle.dashed,
      );
    });

    test('parses text-3xl through text-8xl', () {
      expect('text-3xl'.dStyle.fontSize, 30);
      expect('text-4xl'.dStyle.fontSize, 36);
      expect('text-5xl'.dStyle.fontSize, 48);
      expect('text-6xl'.dStyle.fontSize, 60);
      expect('text-7xl'.dStyle.fontSize, 72);
      expect('text-8xl'.dStyle.fontSize, 96);
    });

    test('parses text-sm and text-base', () {
      expect('text-sm'.dStyle.fontSize, 14);
      expect('text-base'.dStyle.fontSize, 16);
    });

    test('parses absolute leading values', () {
      final style = 'text-base leading-6'.dStyle;
      expect(style.lineHeight, 24 / 16);
    });

    test('parses relative leading values', () {
      expect('leading-none'.dStyle.lineHeight, 1.0);
      expect('leading-tight'.dStyle.lineHeight, 1.25);
      expect('leading-snug'.dStyle.lineHeight, 1.375);
      expect('leading-normal'.dStyle.lineHeight, 1.5);
      expect('leading-relaxed'.dStyle.lineHeight, 1.625);
      expect('leading-loose'.dStyle.lineHeight, 2.0);
    });

    test('parses all tracking values', () {
      expect('tracking-tighter'.dStyle.letterSpacing, -0.05);
      expect('tracking-tight'.dStyle.letterSpacing, -0.025);
      expect('tracking-normal'.dStyle.letterSpacing, 0.0);
      expect('tracking-wide'.dStyle.letterSpacing, 0.025);
      expect('tracking-wider'.dStyle.letterSpacing, 0.05);
      expect('tracking-widest'.dStyle.letterSpacing, 0.1);
    });

    test('parses text-black, text-white, text-transparent', () {
      expect('text-black'.dStyle.color, const Color(0xFF000000));
      expect('text-white'.dStyle.color, const Color(0xFFFFFFFF));
      expect('text-transparent'.dStyle.color, const Color(0x00000000));
    });

    test('parses more color families', () {
      expect('text-slate-500'.dStyle.color, const Color(0xFF64748B));
      expect('text-gray-500'.dStyle.color, const Color(0xFF6B7280));
      expect('text-zinc-500'.dStyle.color, const Color(0xFF71717A));
      expect('text-neutral-500'.dStyle.color, const Color(0xFF737373));
      expect('text-stone-500'.dStyle.color, const Color(0xFF78716C));
      expect('text-orange-500'.dStyle.color, const Color(0xFFF97316));
      expect('text-amber-500'.dStyle.color, const Color(0xFFF59E0B));
      expect('text-yellow-500'.dStyle.color, const Color(0xFFEAB308));
      expect('text-lime-500'.dStyle.color, const Color(0xFF84CC16));
      expect('text-emerald-500'.dStyle.color, const Color(0xFF10B981));
      expect('text-teal-500'.dStyle.color, const Color(0xFF14B8A6));
      expect('text-cyan-500'.dStyle.color, const Color(0xFF06B6D4));
      expect('text-violet-500'.dStyle.color, const Color(0xFF8B5CF6));
      expect('text-fuchsia-500'.dStyle.color, const Color(0xFFD946EF));
      expect('text-rose-500'.dStyle.color, const Color(0xFFF43F5E));
    });

    test('parses color with different shades', () {
      expect('text-blue-50'.dStyle.color, const Color(0xFFEFF6FF));
      expect('text-blue-100'.dStyle.color, const Color(0xFFDBEAFE));
      expect('text-blue-200'.dStyle.color, const Color(0xFFBFDBFE));
      expect('text-blue-700'.dStyle.color, const Color(0xFF1D4ED8));
      expect('text-blue-800'.dStyle.color, const Color(0xFF1E40AF));
      expect('text-blue-900'.dStyle.color, const Color(0xFF1E3A8A));
      expect('text-blue-950'.dStyle.color, const Color(0xFF172554));
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

    test('parses shadow-md', () {
      expect('shadow-md'.dShadow.length, 2);
    });

    test('parses shadow-xl', () {
      expect('shadow-xl'.dShadow.length, 2);
    });

    test('parses shadow-2xl', () {
      expect('shadow-2xl'.dShadow.length, 1);
    });

    test('parses shadow-inner', () {
      expect('shadow-inner'.dShadow.length, 1);
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

    test('parses inset-t-4', () {
      final (t, _, _, _) = 'inset-t-4'.dPosition;
      expect(t, 16);
    });

    test('parses inset-b-8', () {
      final (_, _, b, _) = 'inset-b-8'.dPosition;
      expect(b, 32);
    });

    test('parses inset-l-2', () {
      final (_, _, _, l) = 'inset-l-2'.dPosition;
      expect(l, 8);
    });

    test('parses inset-r-6', () {
      final (_, r, _, _) = 'inset-r-6'.dPosition;
      expect(r, 24);
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

    test('parses scale-y-150', () {
      final style = 'scale-y-150'.dStyle;
      expect(style.scaleY, 1.5);
      expect(style.scaleX, isNull);
    });

    test('parses all scale values', () {
      expect('scale-50'.dStyle.scaleX, 0.5);
      expect('scale-75'.dStyle.scaleX, 0.75);
      expect('scale-90'.dStyle.scaleX, 0.9);
      expect('scale-95'.dStyle.scaleX, 0.95);
      expect('scale-100'.dStyle.scaleX, 1.0);
      expect('scale-105'.dStyle.scaleX, 1.05);
      expect('scale-110'.dStyle.scaleX, 1.1);
      expect('scale-0'.dStyle.scaleX, 0);
    });

    test('parses negative rotate', () {
      expect('rotate--45'.dStyle.rotateDegrees, -45);
      expect('rotate--90'.dStyle.rotateDegrees, -90);
    });

    test('parses skew-y-12', () {
      final style = 'skew-y-12'.dStyle;
      expect(style.skewY, 12);
      expect(style.skewX, isNull);
    });

    test('parses translate-x-auto gracefully', () {
      final style = 'translate-x-auto'.dStyle;
      expect(style.translateX, isNull);
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

    test('dGradient returns null with only direction', () {
      expect('bg-gradient-to-r'.dGradient, isNull);
    });

    test('parses from-primary sets from theme color key', () {
      final style = 'bg-gradient-to-r from-primary to-secondary'.dStyle;
      expect(style.gradientFromThemeColor, 'primary');
      expect(style.gradientToThemeColor, 'secondary');
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

  group('Border', () {
    test('parses rounded (no suffix)', () {
      final br = 'rounded'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 4);
    });

    test('parses rounded-none', () {
      final br = 'rounded-none'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 0);
    });

    test('parses rounded-sm', () {
      final br = 'rounded-sm'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 2);
    });

    test('parses rounded-md', () {
      final br = 'rounded-md'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 6);
    });

    test('parses rounded-xl', () {
      final br = 'rounded-xl'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 12);
    });

    test('parses rounded-2xl', () {
      final br = 'rounded-2xl'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 16);
    });

    test('parses rounded-3xl', () {
      final br = 'rounded-3xl'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 24);
    });

    test('parses directional rounded-t', () {
      final br = 'rounded-t-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
      expect(br.topRight.x, 8);
      expect(br.bottomLeft.x, 0);
      expect(br.bottomRight.x, 0);
    });

    test('parses directional rounded-b', () {
      final br = 'rounded-b-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.bottomLeft.x, 8);
      expect(br.bottomRight.x, 8);
      expect(br.topLeft.x, 0);
    });

    test('parses directional rounded-l', () {
      final br = 'rounded-l-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
      expect(br.bottomLeft.x, 8);
      expect(br.topRight.x, 0);
    });

    test('parses directional rounded-r', () {
      final br = 'rounded-r-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.topRight.x, 8);
      expect(br.bottomRight.x, 8);
      expect(br.topLeft.x, 0);
    });

    test('parses rounded-tl', () {
      final br = 'rounded-tl-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
      expect(br.topRight.x, 0);
    });

    test('parses rounded-tr', () {
      final br = 'rounded-tr-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.topRight.x, 8);
      expect(br.topLeft.x, 0);
    });

    test('parses rounded-bl', () {
      final br = 'rounded-bl-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.bottomLeft.x, 8);
      expect(br.bottomRight.x, 0);
    });

    test('parses rounded-br', () {
      final br = 'rounded-br-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.bottomRight.x, 8);
      expect(br.bottomLeft.x, 0);
    });

    test('parses border (no width value)', () {
      expect('border'.dStyle.borderWidth, 1);
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
      expect('opacity-25'.dStyle.opacity, 0.25);
      expect('opacity-75'.dStyle.opacity, 0.75);
    });

    test('parses w-auto and h-auto', () {
      expect('w-auto'.dStyle.width, 0);
      expect('h-auto'.dStyle.height, 0);
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

    test('parses hover variant prefix', () {
      final style = 'bg-blue-500 hover:bg-blue-700'.dStyle;
      expect(style.backgroundColor, const Color(0xFF3B82F6));
      expect(
        style.variants!['hover']!.backgroundColor,
        const Color(0xFF1D4ED8),
      );
    });

    test('parses focus and active variant prefixes', () {
      final style = 'bg-blue-500 focus:border-2 active:bg-blue-800'.dStyle;
      expect(style.variants!['focus']!.borderWidth, 8);
      expect(
        style.variants!['active']!.backgroundColor,
        const Color(0xFF1E40AF),
      );
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

    test('padding and margin work with variants', () {
      final style = 'px-4 dark:px-8 mt-2 dark:mt-4'.dStyle;
      expect(style.padding?.left, 16);
      expect(style.variants!['dark']!.padding?.left, 32);
      expect(style.margin?.top, 8);
      expect(style.variants!['dark']!.margin?.top, 16);
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

    test('parses pressed variant prefix', () {
      final style = 'bg-blue-500 pressed:bg-blue-800'.dStyle;
      expect(
        style.variants!['pressed']!.backgroundColor,
        const Color(0xFF1E40AF),
      );
    });

    test('parses disabled variant prefix', () {
      final style = 'opacity-100 disabled:opacity-50'.dStyle;
      expect(style.variants!['disabled']!.opacity, 0.5);
    });

    test('parses selected variant prefix', () {
      final style = 'bg-blue-500 selected:bg-blue-700'.dStyle;
      expect(
        style.variants!['selected']!.backgroundColor,
        const Color(0xFF1D4ED8),
      );
    });

    test('parses error variant prefix', () {
      final style = 'border-gray-300 error:border-red-500'.dStyle;
      expect(style.variants!['error']!.borderColor, const Color(0xFFEF4444));
    });

    test('parses dragged variant prefix', () {
      final style = 'opacity-100 dragged:opacity-75'.dStyle;
      expect(style.variants!['dragged']!.opacity, 0.75);
    });

    test('parses scrolledUnder variant prefix', () {
      final style = 'shadow-sm scrolledUnder:shadow-lg'.dStyle;
      expect(style.variants!['scrolledUnder']!.boxShadow?.length, 2);
    });

    test('parses variants with arbitrary values', () {
      final style = 'text-[#ff0000] dark:text-[#00ff00]'.dStyle;
      expect(style.color, const Color(0xFFFF0000));
      expect(style.variants!['dark']!.color, const Color(0xFF00FF00));
    });

    test('parses variants with leading classes', () {
      final style = 'leading-normal dark:leading-loose'.dStyle;
      expect(style.variants!['dark']!.lineHeight, 2.0);
    });

    test('parses chained variant prefix dark:hover:', () {
      final style = 'bg-blue-500 dark:hover:bg-blue-700'.dStyle;
      expect(style.variants, isNotNull);
      expect(style.variants!['dark:hover'], isNotNull);
      expect(
        style.variants!['dark:hover']!.backgroundColor,
        const Color(0xFF1D4ED8),
      );
    });

    test('parses chained variant md:focus:', () {
      final style = 'border-0 md:focus:border-2'.dStyle;
      expect(style.variants!['md:focus']!.borderWidth, 8);
    });

    test('parses chained variant dark:md:hover:', () {
      final style = 'text-sm dark:md:hover:text-lg'.dStyle;
      expect(style.variants!['dark:md:hover']!.fontSize, 18);
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

  group('Theme colors', () {
    test('text-primary sets theme key', () {
      final style = 'text-primary'.dStyle;
      expect(style.color, isNull);
      expect(style.textThemeColor, 'primary');
    });

    test('bg-surface sets bg theme key', () {
      final style = 'bg-surface'.dStyle;
      expect(style.backgroundColor, isNull);
      expect(style.bgThemeColor, 'surface');
    });

    test('all theme color prefixes work', () {
      final style = 'text-onPrimary bg-secondaryContainer border-error'.dStyle;
      expect(style.textThemeColor, 'onPrimary');
      expect(style.bgThemeColor, 'secondaryContainer');
      expect(style.borderThemeColor, 'error');
    });

    test('theme color does not conflict with regular colors', () {
      final style = 'text-blue-500'.dStyle;
      expect(style.textThemeColor, isNull);
      expect(style.color, const Color(0xFF3B82F6));
    });

    test('parses decoration theme color', () {
      final style = 'decoration-primary'.dStyle;
      expect(style.decorationThemeColor, 'primary');
    });

    test('parses from-theme, via-theme, to-theme gradient colors', () {
      final style = 'from-primary via-secondary to-tertiary'.dStyle;
      expect(style.gradientFromThemeColor, 'primary');
      expect(style.gradientViaThemeColor, 'secondary');
      expect(style.gradientToThemeColor, 'tertiary');
    });
  });

  group('cache', () {
    test('same string returns same cached object', () {
      final a = 'text-lg font-bold'.dStyle;
      final b = 'text-lg font-bold'.dStyle;
      expect(identical(a, b), isTrue);
    });

    test('different strings produce different objects', () {
      final a = 'text-lg'.dStyle;
      final b = 'font-bold'.dStyle;
      expect(identical(a, b), isFalse);
    });
  });

  group('Gap', () {
    test('parses gap-4', () {
      final style = 'gap-4'.dStyle;
      expect(style.gap, 16);
    });

    test('parses gap-0', () {
      expect('gap-0'.dStyle.gap, 0);
    });

    test('parses gap-px', () {
      expect('gap-px'.dStyle.gap, 1);
    });

    test('parses gap-2', () {
      expect('gap-2'.dStyle.gap, 8);
    });
  });

  group('Flex helpers', () {
    test('parses flex', () {
      expect('flex'.dStyle.flex, 1);
    });

    test('parses flex-col', () {
      expect('flex-col'.dStyle.flexDirection, Axis.vertical);
    });

    test('parses flex-row', () {
      expect('flex-row'.dStyle.flexDirection, Axis.horizontal);
    });

    test('parses flex-wrap', () {
      expect('flex-wrap'.dStyle.flexWrap, isTrue);
    });

    test('parses flex-nowrap', () {
      expect('flex-nowrap'.dStyle.flexWrap, isFalse);
    });

    test('parses items-center', () {
      expect('items-center'.dStyle.alignItems, CrossAxisAlignment.center);
    });

    test('parses items-start', () {
      expect('items-start'.dStyle.alignItems, CrossAxisAlignment.start);
    });

    test('parses items-end', () {
      expect('items-end'.dStyle.alignItems, CrossAxisAlignment.end);
    });

    test('parses items-stretch', () {
      expect('items-stretch'.dStyle.alignItems, CrossAxisAlignment.stretch);
    });

    test('parses justify-center', () {
      expect('justify-center'.dStyle.justifyContent, MainAxisAlignment.center);
    });

    test('parses justify-between', () {
      expect(
        'justify-between'.dStyle.justifyContent,
        MainAxisAlignment.spaceBetween,
      );
    });

    test('parses justify-around', () {
      expect(
        'justify-around'.dStyle.justifyContent,
        MainAxisAlignment.spaceAround,
      );
    });

    test('parses justify-evenly', () {
      expect(
        'justify-evenly'.dStyle.justifyContent,
        MainAxisAlignment.spaceEvenly,
      );
    });

    test('parses justify-start', () {
      expect('justify-start'.dStyle.justifyContent, MainAxisAlignment.start);
    });

    test('parses justify-end', () {
      expect('justify-end'.dStyle.justifyContent, MainAxisAlignment.end);
    });
  });

  group('Overflow', () {
    test('parses overflow-hidden', () {
      expect('overflow-hidden'.dStyle.overflow, Clip.hardEdge);
    });

    test('parses overflow-scroll', () {
      expect('overflow-scroll'.dStyle.overflow, Clip.hardEdge);
    });

    test('parses overflow-visible', () {
      expect('overflow-visible'.dStyle.overflow, Clip.none);
    });

    test('parses overflow-clip', () {
      expect('overflow-clip'.dStyle.overflow, Clip.antiAlias);
    });
  });

  group('RTL border-radius', () {
    test('parses rounded-ts-lg (top-start)', () {
      final br = 'rounded-ts-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
      expect(br.topRight.x, 0);
    });

    test('parses rounded-te-lg (top-end)', () {
      final br = 'rounded-te-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.topRight.x, 8);
      expect(br.topLeft.x, 0);
    });

    test('parses rounded-bs-lg (bottom-start)', () {
      final br = 'rounded-bs-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.bottomLeft.x, 8);
      expect(br.bottomRight.x, 0);
    });

    test('parses rounded-be-lg (bottom-end)', () {
      final br = 'rounded-be-lg'.dStyle.borderRadius as BorderRadius;
      expect(br.bottomRight.x, 8);
      expect(br.bottomLeft.x, 0);
    });

    test('parses rounded-ss-lg (top-start logical)', () {
      final br = 'rounded-ss-lg'.dStyle.borderRadius;
      expect(br, isA<BorderRadiusDirectional>());
      final directional = br as BorderRadiusDirectional;
      expect(directional.topStart.x, 8);
    });

    test('parses rounded-se-lg (top-end logical)', () {
      final br = 'rounded-se-lg'.dStyle.borderRadius;
      expect(br, isA<BorderRadiusDirectional>());
      final directional = br as BorderRadiusDirectional;
      expect(directional.topEnd.x, 8);
    });
  });

  group('Important', () {
    test('sets isImportant with ! suffix', () {
      final style = 'text-red-500!'.dStyle;
      expect(style.isImportant, isTrue);
      expect(style.color, const Color(0xFFEF4444));
    });

    test('important prevents variant override', () {
      final style = 'text-red-500! dark:text-blue-300'.dStyle;
      final resolved = style.resolve(brightness: Brightness.dark);
      expect(resolved.color, const Color(0xFFEF4444));
    });

    test('important does not affect non-important', () {
      final style = 'text-lg'.dStyle;
      expect(style.isImportant, isFalse);
    });

    test('variant with important', () {
      final style = 'text-lg dark:text-white!'.dStyle;
      final resolved = style.resolve(brightness: Brightness.dark);
      expect(resolved.color, const Color(0xFFFFFFFF));
    });
  });

  group('DacsStyle.apply', () {
    test('apply parses classes into DacsStyle', () {
      final style = DacsStyle.apply('text-lg font-bold p-4');
      expect(style.fontSize, 18);
      expect(style.fontWeight, FontWeight.w700);
      expect(style.padding?.left, 16);
    });

    test('apply with empty string', () {
      final style = DacsStyle.apply('');
      expect(style.fontSize, isNull);
    });
  });

  group('DacsStyleTween', () {
    test('lerp at t=0 returns begin', () {
      final tween = DacsStyleTween(
        begin: DacsStyle()..fontSize = 10,
        end: DacsStyle()..fontSize = 20,
      );
      expect(tween.lerp(0).fontSize, 10);
    });

    test('lerp at t=1 returns end', () {
      final tween = DacsStyleTween(
        begin: DacsStyle()..fontSize = 10,
        end: DacsStyle()..fontSize = 20,
      );
      expect(tween.lerp(1).fontSize, 20);
    });

    test('lerp at t=0.5 interpolates', () {
      final tween = DacsStyleTween(
        begin: DacsStyle()..fontSize = 10,
        end: DacsStyle()..fontSize = 20,
      );
      expect(tween.lerp(0.5).fontSize, 15);
    });

    test('lerp handles null fields', () {
      final tween = DacsStyleTween(
        begin: DacsStyle(),
        end: DacsStyle()..fontSize = 20,
      );
      expect(tween.lerp(0.5).fontSize, 10);
    });
  });

  group('Arbitrary values', () {
    test('parses text-[#ff0000]', () {
      final style = 'text-[#ff0000]'.dStyle;
      expect(style.color, const Color(0xFFFF0000));
    });

    test('parses bg-[rgb(255,0,0)]', () {
      final style = 'bg-[rgb(255,0,0)]'.dStyle;
      expect(style.backgroundColor, const Color(0xFFFF0000));
    });

    test('parses p-[20]', () {
      final style = 'p-[20]'.dStyle;
      expect(style.padding?.left, 20);
    });

    test('parses w-[100] h-[50]', () {
      final style = 'w-[100] h-[50]'.dStyle;
      expect(style.width, 100);
      expect(style.height, 50);
    });

    test('parses rounded-[12]', () {
      final style = 'rounded-[12]'.dStyle;
      expect(style.borderRadius, isA<BorderRadius>());
      final br = style.borderRadius as BorderRadius;
      expect(br.topLeft.x, 12);
    });

    test('parses opacity-[0.75]', () {
      final style = 'opacity-[0.75]'.dStyle;
      expect(style.opacity, 0.75);
    });

    test('parses text-[#f00] (3-hex)', () {
      final style = 'text-[#f00]'.dStyle;
      expect(style.color, const Color(0xFFFF0000));
    });

    test('parses bg-[#80ff0000] (8-hex ARGB)', () {
      final style = 'bg-[#80ff0000]'.dStyle;
      expect(style.backgroundColor, const Color(0x80FF0000));
    });

    test('parses rgba with alpha', () {
      final style = 'bg-[rgba(255,0,0,0.5)]'.dStyle;
      expect(style.backgroundColor, const Color(0x80FF0000));
    });

    test('parses w-[50%] percentage', () {
      final style = 'w-[50%]'.dStyle;
      expect(style.width, 50);
    });

    test('parses from-[#ff0000] via-[#00ff00] to-[#0000ff]', () {
      final style =
          'bg-gradient-to-r from-[#ff0000] via-[#00ff00] to-[#0000ff]'.dStyle;
      expect(style.gradientFromColor, const Color(0xFFFF0000));
      expect(style.gradientViaColor, const Color(0xFF00FF00));
      expect(style.gradientToColor, const Color(0xFF0000FF));
    });

    test('parses border-[#ff0000] arbitrary color', () {
      final style = 'border-[#ff0000]'.dStyle;
      expect(style.borderColor, const Color(0xFFFF0000));
    });

    test('parses px-[20] py-[10] arbitrary directional padding', () {
      final style = 'px-[20] py-[10]'.dStyle;
      expect(style.padding?.left, 20);
      expect(style.padding?.right, 20);
      expect(style.padding?.top, 10);
      expect(style.padding?.bottom, 10);
    });

    test('parses mx-[20] my-[10] arbitrary directional margin', () {
      final style = 'mx-[20] my-[10]'.dStyle;
      expect(style.margin?.left, 20);
      expect(style.margin?.right, 20);
      expect(style.margin?.top, 10);
      expect(style.margin?.bottom, 10);
    });

    test('parses scale-[200] arbitrary scale', () {
      final style = 'scale-[200]'.dStyle;
      expect(style.scaleX, 2.0);
      expect(style.scaleY, 2.0);
    });

    test('parses rotate-[45] arbitrary rotate', () {
      final style = 'rotate-[45]'.dStyle;
      expect(style.rotateDegrees, 45);
    });

    test('parses skew-x-[15] arbitrary skew', () {
      final style = 'skew-x-[15]'.dStyle;
      expect(style.skewX, 15);
    });

    test('parses pt-[8] pb-[4] arbitrary directional padding', () {
      final style = 'pt-[8] pb-[4]'.dStyle;
      expect(style.padding?.top, 8);
      expect(style.padding?.bottom, 4);
    });

    test('parses mt-[8] mb-[4] arbitrary directional margin', () {
      final style = 'mt-[8] mb-[4]'.dStyle;
      expect(style.margin?.top, 8);
      expect(style.margin?.bottom, 4);
    });

    test('parses inset-[20] arbitrary position', () {
      final style = 'inset-[20]'.dStyle;
      expect(style.insetTop, 20);
      expect(style.insetRight, 20);
      expect(style.insetBottom, 20);
      expect(style.insetLeft, 20);
    });

    test('parses decoration-[#ff0000] arbitrary color', () {
      final style = 'decoration-[#ff0000]'.dStyle;
      expect(style.textDecorationColor, const Color(0xFFFF0000));
    });

    test('parses rounded-t-[10] arbitrary directional radius', () {
      final style = 'rounded-t-[10]'.dStyle;
      final br = style.borderRadius as BorderRadius;
      expect(br.topLeft.x, 10);
      expect(br.topRight.x, 10);
      expect(br.bottomLeft.x, 0);
    });

    test('parses gap-[10]', () {
      final style = 'gap-[10]'.dStyle;
      expect(style.gap, 10);
    });
  });

  group('Min/Max constraints', () {
    test('parses min-w-4', () {
      final s = 'min-w-4'.dStyle;
      expect(s.minWidth, 16);
    });

    test('parses max-w-*', () {
      final s = 'max-w-96 max-w-full'.dStyle;
      expect(s.maxWidth, double.infinity);
    });

    test('parses min-h-*', () {
      final s = 'min-h-12'.dStyle;
      expect(s.minHeight, 48);
    });

    test('parses max-h-*', () {
      final s = 'max-h-64'.dStyle;
      expect(s.maxHeight, 256);
    });

    test('parses min-w-full as infinity', () {
      final s = 'min-w-full'.dStyle;
      expect(s.minWidth, double.infinity);
    });

    test('parses max-w-auto as 0', () {
      final s = 'max-w-auto'.dStyle;
      expect(s.maxWidth, 0);
    });
  });

  group('Object fit', () {
    test('parses object-cover', () {
      final s = 'object-cover'.dStyle;
      expect(s.boxFit, BoxFit.cover);
    });

    test('parses object-contain', () {
      final s = 'object-contain'.dStyle;
      expect(s.boxFit, BoxFit.contain);
    });

    test('parses object-fill', () {
      final s = 'object-fill'.dStyle;
      expect(s.boxFit, BoxFit.fill);
    });

    test('parses object-none', () {
      final s = 'object-none'.dStyle;
      expect(s.boxFit, BoxFit.none);
    });

    test('parses object-scale-down', () {
      final s = 'object-scale-down'.dStyle;
      expect(s.boxFit, BoxFit.scaleDown);
    });
  });

  group('Aspect ratio', () {
    test('parses aspect-square', () {
      final s = 'aspect-square'.dStyle;
      expect(s.aspectRatio, 1.0);
    });

    test('parses aspect-video', () {
      final s = 'aspect-video'.dStyle;
      expect(s.aspectRatio, closeTo(16 / 9, 1e-10));
    });

    test('parses aspect-[4/3]', () {
      final s = 'aspect-[4/3]'.dStyle;
      expect(s.aspectRatio, closeTo(4 / 3, 1e-10));
    });

    test('parses aspect-[16/9]', () {
      final s = 'aspect-[16/9]'.dStyle;
      expect(s.aspectRatio, closeTo(16 / 9, 1e-10));
    });

    test('unknown aspect returns null', () {
      final s = 'aspect-unknown'.dStyle;
      expect(s.aspectRatio, isNull);
    });
  });

  group('Alignment', () {
    test('parses align-center', () {
      final s = 'align-center'.dStyle;
      expect(s.alignment, Alignment.center);
    });

    test('parses align-topLeft', () {
      final s = 'align-topLeft'.dStyle;
      expect(s.alignment, Alignment.topLeft);
    });

    test('parses align-bottomRight', () {
      final s = 'align-bottomRight'.dStyle;
      expect(s.alignment, Alignment.bottomRight);
    });

    test('parses align-left (centerLeft)', () {
      final s = 'align-left'.dStyle;
      expect(s.alignment, Alignment.centerLeft);
    });

    test('parses align-top (topCenter)', () {
      final s = 'align-top'.dStyle;
      expect(s.alignment, Alignment.topCenter);
    });

    test('parses align-bottom (bottomCenter)', () {
      final s = 'align-bottom'.dStyle;
      expect(s.alignment, Alignment.bottomCenter);
    });

    test('parses align-right (centerRight)', () {
      final s = 'align-right'.dStyle;
      expect(s.alignment, Alignment.centerRight);
    });
  });

  group('Conversion methods', () {
    test('toBorder returns BoxBorder from borderColor', () {
      final s = DacsStyle()
        ..borderColor = const Color(0xFF0000FF)
        ..borderWidth = 2;
      final border = s.toBorder();
      expect(border, isA<Border>());
    });

    test('toBorder returns null when no border fields set', () {
      expect(DacsStyle().toBorder(), isNull);
    });

    test('toBorderSide returns BorderSide from borderColor', () {
      final s = DacsStyle()
        ..borderColor = const Color(0xFFFF0000)
        ..borderWidth = 3;
      final side = s.toBorderSide();
      expect(side, isA<BorderSide>());
      expect(side!.color, const Color(0xFFFF0000));
      expect(side.width, 3);
    });

    test('toRadius returns borderRadius directly', () {
      final s = DacsStyle()..borderRadius = BorderRadius.circular(12);
      expect(s.toRadius(), BorderRadius.circular(12));
    });

    test('toConstraints combines width and height', () {
      final s = DacsStyle()
        ..width = 100
        ..height = 200;
      final c = s.toConstraints();
      expect(c, isA<BoxConstraints>());
      expect(c!.minWidth, 100);
      expect(c.maxWidth, 100);
      expect(c.minHeight, 200);
      expect(c.maxHeight, 200);
    });

    test('toConstraints uses min/max when width is unset', () {
      final s = DacsStyle()
        ..minWidth = 50
        ..maxWidth = 150;
      final c = s.toConstraints();
      expect(c!.minWidth, 50);
      expect(c.maxWidth, 150);
    });

    test('toConstraints returns null when no constraint fields', () {
      expect(DacsStyle().toConstraints(), isNull);
    });

    test('toAlignment returns alignment field', () {
      final s = DacsStyle()..alignment = Alignment.centerRight;
      expect(s.toAlignment(), Alignment.centerRight);
    });

    test('toShapeBorder returns RoundedRectangleBorder from borderRadius', () {
      final s = DacsStyle()..borderRadius = BorderRadius.circular(8);
      final shape = s.toShapeBorder();
      expect(shape, isA<RoundedRectangleBorder>());
    });

    test('toShapeBorder returns null without borderRadius', () {
      expect(DacsStyle().toShapeBorder(), isNull);
    });
  });

  group('Extension getters (Phase 2)', () {
    test('.dBorder returns BoxBorder', () {
      final b = 'border-red-500 border-2'.dBorder;
      expect(b, isA<Border>());
    });

    test('.dBorder returns null when no border', () {
      expect('text-lg'.dBorder, isNull);
    });

    test('.dBorderSide returns BorderSide', () {
      final s = 'border-blue-300 border-2'.dBorderSide;
      expect(s, isA<BorderSide>());
      expect(s!.color, const Color(0xFF93C5FD));
      expect(s.width, 8);
    });

    test('.dRadius returns BorderRadiusGeometry', () {
      final r = 'rounded-xl'.dRadius;
      expect(r, isA<BorderRadiusGeometry>());
    });

    test('.dConstraints returns BoxConstraints', () {
      final c = 'w-32 h-48'.dConstraints;
      expect(c, isA<BoxConstraints>());
      expect(c!.minWidth, 128);
      expect(c.maxWidth, 128);
      expect(c.minHeight, 192);
      expect(c.maxHeight, 192);
    });

    test('.dConstraints with min/max', () {
      final c = 'min-w-12 max-w-64'.dConstraints;
      expect(c, isA<BoxConstraints>());
      expect(c!.minWidth, 48);
      expect(c.maxWidth, 256);
    });

    test('.dAlignment returns AlignmentGeometry', () {
      final a = 'align-center'.dAlignment;
      expect(a, Alignment.center);
    });

    test('.dShapeBorder returns ShapeBorder', () {
      final s = 'rounded-lg'.dShapeBorder;
      expect(s, isA<RoundedRectangleBorder>());
    });

    test('.dShapeBorder returns null without rounded', () {
      expect('text-lg'.dShapeBorder, isNull);
    });
  });
}
