import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('Border parser basics', () {
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
      final style = 'border-2'.dBase;
      expect(style.borderWidth, 8);
    });

    test('parses background with rounded and border color', () {
      final box = 'bg-red-500 rounded-lg border-2 border-blue-500'.dBox;
      expect(box.color, const Color(0xFFEF4444));
      expect(box.border, isNotNull);
    });
  });

  group('Border', () {
    test('parses rounded (no suffix)', () {
      final br = 'rounded'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 4);
    });

    test('parses rounded-none', () {
      final br = 'rounded-none'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 0);
    });

    test('parses rounded-sm', () {
      final br = 'rounded-sm'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 2);
    });

    test('parses rounded-md', () {
      final br = 'rounded-md'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 6);
    });

    test('parses rounded-xl', () {
      final br = 'rounded-xl'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 12);
    });

    test('parses rounded-2xl', () {
      final br = 'rounded-2xl'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 16);
    });

    test('parses rounded-3xl', () {
      final br = 'rounded-3xl'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 24);
    });

    test('parses directional rounded-t', () {
      final br = 'rounded-t-lg'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
      expect(br.topRight.x, 8);
      expect(br.bottomLeft.x, 0);
      expect(br.bottomRight.x, 0);
    });

    test('parses directional rounded-b', () {
      final br = 'rounded-b-lg'.dBase.borderRadius as BorderRadius;
      expect(br.bottomLeft.x, 8);
      expect(br.bottomRight.x, 8);
      expect(br.topLeft.x, 0);
    });

    test('parses directional rounded-l', () {
      final br = 'rounded-l-lg'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
      expect(br.bottomLeft.x, 8);
      expect(br.topRight.x, 0);
    });

    test('parses directional rounded-r', () {
      final br = 'rounded-r-lg'.dBase.borderRadius as BorderRadius;
      expect(br.topRight.x, 8);
      expect(br.bottomRight.x, 8);
      expect(br.topLeft.x, 0);
    });

    test('parses rounded-tl', () {
      final br = 'rounded-tl-lg'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
      expect(br.topRight.x, 0);
    });

    test('parses rounded-tr', () {
      final br = 'rounded-tr-lg'.dBase.borderRadius as BorderRadius;
      expect(br.topRight.x, 8);
      expect(br.topLeft.x, 0);
    });

    test('parses rounded-bl', () {
      final br = 'rounded-bl-lg'.dBase.borderRadius as BorderRadius;
      expect(br.bottomLeft.x, 8);
      expect(br.bottomRight.x, 0);
    });

    test('parses rounded-br', () {
      final br = 'rounded-br-lg'.dBase.borderRadius as BorderRadius;
      expect(br.bottomRight.x, 8);
      expect(br.bottomLeft.x, 0);
    });

    test('parses border (no width value)', () {
      expect('border'.dBase.borderWidth, 1);
    });
  });

  group('RTL border-radius', () {
    test('parses rounded-ts-lg (top-start)', () {
      final br = 'rounded-ts-lg'.dBase.borderRadius as BorderRadius;
      expect(br.topLeft.x, 8);
      expect(br.topRight.x, 0);
    });

    test('parses rounded-te-lg (top-end)', () {
      final br = 'rounded-te-lg'.dBase.borderRadius as BorderRadius;
      expect(br.topRight.x, 8);
      expect(br.topLeft.x, 0);
    });

    test('parses rounded-bs-lg (bottom-start)', () {
      final br = 'rounded-bs-lg'.dBase.borderRadius as BorderRadius;
      expect(br.bottomLeft.x, 8);
      expect(br.bottomRight.x, 0);
    });

    test('parses rounded-be-lg (bottom-end)', () {
      final br = 'rounded-be-lg'.dBase.borderRadius as BorderRadius;
      expect(br.bottomRight.x, 8);
      expect(br.bottomLeft.x, 0);
    });

    test('parses rounded-ss-lg (top-start logical)', () {
      final br = 'rounded-ss-lg'.dBase.borderRadius;
      expect(br, isA<BorderRadiusDirectional>());
      final directional = br as BorderRadiusDirectional;
      expect(directional.topStart.x, 8);
    });

    test('parses rounded-se-lg (top-end logical)', () {
      final br = 'rounded-se-lg'.dBase.borderRadius;
      expect(br, isA<BorderRadiusDirectional>());
      final directional = br as BorderRadiusDirectional;
      expect(directional.topEnd.x, 8);
    });
  });
}
