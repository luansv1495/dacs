import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('menu style adapter', () {
    testWidgets('dMenu resolves MenuStyle', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary rounded-lg p-4 w-64 h-12 min-w-32 max-w-96 align-center density-compact'
                .dMenu(ctx),
      );
      expect(data.backgroundColor, isNotNull);
      expect(data.shape, isNotNull);
      expect(data.padding, isNotNull);
      expect(data.alignment, Alignment.center);
      expect(data.fixedSize!.resolve({}), const Size(256, 48));
      expect(data.minimumSize!.resolve({}), const Size(128, 0));
      expect(data.maximumSize!.resolve({}), const Size(384, double.infinity));
      expect(data.visualDensity, VisualDensity.compact);
    });

    testWidgets('dMenu resolves shape and side as state properties', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary border-2 hover:rounded-xl hover:border-error hover:shadow-lg'
                .dMenu(ctx),
      );
      expect(data.shape, isA<WidgetStateProperty<OutlinedBorder?>>());
      expect(data.side, isA<WidgetStateProperty<BorderSide?>>());
      expect(
        data.side!.resolve({WidgetState.hovered})?.color,
        const Color(0xFFB00020),
      );
      expect(data.shadowColor!.resolve({WidgetState.hovered}), isNotNull);
      expect(data.elevation!.resolve({WidgetState.hovered}), isNotNull);
    });
  });
}
