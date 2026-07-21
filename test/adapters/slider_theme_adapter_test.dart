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
            'bg-primary text-onPrimary border-secondary h-2 disabled:bg-error overlay-secondary cursor-click slider-track-rounded slider-thumb-round slider-overlay-round slider-value-indicator-paddle value-indicator-always'
                .dSlider(ctx),
      );
      expect(data.activeTrackColor, const Color(0xFF6200EE));
      expect(data.inactiveTrackColor, const Color(0xFF03DAC6));
      expect(data.thumbColor, const Color(0xFFFFFFFF));
      expect(data.disabledActiveTrackColor, const Color(0xFFB00020));
      expect(data.disabledThumbColor, isNull);
      expect(data.overlayColor, const Color(0xFF03DAC6));
      expect(data.mouseCursor!.resolve({}), SystemMouseCursors.click);
      expect(data.trackHeight, 8);
      expect(data.trackShape, isA<RoundedRectSliderTrackShape>());
      expect(data.thumbShape, isA<RoundSliderThumbShape>());
      expect(data.overlayShape, isA<RoundSliderOverlayShape>());
      expect(data.valueIndicatorShape, isA<PaddleSliderValueIndicatorShape>());
      expect(data.showValueIndicator, ShowValueIndicator.onDrag);
    });

    testWidgets('dSlider maps simple layout and cursor fields', (t) async {
      final data = await t.run(
        (ctx) => 'text-onPrimary w-6 h-6 p-2 gap-2'.dSlider(ctx),
      );

      expect(data.valueIndicatorTextStyle?.color, const Color(0xFFFFFFFF));
      expect(data.thumbSize!.resolve({}), const Size(24, 24));
      expect(data.padding, isNotNull);
      expect(data.trackGap, 8);
      expect(data.mouseCursor, isNull);
    });
  });
}
