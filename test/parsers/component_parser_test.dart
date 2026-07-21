import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dacs/dacs.dart';

void main() {
  tearDown(() {
    Dacs.configure();
    DacsCompiler.clearCache();
  });

  group('component parser', () {
    test('parses explicit component colors', () {
      final style = DacsCompiler.compile(
        'overlay-red-500 indicator-primary barrier-scrim '
        'unselected-secondary disabled-action-error',
      ).base;

      expect(style.overlayColor, const Color(0xFFEF4444));
      expect(style.indicatorThemeColor, 'primary');
      expect(style.barrierThemeColor, 'scrim');
      expect(style.unselectedThemeColor, 'secondary');
      expect(style.disabledActionThemeColor, 'error');
    });

    test('parses interaction tokens', () {
      final style = DacsCompiler.compile(
        'cursor-click splash-4 density-compact tap-target-shrink '
        'feedback icon-align-end duration-200 splash-none',
      ).base;

      expect(style.mouseCursor, SystemMouseCursors.click);
      expect(style.splashRadius, 16);
      expect(style.visualDensity, VisualDensity.compact);
      expect(style.materialTapTargetSize, MaterialTapTargetSize.shrinkWrap);
      expect(style.enableFeedback, isTrue);
      expect(style.iconAlignment, IconAlignment.end);
      expect(style.animationDuration, const Duration(milliseconds: 200));
      expect(style.splashFactory, NoSplash.splashFactory);
    });

    test('parses flags and enums', () {
      final style = DacsCompiler.compile(
        'label-align-hint label-float-never brightness-dark no-checkmark '
        'tab-indicator-tab hide-selected-labels show-unselected-labels '
        'bottom-nav-fixed bottom-nav-layout-centered capitalize-characters '
        'nav-label-never tooltip-above show-close show-drag-handle '
        'value-indicator-never',
      ).base;

      expect(style.inputAlignLabelWithHint, isTrue);
      expect(style.inputFloatingLabelBehavior, FloatingLabelBehavior.never);
      expect(style.chipBrightness, Brightness.dark);
      expect(style.chipShowCheckmark, isFalse);
      expect(style.tabIndicatorSize, TabBarIndicatorSize.tab);
      expect(style.bottomNavShowSelectedLabels, isFalse);
      expect(style.bottomNavShowUnselectedLabels, isTrue);
      expect(style.bottomNavType, BottomNavigationBarType.fixed);
      expect(
        style.bottomNavLandscapeLayout,
        BottomNavigationBarLandscapeLayout.centered,
      );
      expect(style.textCapitalization, TextCapitalization.characters);
      expect(
        style.navigationLabelBehavior,
        NavigationDestinationLabelBehavior.alwaysHide,
      );
      expect(style.tooltipPreferBelow, isFalse);
      expect(style.snackShowCloseIcon, isTrue);
      expect(style.bottomSheetShowDragHandle, isTrue);
      expect(style.sliderShowValueIndicator, ShowValueIndicator.never);
    });

    test('parses shape presets and icon axes', () {
      final style = DacsCompiler.compile(
        'w-3 splash-6 slider-track-rect slider-thumb-round '
        'slider-overlay-round slider-value-indicator-rect '
        'icon-fill icon-weight-500 icon-grade--25 icon-optical-48',
      ).base;

      expect(style.sliderTrackShape, isA<RectangularSliderTrackShape>());
      expect(style.sliderThumbShape, isA<RoundSliderThumbShape>());
      expect(style.sliderOverlayShape, isA<RoundSliderOverlayShape>());
      expect(
        style.sliderValueIndicatorShape,
        isA<RectangularSliderValueIndicatorShape>(),
      );
      expect(style.iconFill, 1);
      expect(style.iconWeight, 500);
      expect(style.iconGrade, -25);
      expect(style.iconOpticalSize, 48);
    });

    test('parses final widget-specific tokens', () {
      final style = DacsCompiler.compile(
        'button-bg-layer button-fg-layer thumb-icon-check '
        'tooltip-wait-500 tooltip-show-1500 tooltip-exit-100 '
        'snackbar-fixed object-cover image-asset-[assets/card.png]',
      ).base;

      expect(style.buttonBackgroundLayer, isTrue);
      expect(style.buttonForegroundLayer, isTrue);
      expect(style.switchThumbIcon, Icons.check);
      expect(style.tooltipWaitDuration, const Duration(milliseconds: 500));
      expect(style.tooltipShowDuration, const Duration(milliseconds: 1500));
      expect(style.tooltipExitDuration, const Duration(milliseconds: 100));
      expect(style.snackBehavior, SnackBarBehavior.fixed);
      expect(style.decorationImage, isNotNull);
      expect(style.decorationImage!.fit, BoxFit.cover);
      expect(style.decorationImage!.image, isA<AssetImage>());
    });
  });
}
