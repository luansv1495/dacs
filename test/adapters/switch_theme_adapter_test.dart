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
            'pressed:text-secondary border border-outline hover:bg-error overlay-primary hover:overlay-error cursor-click splash-6 tap-target-shrink'
                .dSwitch(ctx),
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
      expect(data.trackOutlineWidth!.resolve(<WidgetState>{}), 1);
      expect(data.overlayColor!.resolve({}), const Color(0xFF6200EE));
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(data.mouseCursor!.resolve({}), SystemMouseCursors.click);
      expect(data.splashRadius, 24);
      expect(data.materialTapTargetSize, MaterialTapTargetSize.shrinkWrap);
    });

    testWidgets('dSwitch resolves explicit thumb icon', (t) async {
      final data = await t.run(
        (ctx) => 'thumb-icon-check text-primary text-lg'.dSwitch(ctx),
      );

      final icon = data.thumbIcon!.resolve({});
      expect(icon?.icon, Icons.check);
      expect(icon?.color, const Color(0xFF6200EE));
      expect(icon?.size, 18);
    });
  });
}
