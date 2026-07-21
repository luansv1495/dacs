import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('data table adapter', () {
    testWidgets('dDataTable resolves DataTableThemeData', (t) async {
      final data = await t.run((ctx) => 'bg-primary p-4'.dDataTable(ctx));
      expect(data.headingRowColor, isNotNull);
      expect(data.horizontalMargin, 16);
    });

    testWidgets('dDataTable resolves text and decoration fields', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary border-2'.dDataTable(ctx),
      );
      expect(data.headingTextStyle?.color, const Color(0xFFFFFFFF));
      expect(data.dataTextStyle?.color, const Color(0xFFFFFFFF));
      expect(data.dividerThickness, 8);
      expect(data.decoration, isA<BoxDecoration>());
    });

    testWidgets('dDataTable resolves hover row colors and column spacing', (
      t,
    ) async {
      final data = await t.run(
        (ctx) => 'hover:bg-primary px-4 py-2'.dDataTable(ctx),
      );

      expect(
        data.headingRowColor!.resolve({WidgetState.hovered}),
        const Color(0xFF6200EE).withAlpha(26),
      );
      expect(
        data.dataRowColor!.resolve({WidgetState.hovered}),
        const Color(0xFF6200EE).withAlpha(13),
      );
      expect(data.horizontalMargin, 16);
      expect(data.columnSpacing, 16);
    });
  });
}
