import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('button style adapter', () {
    testWidgets('dButton resolves ButtonStyle with color', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary text-onPrimary rounded-lg p-4'.dButton(ctx),
      );
      expect(style.backgroundColor, isNotNull);
      expect(style.foregroundColor, isNotNull);
      expect(style.padding, isNotNull);
      expect(style.shape, isNotNull);
    });

    testWidgets('dButton expands to new ButtonStyle fields', (t) async {
      final style = await t.run(
        (ctx) => 'bg-primary text-onPrimary w-32 h-48 rounded-lg'.dButton(ctx),
      );
      expect(style.surfaceTintColor, isA<WidgetStateProperty<Color?>>());
      expect(style.iconColor, isA<WidgetStateProperty<Color?>>());
      expect(style.iconSize, isA<WidgetStateProperty<double?>>());
      expect(style.minimumSize, isA<WidgetStateProperty<Size?>>());
      expect(style.fixedSize, isA<WidgetStateProperty<Size?>>());
      expect(style.maximumSize, isA<WidgetStateProperty<Size?>>());
      expect(style.mouseCursor, isA<WidgetStateProperty<MouseCursor?>>());
    });

    testWidgets('dButton resolves overlay, shadow, size, and cursor states', (
      t,
    ) async {
      final style = await t.run(
        (ctx) =>
            'hover:bg-primary active:bg-error hover:shadow-lg w-64 h-12 p-4'
                .dButton(ctx),
      );

      expect(
        style.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFF6200EE).withAlpha(26),
      );
      expect(
        style.overlayColor!.resolve({WidgetState.pressed}),
        const Color(0xFFB00020).withAlpha(52),
      );
      expect(style.shadowColor!.resolve({WidgetState.hovered}), isNotNull);
      expect(style.elevation!.resolve({WidgetState.hovered}), isNotNull);
      expect(style.minimumSize!.resolve({}), const Size(256, 48));
      expect(style.fixedSize!.resolve({}), const Size(256, 48));
      expect(style.maximumSize!.resolve({}), const Size(256, 48));
      expect(
        style.mouseCursor!.resolve({WidgetState.disabled}),
        SystemMouseCursors.forbidden,
      );
      expect(style.mouseCursor!.resolve({}), SystemMouseCursors.click);
    });

    testWidgets('dButton iconSize maps from fontSize', (t) async {
      final style = await t.run(
        (ctx) => 'text-xl'.dButton(ctx),
      );
      final iconSize = style.iconSize?.resolve(<WidgetState>{});
      expect(iconSize, closeTo(20.0, 0.01));
    });

    testWidgets('dButton shape resolves dynamically via _stateProp', (t) async {
      final style = await t.run(
        (ctx) => 'rounded-lg hover:rounded-xl'.dButton(ctx),
      );
      expect(style.shape, isA<WidgetStateProperty<OutlinedBorder?>>());
      final resolved = style.shape!.resolve({WidgetState.hovered});
      expect(resolved, isA<RoundedRectangleBorder>());
      expect(
        (resolved as RoundedRectangleBorder).borderRadius,
        isA<BorderRadius>(),
      );
    });
  });
}
