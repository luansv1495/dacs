import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('switch theme adapter', () {
    testWidgets('dSwitch resolves SwitchThemeData', (t) async {
      final data = await t.run(
        (ctx) => 'bg-primary text-onPrimary'.dSwitch(ctx),
      );
      expect(data.thumbColor, isNotNull);
      expect(data.trackColor, isNotNull);
    });

    testWidgets('dSwitch resolves pressed thumb and outline states', (t) async {
      final data = await t.run(
        (ctx) =>
            'pressed:text-secondary border-outline hover:bg-error'.dSwitch(ctx),
      );

      expect(data.thumbColor!.resolve(<WidgetState>{}), isNull);
      expect(
        data.thumbColor!.resolve({WidgetState.pressed}),
        const Color(0xFF03DAC6),
      );
      expect(
        data.trackOutlineColor!.resolve(<WidgetState>{}),
        const Color(0xFF79747E),
      );
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020).withAlpha(26),
      );
    });
  });
}
