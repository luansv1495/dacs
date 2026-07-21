import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';
import '../support/material_test_helpers.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('navigation bar adapter', () {
    testWidgets('dBottomNav resolves BottomNavigationBarThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary unselected-secondary w-6 shadow-lg hide-selected-labels show-unselected-labels bottom-nav-shifting bottom-nav-layout-linear'
                .dBottomNav(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.selectedItemColor, const Color(0xFFFFFFFF));
      expect(data.unselectedItemColor, const Color(0xFF03DAC6));
      expect(data.elevation, isNotNull);
      expect(data.selectedIconTheme?.color, const Color(0xFFFFFFFF));
      expect(data.selectedIconTheme?.size, 24);
      expect(data.unselectedIconTheme?.color, const Color(0xFF03DAC6));
      expect(data.showSelectedLabels, isFalse);
      expect(data.showUnselectedLabels, isTrue);
      expect(data.type, BottomNavigationBarType.shifting);
      expect(data.landscapeLayout, BottomNavigationBarLandscapeLayout.linear);
    });

    testWidgets('dNavBar resolves NavigationBarThemeData', (t) async {
      final data = await t.run(
        (ctx) =>
            'bg-primary text-onPrimary indicator-secondary overlay-error hover:overlay-primary h-20 p-4 shadow-lg nav-label-selected'
                .dNavBar(ctx),
      );
      expect(data.backgroundColor, const Color(0xFF6200EE));
      expect(data.height, 80);
      expect(data.elevation, isNotNull);
      expect(data.shadowColor, isNotNull);
      expect(data.surfaceTintColor, const Color(0xFF6200EE));
      expect(data.indicatorColor, const Color(0xFF03DAC6));
      expect(data.labelTextStyle, isNotNull);
      expect(data.overlayColor!.resolve({}), const Color(0xFFB00020));
      expect(
        data.overlayColor!.resolve({WidgetState.hovered}),
        const Color(0xFF6200EE),
      );
      expect(data.labelPadding, isNotNull);
      expect(
        data.labelBehavior,
        NavigationDestinationLabelBehavior.onlyShowSelected,
      );
    });
  });
}
