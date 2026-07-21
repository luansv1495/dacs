import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
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

    test('.dFixedSize returns Size', () {
      expect('w-32 h-48'.dFixedSize, const Size(128, 192));
    });

    test('.dLayout returns DacsLayoutStyle', () {
      final layout =
          'w-32 h-48 min-w-12 max-w-64 aspect-video object-cover overflow-hidden align-center'
              .dLayout;
      expect(layout.fixedSize, const Size(128, 192));
      expect(layout.constraints, isA<BoxConstraints>());
      expect(layout.constraints!.minWidth, 48);
      expect(layout.constraints!.maxWidth, 256);
      expect(layout.aspectRatio, closeTo(16 / 9, 1e-10));
      expect(layout.boxFit, BoxFit.cover);
      expect(layout.overflow, Clip.hardEdge);
      expect(layout.alignment, Alignment.center);
    });
  });
}
