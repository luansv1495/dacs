import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
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

    test('toFixedSize returns Size from width and height', () {
      final s = DacsStyle()
        ..width = 100
        ..height = 200;
      expect(s.toFixedSize(), const Size(100, 200));
    });

    test('toFixedSize returns null without width or height', () {
      expect(DacsStyle().toFixedSize(), isNull);
    });

    test('toLayoutStyle groups reusable layout fields', () {
      final s = DacsStyle()
        ..width = 100
        ..height = 200
        ..aspectRatio = 16 / 9
        ..boxFit = BoxFit.cover
        ..overflow = Clip.hardEdge
        ..alignment = Alignment.center;
      final layout = s.toLayoutStyle();
      expect(layout.fixedSize, const Size(100, 200));
      expect(layout.constraints, isA<BoxConstraints>());
      expect(layout.aspectRatio, closeTo(16 / 9, 1e-10));
      expect(layout.boxFit, BoxFit.cover);
      expect(layout.overflow, Clip.hardEdge);
      expect(layout.alignment, Alignment.center);
      expect(layout.hasLayout, isTrue);
    });
  });
}
