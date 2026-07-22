import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('phase 6A theme adapters', () {
    testWidgets('dIconButton resolves IconButtonThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary overlay-secondary hover:overlay-error rounded-lg p-2 w-12 h-12 cursor-click splash-none'
                .dIconButton(ctx),
      );

      final style = data.style!;
      expect(
        style.backgroundColor!.resolve({}),
        const Color(0xFF6200EE),
      );
      expect(
        style.foregroundColor!.resolve({}),
        const Color(0xFFFFFFFF),
      );
      expect(
        style.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFFB00020),
      );
      expect(style.fixedSize!.resolve({}), const Size(48, 48));
      expect(style.mouseCursor!.resolve({}), SystemMouseCursors.click);
      expect(style.splashFactory, NoSplash.splashFactory);
    });

    testWidgets('dSegmentedButton resolves SegmentedButtonThemeData', (
      t,
    ) async {
      final data = await t.run(
        (ctx) =>
            'bg-surface text-primary selected:bg-primary selected:text-onPrimary border-outline rounded-lg p-2 selected-icon-check'
                .dSegmentedButton(ctx),
      );

      final style = data.style!;
      expect(
        style.backgroundColor!.resolve({}),
        const Color(0xFFFFFBFE),
      );
      expect(
        style.backgroundColor!.resolve({WidgetState.selected}),
        const Color(0xFF6200EE),
      );
      expect(data.selectedIcon, isA<Icon>());
      expect((data.selectedIcon as Icon).icon, Icons.check);
    });

    testWidgets('dBadge resolves BadgeThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-error text-onError text-xs p-1 align-topRight left-2 top-1 small:h-2 large:h-6'
                .dBadge(ctx),
      );

      expect(data.backgroundColor, const Color(0xFFB00020));
      expect(data.textColor, const Color(0xFFFFFFFF));
      expect(data.textStyle?.fontSize, 12);
      expect(data.padding, isNotNull);
      expect(data.alignment, Alignment.topRight);
      expect(data.offset, const Offset(8, 4));
      expect(data.smallSize, 8);
      expect(data.largeSize, 24);
    });

    testWidgets('dDrawer resolves DrawerThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-surface barrier-scrim indicator-primary shadow-lg rounded-r-lg w-80 overflow-hidden'
                .dDrawer(ctx),
      );

      expect(data.backgroundColor, const Color(0xFFFFFBFE));
      expect(data.scrimColor, const Color(0xFF000000));
      expect(data.surfaceTintColor, const Color(0xFF6200EE));
      expect(data.elevation, isNotNull);
      expect(data.shadowColor, isNotNull);
      expect(data.shape, isA<RoundedRectangleBorder>());
      expect(data.endShape, isA<RoundedRectangleBorder>());
      expect(data.width, 320);
      expect(data.clipBehavior, Clip.hardEdge);
    });

    testWidgets('dBottomAppBar resolves BottomAppBarThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-surface indicator-primary shadow-md h-16 p-4 bottom-appbar-notch'
                .dBottomAppBar(ctx),
      );

      expect(data.color, const Color(0xFFFFFBFE));
      expect(data.surfaceTintColor, const Color(0xFF6200EE));
      expect(data.elevation, isNotNull);
      expect(data.shadowColor, isNotNull);
      expect(data.height, 64);
      expect(data.padding, isNotNull);
      expect(data.shape, isA<CircularNotchedRectangle>());
    });
  });
}
