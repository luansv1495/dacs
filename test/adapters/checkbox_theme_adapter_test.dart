import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('checkbox theme adapter', () {
    testWidgets('dCheckbox resolves CheckboxThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dCheckbox(ctx),
      );
      expect(data.fillColor, isNotNull);
      expect(data.checkColor, isNotNull);
    });

    testWidgets('dCheckbox resolves hover and base colors', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary hover:bg-error text-onPrimary'.dCheckbox(ctx),
      );

      expect(data.fillColor!.resolve(<WidgetState>{}), const Color(0xFF6200EE));
      expect(
        data.fillColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(
        data.checkColor!.resolve(<WidgetState>{}),
        const Color(0xFFFFFFFF),
      );
    });

    testWidgets('dRadio resolves RadioThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dRadio(ctx),
      );
      expect(data.fillColor, isNotNull);
    });

    testWidgets('dRadio resolves pressed and hover colors', (t) async {
      final data = await t.run(
        (ctx) => 'pressed:text-error hover:text-secondary'.dRadio(ctx),
      );

      expect(data.fillColor!.resolve(<WidgetState>{}), isNull);
      expect(
        data.fillColor!.resolve({WidgetState.pressed}),
        const Color(0xFFB00020),
      );
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFF03DAC6).withAlpha(26),
      );
    });
  });
}
