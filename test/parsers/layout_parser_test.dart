import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Layout parser basics', () {
    test('parses width and height', () {
      final style = 'w-64 h-32'.dBase;
      expect(style.width, 256);
      expect(style.height, 128);
    });

    test('parses opacity', () {
      final style = 'opacity-50'.dBase;
      expect(style.opacity, 0.5);
    });

    test('parses opacity edge cases', () {
      expect('opacity-0'.dBase.opacity, 0);
      expect('opacity-100'.dBase.opacity, 1);
      expect('opacity-25'.dBase.opacity, 0.25);
      expect('opacity-75'.dBase.opacity, 0.75);
    });

    test('parses w-auto and h-auto', () {
      expect('w-auto'.dBase.width, 0);
      expect('h-auto'.dBase.height, 0);
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
      final style = 'inset-0 top-4'.dBase;
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
      final style = 'scale-125'.dBase;
      expect(style.scaleX, 1.25);
      expect(style.scaleY, 1.25);
    });

    test('parses scale-x-150', () {
      final style = 'scale-x-150'.dBase;
      expect(style.scaleX, 1.5);
      expect(style.scaleY, isNull);
    });

    test('parses rotate-45', () {
      final style = 'rotate-45'.dBase;
      expect(style.rotateDegrees, 45);
    });

    test('parses translate-x-4', () {
      final style = 'translate-x-4'.dBase;
      expect(style.translateX, 16);
    });

    test('parses translate-y-2', () {
      final style = 'translate-y-2'.dBase;
      expect(style.translateY, 8);
    });

    test('parses skew-x-12', () {
      final style = 'skew-x-12'.dBase;
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
      final style = 'scale-125 rotate-90'.dBase;
      expect(style.scaleX, 1.25);
      expect(style.rotateDegrees, 90);
    });

    test('parses scale-y-150', () {
      final style = 'scale-y-150'.dBase;
      expect(style.scaleY, 1.5);
      expect(style.scaleX, isNull);
    });

    test('parses all scale values', () {
      expect('scale-50'.dBase.scaleX, 0.5);
      expect('scale-75'.dBase.scaleX, 0.75);
      expect('scale-90'.dBase.scaleX, 0.9);
      expect('scale-95'.dBase.scaleX, 0.95);
      expect('scale-100'.dBase.scaleX, 1.0);
      expect('scale-105'.dBase.scaleX, 1.05);
      expect('scale-110'.dBase.scaleX, 1.1);
      expect('scale-0'.dBase.scaleX, 0);
    });

    test('parses negative rotate', () {
      expect('rotate--45'.dBase.rotateDegrees, -45);
      expect('rotate--90'.dBase.rotateDegrees, -90);
    });

    test('parses skew-y-12', () {
      final style = 'skew-y-12'.dBase;
      expect(style.skewY, 12);
      expect(style.skewX, isNull);
    });

    test('parses translate-x-auto gracefully', () {
      final style = 'translate-x-auto'.dBase;
      expect(style.translateX, isNull);
    });
  });

  group('Gradient', () {
    test('parses gradient direction', () {
      final style = 'bg-gradient-to-r'.dBase;
      expect(style.gradientDirection, DacsGradientDirection.toR);
    });

    test('parses from-* and to-* colors', () {
      final style = 'from-red-500 to-indigo-600'.dBase;
      expect(style.gradientFromColor, const Color(0xFFEF4444));
      expect(style.gradientToColor, const Color(0xFF4F46E5));
    });

    test('parses via color', () {
      final style = 'from-red-500 via-orange-500 to-yellow-500'.dBase;
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
      final style = 'bg-gradient-to-r from-primary to-secondary'.dBase;
      expect(style.gradientFromThemeColor, 'primary');
      expect(style.gradientToThemeColor, 'secondary');
    });

    test('all gradient directions', () {
      expect(
        'bg-gradient-to-r'.dBase.gradientDirection,
        DacsGradientDirection.toR,
      );
      expect(
        'bg-gradient-to-l'.dBase.gradientDirection,
        DacsGradientDirection.toL,
      );
      expect(
        'bg-gradient-to-t'.dBase.gradientDirection,
        DacsGradientDirection.toT,
      );
      expect(
        'bg-gradient-to-b'.dBase.gradientDirection,
        DacsGradientDirection.toB,
      );
      expect(
        'bg-gradient-to-tr'.dBase.gradientDirection,
        DacsGradientDirection.toTR,
      );
      expect(
        'bg-gradient-to-tl'.dBase.gradientDirection,
        DacsGradientDirection.toTL,
      );
      expect(
        'bg-gradient-to-br'.dBase.gradientDirection,
        DacsGradientDirection.toBR,
      );
      expect(
        'bg-gradient-to-bl'.dBase.gradientDirection,
        DacsGradientDirection.toBL,
      );
    });
  });

  group('Gap', () {
    test('parses gap-4', () {
      final style = 'gap-4'.dBase;
      expect(style.gap, 16);
    });

    test('parses gap-0', () {
      expect('gap-0'.dBase.gap, 0);
    });

    test('parses gap-px', () {
      expect('gap-px'.dBase.gap, 1);
    });

    test('parses gap-2', () {
      expect('gap-2'.dBase.gap, 8);
    });
  });

  group('Flex helpers', () {
    test('parses flex', () {
      expect('flex'.dBase.flex, 1);
    });

    test('parses flex-col', () {
      expect('flex-col'.dBase.flexDirection, Axis.vertical);
    });

    test('parses flex-row', () {
      expect('flex-row'.dBase.flexDirection, Axis.horizontal);
    });

    test('parses flex-wrap', () {
      expect('flex-wrap'.dBase.flexWrap, isTrue);
    });

    test('parses flex-nowrap', () {
      expect('flex-nowrap'.dBase.flexWrap, isFalse);
    });

    test('parses items-center', () {
      expect('items-center'.dBase.alignItems, CrossAxisAlignment.center);
    });

    test('parses items-start', () {
      expect('items-start'.dBase.alignItems, CrossAxisAlignment.start);
    });

    test('parses items-end', () {
      expect('items-end'.dBase.alignItems, CrossAxisAlignment.end);
    });

    test('parses items-stretch', () {
      expect('items-stretch'.dBase.alignItems, CrossAxisAlignment.stretch);
    });

    test('parses justify-center', () {
      expect('justify-center'.dBase.justifyContent, MainAxisAlignment.center);
    });

    test('parses justify-between', () {
      expect(
        'justify-between'.dBase.justifyContent,
        MainAxisAlignment.spaceBetween,
      );
    });

    test('parses justify-around', () {
      expect(
        'justify-around'.dBase.justifyContent,
        MainAxisAlignment.spaceAround,
      );
    });

    test('parses justify-evenly', () {
      expect(
        'justify-evenly'.dBase.justifyContent,
        MainAxisAlignment.spaceEvenly,
      );
    });

    test('parses justify-start', () {
      expect('justify-start'.dBase.justifyContent, MainAxisAlignment.start);
    });

    test('parses justify-end', () {
      expect('justify-end'.dBase.justifyContent, MainAxisAlignment.end);
    });
  });

  group('Overflow', () {
    test('parses overflow-hidden', () {
      expect('overflow-hidden'.dBase.overflow, Clip.hardEdge);
    });

    test('parses overflow-scroll', () {
      expect('overflow-scroll'.dBase.overflow, Clip.hardEdge);
    });

    test('parses overflow-visible', () {
      expect('overflow-visible'.dBase.overflow, Clip.none);
    });

    test('parses overflow-clip', () {
      expect('overflow-clip'.dBase.overflow, Clip.antiAlias);
    });
  });

  group('Arbitrary values', () {
    test('parses text-[#ff0000]', () {
      final style = 'text-[#ff0000]'.dBase;
      expect(style.color, const Color(0xFFFF0000));
    });

    test('parses bg-[rgb(255,0,0)]', () {
      final style = 'bg-[rgb(255,0,0)]'.dBase;
      expect(style.backgroundColor, const Color(0xFFFF0000));
    });

    test('parses p-[20]', () {
      final style = 'p-[20]'.dBase;
      expect(style.padding?.left, 20);
    });

    test('parses w-[100] h-[50]', () {
      final style = 'w-[100] h-[50]'.dBase;
      expect(style.width, 100);
      expect(style.height, 50);
    });

    test('parses rounded-[12]', () {
      final style = 'rounded-[12]'.dBase;
      expect(style.borderRadius, isA<BorderRadius>());
      final br = style.borderRadius as BorderRadius;
      expect(br.topLeft.x, 12);
    });

    test('parses opacity-[0.75]', () {
      final style = 'opacity-[0.75]'.dBase;
      expect(style.opacity, 0.75);
    });

    test('parses text-[#f00] (3-hex)', () {
      final style = 'text-[#f00]'.dBase;
      expect(style.color, const Color(0xFFFF0000));
    });

    test('parses bg-[#80ff0000] (8-hex ARGB)', () {
      final style = 'bg-[#80ff0000]'.dBase;
      expect(style.backgroundColor, const Color(0x80FF0000));
    });

    test('parses rgba with alpha', () {
      final style = 'bg-[rgba(255,0,0,0.5)]'.dBase;
      expect(style.backgroundColor, const Color(0x80FF0000));
    });

    test('parses w-[50%] percentage', () {
      final style = 'w-[50%]'.dBase;
      expect(style.width, 50);
    });

    test('parses from-[#ff0000] via-[#00ff00] to-[#0000ff]', () {
      final style =
          'bg-gradient-to-r from-[#ff0000] via-[#00ff00] to-[#0000ff]'.dBase;
      expect(style.gradientFromColor, const Color(0xFFFF0000));
      expect(style.gradientViaColor, const Color(0xFF00FF00));
      expect(style.gradientToColor, const Color(0xFF0000FF));
    });

    test('parses border-[#ff0000] arbitrary color', () {
      final style = 'border-[#ff0000]'.dBase;
      expect(style.borderColor, const Color(0xFFFF0000));
    });

    test('parses px-[20] py-[10] arbitrary directional padding', () {
      final style = 'px-[20] py-[10]'.dBase;
      expect(style.padding?.left, 20);
      expect(style.padding?.right, 20);
      expect(style.padding?.top, 10);
      expect(style.padding?.bottom, 10);
    });

    test('parses mx-[20] my-[10] arbitrary directional margin', () {
      final style = 'mx-[20] my-[10]'.dBase;
      expect(style.margin?.left, 20);
      expect(style.margin?.right, 20);
      expect(style.margin?.top, 10);
      expect(style.margin?.bottom, 10);
    });

    test('parses scale-[200] arbitrary scale', () {
      final style = 'scale-[200]'.dBase;
      expect(style.scaleX, 2.0);
      expect(style.scaleY, 2.0);
    });

    test('parses rotate-[45] arbitrary rotate', () {
      final style = 'rotate-[45]'.dBase;
      expect(style.rotateDegrees, 45);
    });

    test('parses skew-x-[15] arbitrary skew', () {
      final style = 'skew-x-[15]'.dBase;
      expect(style.skewX, 15);
    });

    test('parses pt-[8] pb-[4] arbitrary directional padding', () {
      final style = 'pt-[8] pb-[4]'.dBase;
      expect(style.padding?.top, 8);
      expect(style.padding?.bottom, 4);
    });

    test('parses mt-[8] mb-[4] arbitrary directional margin', () {
      final style = 'mt-[8] mb-[4]'.dBase;
      expect(style.margin?.top, 8);
      expect(style.margin?.bottom, 4);
    });

    test('parses inset-[20] arbitrary position', () {
      final style = 'inset-[20]'.dBase;
      expect(style.insetTop, 20);
      expect(style.insetRight, 20);
      expect(style.insetBottom, 20);
      expect(style.insetLeft, 20);
    });

    test('parses decoration-[#ff0000] arbitrary color', () {
      final style = 'decoration-[#ff0000]'.dBase;
      expect(style.textDecorationColor, const Color(0xFFFF0000));
    });

    test('parses rounded-t-[10] arbitrary directional radius', () {
      final style = 'rounded-t-[10]'.dBase;
      final br = style.borderRadius as BorderRadius;
      expect(br.topLeft.x, 10);
      expect(br.topRight.x, 10);
      expect(br.bottomLeft.x, 0);
    });

    test('parses gap-[10]', () {
      final style = 'gap-[10]'.dBase;
      expect(style.gap, 10);
    });

    test('parses arbitrary percentage layout and position values', () {
      final style =
          'h-[25%] opacity-[125%] gap-[12%] inset-[50%] inset-x-[20%] '
                  'inset-y-[30%] top-[10%] right-[15%] bottom-[25%] '
                  'left-[35%] border-[3%]'
              .dBase;

      expect(style.height, 25);
      expect(style.opacity, 1);
      expect(style.gap, 12);
      expect(style.insetTop, 0.1);
      expect(style.insetRight, 0.15);
      expect(style.insetBottom, 0.25);
      expect(style.insetLeft, 0.35);
      expect(style.borderWidth, 3);
    });

    test('parses arbitrary remaining padding and margin sides', () {
      final style = 'pr-[3] pl-[4] m-[5] mr-[6] ml-[7]'.dBase;

      expect(style.padding?.right, 3);
      expect(style.padding?.left, 4);
      expect(style.margin?.top, 5);
      expect(style.margin?.bottom, 5);
      expect(style.margin?.right, 11);
      expect(style.margin?.left, 12);
    });

    test('parses arbitrary directional radius corners', () {
      final style = 'rounded-b-[1] rounded-l-[2] rounded-r-[3] '
              'rounded-tl-[4] rounded-tr-[5] rounded-bl-[6] rounded-br-[7]'
          .dBase;
      final br = style.borderRadius as BorderRadius;

      expect(br.topLeft.x, 4);
      expect(br.topRight.x, 5);
      expect(br.bottomLeft.x, 6);
      expect(br.bottomRight.x, 7);
    });

    test('parses arbitrary logical directional radius corners', () {
      final directional =
          'rounded-ss-[1] rounded-se-[2] rounded-es-[3] rounded-ee-[4]'
              .dBase
              .borderRadius;

      expect(directional, isA<BorderRadiusDirectional>());
    });

    test('parses arbitrary numeric layout, transform, and typography values',
        () {
      final style = 'flex-[2] inset-x-[8] inset-y-[9] top-[1] right-[2] '
              'bottom-[3] left-[4] scale-x-[150] scale-y-[75] '
              'translate-x-[11] translate-y-[12] skew-y-[13] '
              'leading-[1.5] tracking-[0.2]'
          .dBase;

      expect(style.flex, 2);
      expect(style.insetTop, 1);
      expect(style.insetRight, 2);
      expect(style.insetBottom, 3);
      expect(style.insetLeft, 4);
      expect(style.scaleX, 1.5);
      expect(style.scaleY, 0.75);
      expect(style.translateX, 11);
      expect(style.translateY, 12);
      expect(style.skewY, 13);
      expect(style.lineHeight, 1.5);
      expect(style.letterSpacing, 0.2);
    });

    test('reports malformed arbitrary values as unknown utilities', () {
      final unknown = <String>[];
      Dacs.configure(onUnknownUtility: unknown.add);

      final style = 'text-[#ff] bg-[hsl(0,100%,50%)] w-[oops]'.dBase;

      expect(style.color, isNull);
      expect(style.backgroundColor, isNull);
      expect(style.width, isNull);
      expect(unknown, [
        'text-[#ff]',
        'bg-[hsl(0,100%,50%)]',
        'w-[oops]',
      ]);
    });
  });

  group('Min/Max constraints', () {
    test('parses min-w-4', () {
      final s = 'min-w-4'.dBase;
      expect(s.minWidth, 16);
    });

    test('parses max-w-*', () {
      final s = 'max-w-96 max-w-full'.dBase;
      expect(s.maxWidth, double.infinity);
    });

    test('parses min-h-*', () {
      final s = 'min-h-12'.dBase;
      expect(s.minHeight, 48);
    });

    test('parses max-h-*', () {
      final s = 'max-h-64'.dBase;
      expect(s.maxHeight, 256);
    });

    test('parses min-w-full as infinity', () {
      final s = 'min-w-full'.dBase;
      expect(s.minWidth, double.infinity);
    });

    test('parses max-w-auto as 0', () {
      final s = 'max-w-auto'.dBase;
      expect(s.maxWidth, 0);
    });
  });

  group('Object fit', () {
    test('parses object-cover', () {
      final s = 'object-cover'.dBase;
      expect(s.boxFit, BoxFit.cover);
    });

    test('parses object-contain', () {
      final s = 'object-contain'.dBase;
      expect(s.boxFit, BoxFit.contain);
    });

    test('parses object-fill', () {
      final s = 'object-fill'.dBase;
      expect(s.boxFit, BoxFit.fill);
    });

    test('parses object-none', () {
      final s = 'object-none'.dBase;
      expect(s.boxFit, BoxFit.none);
    });

    test('parses object-scale-down', () {
      final s = 'object-scale-down'.dBase;
      expect(s.boxFit, BoxFit.scaleDown);
    });
  });

  group('Aspect ratio', () {
    test('parses aspect-square', () {
      final s = 'aspect-square'.dBase;
      expect(s.aspectRatio, 1.0);
    });

    test('parses aspect-video', () {
      final s = 'aspect-video'.dBase;
      expect(s.aspectRatio, closeTo(16 / 9, 1e-10));
    });

    test('parses aspect-[4/3]', () {
      final s = 'aspect-[4/3]'.dBase;
      expect(s.aspectRatio, closeTo(4 / 3, 1e-10));
    });

    test('parses aspect-[16/9]', () {
      final s = 'aspect-[16/9]'.dBase;
      expect(s.aspectRatio, closeTo(16 / 9, 1e-10));
    });

    test('unknown aspect returns null', () {
      final s = 'aspect-unknown'.dBase;
      expect(s.aspectRatio, isNull);
    });
  });

  group('Alignment', () {
    test('parses align-center', () {
      final s = 'align-center'.dBase;
      expect(s.alignment, Alignment.center);
    });

    test('parses align-topLeft', () {
      final s = 'align-topLeft'.dBase;
      expect(s.alignment, Alignment.topLeft);
    });

    test('parses align-bottomRight', () {
      final s = 'align-bottomRight'.dBase;
      expect(s.alignment, Alignment.bottomRight);
    });

    test('parses align-left (centerLeft)', () {
      final s = 'align-left'.dBase;
      expect(s.alignment, Alignment.centerLeft);
    });

    test('parses align-top (topCenter)', () {
      final s = 'align-top'.dBase;
      expect(s.alignment, Alignment.topCenter);
    });

    test('parses align-bottom (bottomCenter)', () {
      final s = 'align-bottom'.dBase;
      expect(s.alignment, Alignment.bottomCenter);
    });

    test('parses align-right (centerRight)', () {
      final s = 'align-right'.dBase;
      expect(s.alignment, Alignment.centerRight);
    });
  });
}
