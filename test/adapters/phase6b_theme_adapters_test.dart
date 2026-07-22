import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('phase 6B theme adapters', () {
    testWidgets('dNavRail resolves NavigationRailThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-surface text-primary selected:text-onPrimary unselected-secondary indicator-primary rounded-lg shadow-md w-6 min-w-16 extended:min-w-64 rail-label-selected rail-group-end rail-indicator'
                .dNavRail(ctx),
      );

      expect(data.backgroundColor, const Color(0xFFFFFBFE));
      expect(data.elevation, isNotNull);
      expect(data.selectedLabelTextStyle?.color, const Color(0xFFFFFFFF));
      expect(data.unselectedLabelTextStyle?.color, const Color(0xFF03DAC6));
      expect(data.selectedIconTheme?.color, const Color(0xFFFFFFFF));
      expect(data.unselectedIconTheme?.color, const Color(0xFF03DAC6));
      expect(data.groupAlignment, 1);
      expect(data.labelType, NavigationRailLabelType.selected);
      expect(data.useIndicator, isTrue);
      expect(data.indicatorColor, const Color(0xFF6200EE));
      expect(data.indicatorShape, isA<RoundedRectangleBorder>());
      expect(data.minWidth, 64);
      expect(data.minExtendedWidth, 256);
    });

    testWidgets('dPopupMenu resolves PopupMenuThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-surface text-primary disabled:text-error indicator-secondary rounded-lg shadow-lg p-2 cursor-click feedback popup-under w-6'
                .dPopupMenu(ctx),
      );

      expect(data.color, const Color(0xFFFFFBFE));
      expect(data.shape, isA<RoundedRectangleBorder>());
      expect(data.menuPadding, isNotNull);
      expect(data.elevation, isNotNull);
      expect(data.shadowColor, isNotNull);
      expect(data.surfaceTintColor, const Color(0xFF03DAC6));
      expect(data.textStyle?.color, const Color(0xFF6200EE));
      expect(
        data.labelTextStyle!.resolve({WidgetState.disabled})?.color,
        const Color(0xFFB00020),
      );
      expect(data.enableFeedback, isTrue);
      expect(data.mouseCursor!.resolve({}), SystemMouseCursors.click);
      expect(data.position, PopupMenuPosition.under);
      expect(data.iconColor, const Color(0xFF6200EE));
      expect(data.iconSize, 24);
    });

    testWidgets('dDropdownMenu resolves DropdownMenuThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-surface text-primary disabled:text-error border-outline rounded-lg p-4 focus:border-primary hover:bg-secondary min-w-64 max-w-96 label-align-hint label-float-always shadow-md'
                .dDropdownMenu(ctx),
      );

      expect(data.textStyle?.color, const Color(0xFF6200EE));
      expect(data.disabledColor, const Color(0xFFB00020));
      expect(data.menuStyle, isNotNull);
      expect(
        data.menuStyle!.backgroundColor!.resolve({}),
        const Color(0xFFFFFBFE),
      );
      expect(data.inputDecorationTheme?.filled, isTrue);
      expect(data.inputDecorationTheme?.fillColor, const Color(0xFFFFFBFE));
      expect(
        data.inputDecorationTheme?.focusedBorder,
        isA<OutlineInputBorder>(),
      );
      expect(data.inputDecorationTheme?.alignLabelWithHint, isTrue);
      expect(
        data.inputDecorationTheme?.floatingLabelBehavior,
        FloatingLabelBehavior.always,
      );
      expect(data.inputDecorationTheme?.constraints?.minWidth, 256);
      expect(data.inputDecorationTheme?.constraints?.maxWidth, 384);
    });
  });
}
