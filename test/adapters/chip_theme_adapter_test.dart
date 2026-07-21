import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('chip theme adapter', () {
    testWidgets('dChip resolves ChipThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary rounded-lg p-2 m-1 shadow-lg selected:bg-secondary active:shadow-sm disabled:bg-outline w-6 brightness-dark no-checkmark'
                .dChip(ctx),
      );
      expect(data.color, isNotNull);
      expect(data.shape, isNotNull);
      expect(data.padding, isNotNull);
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.selectedColor, const Color(0xFF03DAC6));
      expect(data.disabledColor, const Color(0xFF79747E));
      expect(data.checkmarkColor, const Color(0xFFFFFFFF));
      expect(data.labelStyle?.color, const Color(0xFFFFFFFF));
      expect(data.shadowColor, isNotNull);
      expect(data.elevation, isNotNull);
      expect(data.pressElevation, isNotNull);
      expect(data.labelPadding, isNotNull);
      expect(data.iconTheme?.size, 24);
      expect(data.brightness, Brightness.dark);
      expect(data.showCheckmark, isFalse);
    });
  });
}
