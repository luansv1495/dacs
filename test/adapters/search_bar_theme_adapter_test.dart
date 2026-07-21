import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('search bar theme adapter', () {
    testWidgets('dSearchBar resolves SearchBarThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary rounded-lg'.dSearchBar(ctx),
      );
      expect(data.backgroundColor, isNotNull);
      expect(data.shape, isNotNull);
    });

    testWidgets('dSearchBar resolves native state properties', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary hover:bg-error focus:bg-secondary disabled:bg-outline focus:border-secondary overlay-primary hover:overlay-error border-2 rounded-lg p-4 min-w-64 max-w-96 capitalize-words'
                .dSearchBar(ctx),
      );
      expect(
        data.backgroundColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(
        data.backgroundColor!.resolve({WidgetState.focused}),
        const Color(0xFF03DAC6),
      );
      expect(
        data.backgroundColor!.resolve({WidgetState.disabled}),
        const Color(0xFF79747E),
      );
      expect(
        data.side!.resolve({WidgetState.focused})?.color,
        const Color(0xFF03DAC6),
      );
      expect(data.overlayColor!.resolve({}), const Color(0xFF6200EE));
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(data.padding!.resolve({}), isA<EdgeInsetsGeometry>());
      expect(data.textStyle!.resolve({})?.color, const Color(0xFFFFFFFF));
      expect(data.hintStyle!.resolve({})?.color, const Color(0xFFFFFFFF));
      expect(data.constraints?.minWidth, 256);
      expect(data.constraints?.maxWidth, 384);
      expect(data.textCapitalization, TextCapitalization.words);
    });

    testWidgets('dSearchBar resolves hover shadow and elevation', (t) async {
      final data = await t.run(
        (ctx) => 'hover:shadow-lg focus:shadow-md'.dSearchBar(ctx),
      );

      expect(data.elevation!.resolve({WidgetState.hovered}), isNotNull);
      expect(data.elevation!.resolve({WidgetState.focused}), isNotNull);
      expect(data.shadowColor!.resolve({WidgetState.hovered}), isNotNull);
      expect(data.shadowColor!.resolve({WidgetState.focused}), isNotNull);
    });
  });
}
