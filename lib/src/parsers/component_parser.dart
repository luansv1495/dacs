// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_style.dart';
import '../tokens/colors.dart';
import '../tokens/spacing.dart';
import 'parser.dart';

const _themeColors = {
  'primary',
  'onPrimary',
  'primaryContainer',
  'onPrimaryContainer',
  'secondary',
  'onSecondary',
  'secondaryContainer',
  'onSecondaryContainer',
  'tertiary',
  'onTertiary',
  'tertiaryContainer',
  'onTertiaryContainer',
  'error',
  'onError',
  'errorContainer',
  'onErrorContainer',
  'surface',
  'onSurface',
  'surfaceVariant',
  'onSurfaceVariant',
  'outline',
  'outlineVariant',
  'inverseSurface',
  'onInverseSurface',
  'inversePrimary',
  'shadow',
  'scrim',
};

class ComponentParser extends DacsParser {
  @override
  bool parse(String token, DacsStyle style) {
    if (_tryColor('overlay', token, style, (v) => style.overlayThemeColor = v,
        (v) => style.overlayColor = v)) {
      return true;
    }
    if (_tryColor(
        'indicator',
        token,
        style,
        (v) => style.indicatorThemeColor = v,
        (v) => style.indicatorColor = v)) {
      return true;
    }
    if (_tryColor('barrier', token, style, (v) => style.barrierThemeColor = v,
        (v) => style.barrierColor = v)) {
      return true;
    }
    if (_tryColor(
        'unselected',
        token,
        style,
        (v) => style.unselectedThemeColor = v,
        (v) => style.unselectedColor = v)) {
      return true;
    }
    if (_tryColor(
      'disabled-action',
      token,
      style,
      (v) => style.disabledActionThemeColor = v,
      (v) => style.disabledActionColor = v,
    )) {
      return true;
    }
    if (_tryComponentColors(token, style)) return true;

    final cursor = _cursor(token);
    if (cursor != null) {
      style.mouseCursor = cursor;
      return true;
    }

    final density = _visualDensity(token);
    if (density != null) {
      style.visualDensity = density;
      return true;
    }

    final tapTarget = _tapTargetSize(token);
    if (tapTarget != null) {
      style.materialTapTargetSize = tapTarget;
      return true;
    }

    final iconAlignment = _iconAlignment(token);
    if (iconAlignment != null) {
      style.iconAlignment = iconAlignment;
      return true;
    }

    final splashFactory = _splashFactory(token);
    if (splashFactory != null) {
      style.splashFactory = splashFactory;
      return true;
    }

    final splash = RegExp(r'^splash-(.+)$').firstMatch(token);
    if (splash != null) {
      final value = _numberOrSpacing(splash.group(1)!);
      if (value == null) return false;
      style.splashRadius = value;
      return true;
    }

    final thumbIcon = _switchThumbIcon(token);
    if (thumbIcon != null) {
      style.switchThumbIcon = thumbIcon;
      return true;
    }

    final selectedIcon = _selectedIcon(token);
    if (selectedIcon != null) {
      style.selectedIconData = selectedIcon;
      return true;
    }

    final textCapitalization = _textCapitalization(token);
    if (textCapitalization != null) {
      style.textCapitalization = textCapitalization;
      return true;
    }

    final navLabel = _navigationLabelBehavior(token);
    if (navLabel != null) {
      style.navigationLabelBehavior = navLabel;
      return true;
    }

    final railLabel = _navigationRailLabelType(token);
    if (railLabel != null) {
      style.navigationRailLabelType = railLabel;
      return true;
    }

    final railGroup = _navigationRailGroupAlignment(token);
    if (railGroup != null) {
      style.navigationRailGroupAlignment = railGroup;
      return true;
    }

    final popupPosition = _popupMenuPosition(token);
    if (popupPosition != null) {
      style.popupMenuPosition = popupPosition;
      return true;
    }

    final tabIndicator = _tabIndicatorSize(token);
    if (tabIndicator != null) {
      style.tabIndicatorSize = tabIndicator;
      return true;
    }

    final bottomNavType = _bottomNavType(token);
    if (bottomNavType != null) {
      style.bottomNavType = bottomNavType;
      return true;
    }

    final bottomNavLayout = _bottomNavLandscapeLayout(token);
    if (bottomNavLayout != null) {
      style.bottomNavLandscapeLayout = bottomNavLayout;
      return true;
    }

    final floatingLabel = _floatingLabelBehavior(token);
    if (floatingLabel != null) {
      style.inputFloatingLabelBehavior = floatingLabel;
      return true;
    }

    final valueIndicator = _showValueIndicator(token);
    if (valueIndicator != null) {
      style.sliderShowValueIndicator = valueIndicator;
      return true;
    }

    if (_parseBooleans(token, style)) return true;
    if (_parseBrightness(token, style)) return true;
    if (_parseDurations(token, style)) return true;
    if (_parseDecorationImage(token, style)) return true;
    if (_parseSnackBehavior(token, style)) return true;
    if (_parseSliderShapes(token, style)) return true;
    if (_parseIconAxes(token, style)) return true;

    return false;
  }

  bool _tryColor(
    String prefix,
    String token,
    DacsStyle style,
    void Function(String) setTheme,
    void Function(Color) setColor,
  ) {
    final expected = '$prefix-';
    if (!token.startsWith(expected)) return false;
    final value = token.substring(expected.length);
    if (_themeColors.contains(value)) {
      setTheme(value);
      return true;
    }
    final color = parseDacsColor(value);
    if (color == null) return false;
    setColor(color);
    return true;
  }

  bool _tryComponentColors(String token, DacsStyle style) {
    const channels = {
      'date-header-bg': 'dateHeaderBackground',
      'date-header-text': 'dateHeaderForeground',
      'date-day-bg': 'dateDayBackground',
      'date-day-text': 'dateDayForeground',
      'date-day-overlay': 'dateDayOverlay',
      'date-today-bg': 'dateTodayBackground',
      'date-today-text': 'dateTodayForeground',
      'date-year-bg': 'dateYearBackground',
      'date-year-text': 'dateYearForeground',
      'date-year-overlay': 'dateYearOverlay',
      'date-range-bg': 'dateRangeBackground',
      'date-range-header-bg': 'dateRangeHeaderBackground',
      'date-range-header-text': 'dateRangeHeaderForeground',
      'date-range-selection-bg': 'dateRangeSelectionBackground',
      'date-range-selection-overlay': 'dateRangeSelectionOverlay',
      'date-divider': 'dateDivider',
      'date-sub-header-text': 'dateSubHeaderForeground',
      'time-day-period-bg': 'timeDayPeriodBackground',
      'time-day-period-text': 'timeDayPeriodForeground',
      'time-day-period-border': 'timeDayPeriodBorder',
      'time-dial-bg': 'timeDialBackground',
      'time-dial-hand': 'timeDialHand',
      'time-dial-text': 'timeDialForeground',
      'time-entry-icon': 'timeEntryModeIcon',
      'time-hour-minute-bg': 'timeHourMinuteBackground',
      'time-hour-minute-text': 'timeHourMinuteForeground',
      'time-separator': 'timeSeparatorForeground',
    };

    for (final entry in channels.entries) {
      final expected = '${entry.key}-';
      if (!token.startsWith(expected)) continue;
      final value = token.substring(expected.length);
      if (_themeColors.contains(value)) {
        style.setComponentThemeColor(entry.value, value);
        return true;
      }
      final color = parseDacsColor(value);
      if (color == null) return false;
      style.setComponentColor(entry.value, color);
      return true;
    }
    return false;
  }

  MouseCursor? _cursor(String token) => switch (token) {
        'cursor-basic' => SystemMouseCursors.basic,
        'cursor-click' => SystemMouseCursors.click,
        'cursor-forbidden' => SystemMouseCursors.forbidden,
        'cursor-text' => SystemMouseCursors.text,
        'cursor-grab' => SystemMouseCursors.grab,
        'cursor-grabbing' => SystemMouseCursors.grabbing,
        'cursor-precise' => SystemMouseCursors.precise,
        'cursor-wait' => SystemMouseCursors.wait,
        'cursor-progress' => SystemMouseCursors.progress,
        'cursor-none' => SystemMouseCursors.none,
        _ => null,
      };

  VisualDensity? _visualDensity(String token) => switch (token) {
        'density-standard' => VisualDensity.standard,
        'density-comfortable' => VisualDensity.comfortable,
        'density-compact' => VisualDensity.compact,
        _ => null,
      };

  MaterialTapTargetSize? _tapTargetSize(String token) => switch (token) {
        'tap-target-padded' => MaterialTapTargetSize.padded,
        'tap-target-shrink' => MaterialTapTargetSize.shrinkWrap,
        _ => null,
      };

  IconAlignment? _iconAlignment(String token) => switch (token) {
        'icon-align-start' => IconAlignment.start,
        'icon-align-end' => IconAlignment.end,
        _ => null,
      };

  InteractiveInkFeatureFactory? _splashFactory(String token) => switch (token) {
        'splash-none' => NoSplash.splashFactory,
        'splash-ripple' => InkRipple.splashFactory,
        'splash-ink' => InkSplash.splashFactory,
        'splash-sparkle' => InkSparkle.splashFactory,
        _ => null,
      };

  IconData? _switchThumbIcon(String token) => switch (token) {
        'thumb-icon-check' => Icons.check,
        'thumb-icon-close' => Icons.close,
        'thumb-icon-add' => Icons.add,
        'thumb-icon-remove' => Icons.remove,
        'thumb-icon-done' => Icons.done,
        _ => null,
      };

  IconData? _selectedIcon(String token) => switch (token) {
        'selected-icon-check' => Icons.check,
        'selected-icon-close' => Icons.close,
        'selected-icon-add' => Icons.add,
        'selected-icon-remove' => Icons.remove,
        'selected-icon-done' => Icons.done,
        _ => null,
      };

  TextCapitalization? _textCapitalization(String token) => switch (token) {
        'capitalize-none' => TextCapitalization.none,
        'capitalize-words' => TextCapitalization.words,
        'capitalize-sentences' => TextCapitalization.sentences,
        'capitalize-characters' => TextCapitalization.characters,
        _ => null,
      };

  NavigationDestinationLabelBehavior? _navigationLabelBehavior(String token) =>
      switch (token) {
        'nav-label-always' => NavigationDestinationLabelBehavior.alwaysShow,
        'nav-label-selected' =>
          NavigationDestinationLabelBehavior.onlyShowSelected,
        'nav-label-never' => NavigationDestinationLabelBehavior.alwaysHide,
        _ => null,
      };

  NavigationRailLabelType? _navigationRailLabelType(String token) =>
      switch (token) {
        'rail-label-none' => NavigationRailLabelType.none,
        'rail-label-all' => NavigationRailLabelType.all,
        'rail-label-selected' => NavigationRailLabelType.selected,
        _ => null,
      };

  double? _navigationRailGroupAlignment(String token) => switch (token) {
        'rail-group-start' => -1,
        'rail-group-center' => 0,
        'rail-group-end' => 1,
        _ => null,
      };

  PopupMenuPosition? _popupMenuPosition(String token) => switch (token) {
        'popup-over' => PopupMenuPosition.over,
        'popup-under' => PopupMenuPosition.under,
        _ => null,
      };

  TabBarIndicatorSize? _tabIndicatorSize(String token) => switch (token) {
        'tab-indicator-label' => TabBarIndicatorSize.label,
        'tab-indicator-tab' => TabBarIndicatorSize.tab,
        _ => null,
      };

  BottomNavigationBarType? _bottomNavType(String token) => switch (token) {
        'bottom-nav-fixed' => BottomNavigationBarType.fixed,
        'bottom-nav-shifting' => BottomNavigationBarType.shifting,
        _ => null,
      };

  BottomNavigationBarLandscapeLayout? _bottomNavLandscapeLayout(String token) =>
      switch (token) {
        'bottom-nav-layout-spread' => BottomNavigationBarLandscapeLayout.spread,
        'bottom-nav-layout-centered' =>
          BottomNavigationBarLandscapeLayout.centered,
        'bottom-nav-layout-linear' => BottomNavigationBarLandscapeLayout.linear,
        _ => null,
      };

  FloatingLabelBehavior? _floatingLabelBehavior(String token) =>
      switch (token) {
        'label-float-auto' => FloatingLabelBehavior.auto,
        'label-float-always' => FloatingLabelBehavior.always,
        'label-float-never' => FloatingLabelBehavior.never,
        _ => null,
      };

  ShowValueIndicator? _showValueIndicator(String token) => switch (token) {
        'value-indicator-only-discrete' => ShowValueIndicator.onlyForDiscrete,
        'value-indicator-only-continuous' =>
          ShowValueIndicator.onlyForContinuous,
        'value-indicator-always' => ShowValueIndicator.onDrag,
        'value-indicator-never' => ShowValueIndicator.never,
        _ => null,
      };

  bool _parseBooleans(String token, DacsStyle style) {
    switch (token) {
      case 'feedback':
        style.enableFeedback = true;
        return true;
      case 'no-feedback':
        style.enableFeedback = false;
        return true;
      case 'label-align-hint':
        style.inputAlignLabelWithHint = true;
        return true;
      case 'label-no-align-hint':
        style.inputAlignLabelWithHint = false;
        return true;
      case 'checkmark':
        style.chipShowCheckmark = true;
        return true;
      case 'no-checkmark':
        style.chipShowCheckmark = false;
        return true;
      case 'show-selected-labels':
        style.bottomNavShowSelectedLabels = true;
        return true;
      case 'hide-selected-labels':
        style.bottomNavShowSelectedLabels = false;
        return true;
      case 'show-unselected-labels':
        style.bottomNavShowUnselectedLabels = true;
        return true;
      case 'hide-unselected-labels':
        style.bottomNavShowUnselectedLabels = false;
        return true;
      case 'tooltip-below':
        style.tooltipPreferBelow = true;
        return true;
      case 'tooltip-above':
        style.tooltipPreferBelow = false;
        return true;
      case 'show-close':
        style.snackShowCloseIcon = true;
        return true;
      case 'hide-close':
        style.snackShowCloseIcon = false;
        return true;
      case 'show-drag-handle':
        style.bottomSheetShowDragHandle = true;
        return true;
      case 'hide-drag-handle':
        style.bottomSheetShowDragHandle = false;
        return true;
      case 'button-bg-layer':
        style.buttonBackgroundLayer = true;
        return true;
      case 'no-button-bg-layer':
        style.buttonBackgroundLayer = false;
        return true;
      case 'button-fg-layer':
        style.buttonForegroundLayer = true;
        return true;
      case 'no-button-fg-layer':
        style.buttonForegroundLayer = false;
        return true;
      case 'bottom-appbar-notch':
        style.bottomAppBarShape = const CircularNotchedRectangle();
        return true;
      case 'bottom-appbar-no-notch':
        style.bottomAppBarShape = null;
        return true;
      case 'rail-indicator':
        style.navigationRailUseIndicator = true;
        return true;
      case 'no-rail-indicator':
        style.navigationRailUseIndicator = false;
        return true;
    }
    return false;
  }

  bool _parseBrightness(String token, DacsStyle style) {
    switch (token) {
      case 'brightness-light':
        style.chipBrightness = Brightness.light;
        return true;
      case 'brightness-dark':
        style.chipBrightness = Brightness.dark;
        return true;
    }
    return false;
  }

  bool _parseDurations(String token, DacsStyle style) {
    final duration = RegExp(r'^duration-(\d+)$').firstMatch(token);
    if (duration != null) {
      style.animationDuration =
          Duration(milliseconds: int.parse(duration.group(1)!));
      return true;
    }

    final tooltip =
        RegExp(r'^tooltip-(wait|show|exit)-(\d+)$').firstMatch(token);
    if (tooltip != null) {
      final value = Duration(milliseconds: int.parse(tooltip.group(2)!));
      switch (tooltip.group(1)) {
        case 'wait':
          style.tooltipWaitDuration = value;
          return true;
        case 'show':
          style.tooltipShowDuration = value;
          return true;
        case 'exit':
          style.tooltipExitDuration = value;
          return true;
      }
    }
    return false;
  }

  bool _parseDecorationImage(String token, DacsStyle style) {
    final match = RegExp(r'^image-(asset|network)-\[(.+)\]$').firstMatch(token);
    if (match == null) return false;
    final source = match.group(2)!;
    if (source.isEmpty) return false;
    late final ImageProvider<Object> image;
    if (match.group(1) == 'asset') {
      image = AssetImage(source);
    } else {
      image = NetworkImage(source);
    }
    style.decorationImage = DecorationImage(
      image: image,
      fit: style.boxFit,
      alignment: style.alignment ?? Alignment.center,
    );
    return true;
  }

  bool _parseSnackBehavior(String token, DacsStyle style) {
    switch (token) {
      case 'snackbar-floating':
        style.snackBehavior = SnackBarBehavior.floating;
        return true;
      case 'snackbar-fixed':
        style.snackBehavior = SnackBarBehavior.fixed;
        return true;
    }
    return false;
  }

  bool _parseSliderShapes(String token, DacsStyle style) {
    switch (token) {
      case 'slider-track-rounded':
        style.sliderTrackShape = const RoundedRectSliderTrackShape();
        return true;
      case 'slider-track-rect':
        style.sliderTrackShape = const RectangularSliderTrackShape();
        return true;
      case 'slider-thumb-round':
        style.sliderThumbShape = RoundSliderThumbShape(
          enabledThumbRadius: style.width ?? style.height ?? 10,
        );
        return true;
      case 'slider-thumb-none':
        style.sliderThumbShape = SliderComponentShape.noThumb;
        return true;
      case 'slider-overlay-round':
        style.sliderOverlayShape = RoundSliderOverlayShape(
          overlayRadius:
              style.splashRadius ?? style.width ?? style.height ?? 16,
        );
        return true;
      case 'slider-overlay-none':
        style.sliderOverlayShape = SliderComponentShape.noOverlay;
        return true;
      case 'slider-value-indicator-rect':
        style.sliderValueIndicatorShape =
            const RectangularSliderValueIndicatorShape();
        return true;
      case 'slider-value-indicator-paddle':
        style.sliderValueIndicatorShape =
            const PaddleSliderValueIndicatorShape();
        return true;
    }
    return false;
  }

  bool _parseIconAxes(String token, DacsStyle style) {
    if (token == 'icon-fill') {
      style.iconFill = 1;
      return true;
    }
    if (token == 'icon-no-fill') {
      style.iconFill = 0;
      return true;
    }
    final match =
        RegExp(r'^icon-(fill|weight|grade|optical)-(-?\d+(?:\.\d+)?)$')
            .firstMatch(token);
    if (match == null) return false;
    final value = double.tryParse(match.group(2)!);
    if (value == null) return false;
    switch (match.group(1)) {
      case 'fill':
        style.iconFill = value;
        return true;
      case 'weight':
        style.iconWeight = value;
        return true;
      case 'grade':
        style.iconGrade = value;
        return true;
      case 'optical':
        style.iconOpticalSize = value;
        return true;
    }
    return false;
  }

  double? _numberOrSpacing(String key) {
    return dacsSpacing(key) ?? double.tryParse(key);
  }
}
