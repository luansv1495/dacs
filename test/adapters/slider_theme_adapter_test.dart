import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('slider theme adapter', () {
    testWidgets('dSlider resolves SliderThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary border-secondary h-2 disabled:bg-error'
                .dSlider(ctx),
      );
      expect(data.activeTrackColor, const Color(0xFF6200EE));
      expect(data.inactiveTrackColor, const Color(0xFF03DAC6));
      expect(data.thumbColor, const Color(0xFFFFFFFF));
      expect(data.disabledActiveTrackColor, const Color(0xFFB00020));
      expect(data.trackHeight, 8);
    });
  });
}
