import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('scrollbar theme adapter', () {
    testWidgets('dScrollbar resolves ScrollbarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg border-2'.dScrollbar(ctx),
      );
      expect(data.thumbColor, isNotNull);
      expect(data.radius, isNotNull);
      expect(data.thickness, isNotNull);
    });

    testWidgets('dScrollbar resolves native state properties', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary hover:bg-error active:bg-secondary disabled:bg-outline border-outline hover:border-error active:border-secondary m-4 min-h-12'
                .dScrollbar(ctx),
      );
      expect(
        data.thumbColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(
        data.thumbColor!.resolve({WidgetState.pressed}),
        const Color(0xFF03DAC6),
      );
      expect(
        data.thumbColor!.resolve({WidgetState.disabled}),
        const Color(0xFF79747E),
      );
      expect(
        data.trackColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(
        data.trackColor!.resolve({WidgetState.pressed}),
        const Color(0xFF03DAC6),
      );
      expect(data.trackBorderColor!.resolve({}), const Color(0xFF79747E));
      expect(data.minThumbLength, 48);
      expect(data.crossAxisMargin, 16);
      expect(data.mainAxisMargin, 16);
    });

    testWidgets('dScrollbar maps opacity to visibility flags', (t) async {
      final visible = await t.run((ctx) => 'opacity-100'.dScrollbar(ctx));
      expect(visible.thumbVisibility!.resolve({}), isTrue);
      expect(visible.trackVisibility!.resolve({}), isTrue);
      expect(visible.interactive, isNull);

      final hidden = await t.run((ctx) => 'opacity-0'.dScrollbar(ctx));
      expect(hidden.thumbVisibility!.resolve({}), isFalse);
      expect(hidden.trackVisibility!.resolve({}), isFalse);
      expect(hidden.interactive, isFalse);
    });
  });
}
