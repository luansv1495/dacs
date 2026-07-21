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
        (ctx) =>
            'bg-primary hover:bg-error text-onPrimary overlay-secondary hover:overlay-error cursor-click splash-4 density-compact tap-target-shrink'
                .dCheckbox(ctx),
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
      expect(data.overlayColor!.resolve({}), const Color(0xFF03DAC6));
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(data.mouseCursor!.resolve({}), SystemMouseCursors.click);
      expect(data.splashRadius, 16);
      expect(data.visualDensity, VisualDensity.compact);
      expect(data.materialTapTargetSize, MaterialTapTargetSize.shrinkWrap);
    });

    testWidgets('dRadio resolves RadioThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dRadio(ctx),
      );
      expect(data.fillColor, isNotNull);
    });

    testWidgets('dRadio resolves pressed and hover colors', (t) async {
      final data = await t.run(
        (ctx) => 'pressed:bg-error hover:text-secondary'.dRadio(ctx),
      );

      expect(data.fillColor!.resolve(<WidgetState>{}), isNull);
      expect(
        data.fillColor!.resolve({WidgetState.pressed}),
        const Color(0xFFB00020),
      );
      expect(data.overlayColor, isNull);
    });

    testWidgets('dRadio resolves background, side, cursor, and inner radius', (
      t,
    ) async {
      final data = await t.run(
        (ctx) =>
            'bg-surface border-outline border-2 w-2 overlay-primary cursor-forbidden splash-8 density-comfortable tap-target-padded'
                .dRadio(ctx),
      );

      expect(
        data.backgroundColor!.resolve({}),
        const Color(0xFFFFFBFE),
      );
      expect(data.side?.color, const Color(0xFF79747E));
      expect(data.side?.width, 8);
      expect(data.innerRadius!.resolve({}), 8);
      expect(data.overlayColor!.resolve({}), const Color(0xFF6200EE));
      expect(data.mouseCursor!.resolve({}), SystemMouseCursors.forbidden);
      expect(data.splashRadius, 32);
      expect(data.visualDensity, VisualDensity.comfortable);
      expect(data.materialTapTargetSize, MaterialTapTargetSize.padded);
    });
  });
}
