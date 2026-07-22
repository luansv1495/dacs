import 'package:flutter/material.dart';
import '../adapters/button_style_adapter.dart';
import '../adapters/badge_theme_adapter.dart';
import '../adapters/bottom_app_bar_theme_adapter.dart';
import '../adapters/checkbox_theme_adapter.dart';
import '../adapters/chip_theme_adapter.dart';
import '../adapters/data_table_adapter.dart';
import '../adapters/date_picker_theme_adapter.dart';
import '../adapters/drawer_theme_adapter.dart';
import '../adapters/dropdown_menu_theme_adapter.dart';
import '../adapters/icon_button_theme_adapter.dart';
import '../adapters/input_decoration_adapter.dart';
import '../adapters/material_state.dart';
import '../adapters/menu_style_adapter.dart';
import '../adapters/navigation_bar_adapter.dart';
import '../adapters/navigation_rail_adapter.dart';
import '../adapters/popup_menu_theme_adapter.dart';
import '../adapters/scrollbar_theme_adapter.dart';
import '../adapters/search_bar_theme_adapter.dart';
import '../adapters/segmented_button_theme_adapter.dart';
import '../adapters/slider_theme_adapter.dart';
import '../adapters/switch_theme_adapter.dart';
import '../adapters/time_picker_theme_adapter.dart';
import '../dacs_compiler.dart';
import '../dacs_resolve_context.dart';
import '../dacs_resolved_style.dart';
import '../dacs_style_sheet.dart';

DacsStyleSheet _sheet(String input) => DacsCompiler.compile(input);

DacsResolveContext _context(BuildContext context) =>
    DacsResolveContext.fromBuildContext(context);

DacsResolvedStyle _resolve(String input, BuildContext context) =>
    _sheet(input).resolveWith(_context(context));

/// Extension providing Material widget theme data constructors on [String].
extension DacsWidgetExtensions on String {
  /// Builds a [ButtonStyle] from this DACS class string.
  ButtonStyle dButton(BuildContext context) =>
      const DacsButtonStyleAdapter().build(_sheet(this), _context(context));

  /// Builds [IconButtonThemeData] from this DACS class string.
  IconButtonThemeData dIconButton(BuildContext context) =>
      const DacsIconButtonThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [SegmentedButtonThemeData] from this DACS class string.
  SegmentedButtonThemeData dSegmentedButton(BuildContext context) =>
      const DacsSegmentedButtonThemeAdapter()
          .build(_sheet(this), _context(context));

  /// Builds [CheckboxThemeData] from this DACS class string.
  CheckboxThemeData dCheckbox(BuildContext context) =>
      const DacsCheckboxThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [SwitchThemeData] from this DACS class string.
  SwitchThemeData dSwitch(BuildContext context) =>
      const DacsSwitchThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [RadioThemeData] from this DACS class string.
  RadioThemeData dRadio(BuildContext context) =>
      const DacsRadioThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [ChipThemeData] from this DACS class string.
  ChipThemeData dChip(BuildContext context) =>
      const DacsChipThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [BadgeThemeData] from this DACS class string.
  BadgeThemeData dBadge(BuildContext context) =>
      const DacsBadgeThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [DrawerThemeData] from this DACS class string.
  DrawerThemeData dDrawer(BuildContext context) =>
      const DacsDrawerThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [BottomAppBarThemeData] from this DACS class string.
  BottomAppBarThemeData dBottomAppBar(BuildContext context) =>
      const DacsBottomAppBarThemeAdapter()
          .build(_sheet(this), _context(context));

  /// Builds an [AppBarTheme] from this DACS class string.
  AppBarTheme dAppBar(BuildContext context) {
    final s = _resolve(this, context);
    return AppBarTheme(
      backgroundColor: s.backgroundColor,
      foregroundColor: s.color,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.backgroundColor,
      shape: dacsShape(s),
      iconTheme: s.color != null || s.width != null
          ? IconThemeData(color: s.color, size: s.width)
          : null,
      actionsIconTheme: s.color != null || s.width != null
          ? IconThemeData(color: s.color, size: s.width)
          : null,
      titleSpacing: s.margin?.left,
      leadingWidth: s.width,
      toolbarHeight: s.height,
      toolbarTextStyle: s.toTextStyle(),
      titleTextStyle: s.toTextStyle(),
      actionsPadding: s.padding,
    );
  }

  /// Builds a [CardTheme] from this DACS class string.
  CardTheme dCard(BuildContext context) {
    final s = _resolve(this, context);
    return CardTheme(
      color: s.backgroundColor,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: dacsShape(s),
      margin: s.margin,
      clipBehavior: s.overflow,
    );
  }

  /// Builds [ListTileThemeData] from this DACS class string.
  ListTileThemeData dListTile(BuildContext context) {
    final sheet = _sheet(this);
    final ctx = _context(context);
    final s = sheet.resolveWith(ctx);
    final st = materialStateFor(sheet, ctx);
    return ListTileThemeData(
      tileColor: s.backgroundColor,
      selectedTileColor: st.variantOverrides['selected']?.backgroundColor,
      textColor: s.color,
      iconColor: s.color,
      selectedColor: s.color,
      shape: dacsShape(s),
      contentPadding: s.padding,
      titleTextStyle: s.toTextStyle(),
      subtitleTextStyle: s.toTextStyle(),
      leadingAndTrailingTextStyle: s.toTextStyle(),
      dense: s.inputDense,
      horizontalTitleGap: s.gap,
      minVerticalPadding: s.padding?.top,
      minLeadingWidth: s.minWidth,
      minTileHeight: s.minHeight,
    );
  }

  /// Builds a [TabBarTheme] from this DACS class string.
  TabBarTheme dTabBar(BuildContext context) {
    final sheet = _sheet(this);
    final ctx = _context(context);
    final s = sheet.resolveWith(ctx);
    final st = materialStateFor(sheet, ctx);
    return TabBarTheme(
      labelColor: s.color,
      unselectedLabelColor: s.unselectedColor,
      indicatorColor: s.color,
      indicator: _shapeDecoration(s),
      labelStyle: s.toTextStyle(),
      unselectedLabelStyle: s.toTextStyle(),
      dividerColor: s.borderColor,
      dividerHeight: s.borderWidth,
      indicatorSize: s.tabIndicatorSize,
      labelPadding: s.padding,
      overlayColor:
          dacsStateOverrideOrBaseProp<Color>(st, (s) => s.overlayColor),
      splashFactory: s.splashFactory,
    );
  }

  /// Builds [BottomNavigationBarThemeData] from this DACS class string.
  BottomNavigationBarThemeData dBottomNav(BuildContext context) {
    return const DacsBottomNavigationBarAdapter()
        .build(_sheet(this), _context(context));
  }

  /// Builds an [InputDecoration] from this DACS class string.
  InputDecoration dInput(BuildContext context) =>
      const DacsInputDecorationAdapter().build(_sheet(this), _context(context));

  /// Builds an [InputDecoration] from this DACS class string.
  ///
  /// This is an explicit alias for [dInput] to pair naturally with
  /// `TextField.decoration`.
  InputDecoration dInputOf(BuildContext context) => dInput(context);

  /// Builds [ProgressIndicatorThemeData] from this DACS class string.
  ProgressIndicatorThemeData dProgress(BuildContext context) {
    final s = _resolve(this, context);
    return ProgressIndicatorThemeData(
      color: s.color,
      linearTrackColor: s.backgroundColor,
      circularTrackColor: s.backgroundColor,
      linearMinHeight: s.height,
      refreshBackgroundColor: s.backgroundColor,
      stopIndicatorColor: s.borderColor,
      stopIndicatorRadius: s.borderWidth,
    );
  }

  /// Builds [TooltipThemeData] from this DACS class string.
  TooltipThemeData dTooltip(BuildContext context) {
    final s = _resolve(this, context);
    return TooltipThemeData(
      decoration: s.toBoxDecoration(),
      textStyle: s.toTextStyle(),
      padding: s.padding,
      margin: s.margin,
      constraints: s.toConstraints(),
      preferBelow: s.tooltipPreferBelow,
      verticalOffset: s.insetTop,
      enableFeedback: s.enableFeedback,
      waitDuration: s.tooltipWaitDuration,
      showDuration: s.tooltipShowDuration,
      exitDuration: s.tooltipExitDuration,
    );
  }

  /// Builds [DividerThemeData] from this DACS class string.
  DividerThemeData dDivider(BuildContext context) {
    final s = _resolve(this, context);
    return DividerThemeData(
      color: s.color,
      thickness: s.borderWidth,
      space: s.height,
      indent: s.insetLeft,
      endIndent: s.insetRight,
    );
  }

  /// Builds [ScrollbarThemeData] from this DACS class string.
  ScrollbarThemeData dScrollbar(BuildContext context) {
    return const DacsScrollbarThemeAdapter()
        .build(_sheet(this), _context(context));
  }

  /// Builds [SnackBarThemeData] from this DACS class string.
  SnackBarThemeData dSnackBar(BuildContext context) {
    final s = _resolve(this, context);
    return SnackBarThemeData(
      backgroundColor: s.backgroundColor,
      contentTextStyle: s.toTextStyle(),
      shape: dacsShape(s),
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      actionTextColor: s.color,
      disabledActionTextColor: s.disabledActionColor,
      closeIconColor: s.color,
      insetPadding: s.margin,
      behavior: s.snackBehavior,
      showCloseIcon: s.snackShowCloseIcon,
    );
  }

  /// Builds a [DialogTheme] from this DACS class string.
  DialogTheme dDialog(BuildContext context) {
    final s = _resolve(this, context);
    return DialogTheme(
      backgroundColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.backgroundColor,
      shape: dacsShape(s),
      alignment: s.alignment,
      iconColor: s.color,
      titleTextStyle: s.toTextStyle(),
      contentTextStyle: s.toTextStyle(),
      actionsPadding: s.padding,
      barrierColor: s.barrierColor,
      insetPadding: s.margin,
      clipBehavior: s.overflow,
    );
  }

  /// Builds [BottomSheetThemeData] from this DACS class string.
  BottomSheetThemeData dBottomSheet(BuildContext context) {
    final s = _resolve(this, context);
    return BottomSheetThemeData(
      backgroundColor: s.backgroundColor,
      modalBackgroundColor: s.backgroundColor,
      modalBarrierColor: s.barrierColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      modalElevation: s.boxShadow?.firstOrNull?.blurRadius,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.backgroundColor,
      shape: dacsShape(s),
      clipBehavior: s.overflow,
      constraints: s.toConstraints(),
      dragHandleColor: s.color,
      dragHandleSize: s.toFixedSize(),
      showDragHandle: s.bottomSheetShowDragHandle,
    );
  }

  /// Builds [ExpansionTileThemeData] from this DACS class string.
  ExpansionTileThemeData dExpansionTile(BuildContext context) {
    final sheet = _sheet(this);
    final ctx = _context(context);
    final s = sheet.resolveWith(ctx);
    final st = materialStateFor(sheet, ctx);
    return ExpansionTileThemeData(
      backgroundColor: s.backgroundColor,
      collapsedBackgroundColor:
          st.variantOverrides['collapsed']?.backgroundColor,
      iconColor: s.color,
      textColor: s.color,
      shape: dacsShape(s),
      collapsedShape: dacsShape(s),
      tilePadding: s.padding,
      childrenPadding: s.margin,
      expandedAlignment: s.alignment,
      collapsedIconColor: st.variantOverrides['collapsed']?.color,
      collapsedTextColor: st.variantOverrides['collapsed']?.color,
      clipBehavior: s.overflow,
    );
  }

  /// Builds [NavigationBarThemeData] from this DACS class string.
  NavigationBarThemeData dNavBar(BuildContext context) =>
      const DacsNavigationBarAdapter().build(_sheet(this), _context(context));

  /// Builds [NavigationRailThemeData] from this DACS class string.
  NavigationRailThemeData dNavRail(BuildContext context) =>
      const DacsNavigationRailAdapter().build(_sheet(this), _context(context));

  /// Builds [FloatingActionButtonThemeData] from this DACS class string.
  FloatingActionButtonThemeData dFab(BuildContext context) {
    final sheet = _sheet(this);
    final ctx = _context(context);
    final s = sheet.resolveWith(ctx);
    final st = materialStateFor(sheet, ctx);
    return FloatingActionButtonThemeData(
      backgroundColor: s.backgroundColor,
      foregroundColor: s.color,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: dacsShape(s),
      focusColor: st.variantOverrides['focus']?.backgroundColor,
      hoverColor: st.variantOverrides['hover']?.backgroundColor,
      splashColor: st.variantOverrides['pressed']?.backgroundColor ??
          st.variantOverrides['active']?.backgroundColor,
      highlightElevation:
          (st.variantOverrides['pressed'] ?? st.variantOverrides['active'])
              ?.boxShadow
              ?.firstOrNull
              ?.blurRadius,
      focusElevation:
          st.variantOverrides['focus']?.boxShadow?.firstOrNull?.blurRadius,
      hoverElevation:
          st.variantOverrides['hover']?.boxShadow?.firstOrNull?.blurRadius,
      disabledElevation:
          st.variantOverrides['disabled']?.boxShadow?.firstOrNull?.blurRadius,
      extendedPadding: s.padding,
      extendedTextStyle: s.toTextStyle(),
      sizeConstraints: s.toConstraints(),
      smallSizeConstraints: st.variantOverrides['small']?.toConstraints(),
      largeSizeConstraints: st.variantOverrides['large']?.toConstraints(),
      extendedSizeConstraints: st.variantOverrides['extended']?.toConstraints(),
      iconSize: s.fontSize ?? s.width,
    );
  }

  /// Builds [DataTableThemeData] from this DACS class string.
  DataTableThemeData dDataTable(BuildContext context) =>
      const DacsDataTableAdapter().build(_sheet(this), _context(context));

  /// Builds [SearchBarThemeData] from this DACS class string.
  SearchBarThemeData dSearchBar(BuildContext context) {
    return const DacsSearchBarThemeAdapter()
        .build(_sheet(this), _context(context));
  }

  /// Builds a [MenuStyle] from this DACS class string.
  MenuStyle dMenu(BuildContext context) =>
      const DacsMenuStyleAdapter().build(_sheet(this), _context(context));

  /// Builds [PopupMenuThemeData] from this DACS class string.
  PopupMenuThemeData dPopupMenu(BuildContext context) =>
      const DacsPopupMenuThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [DropdownMenuThemeData] from this DACS class string.
  DropdownMenuThemeData dDropdownMenu(BuildContext context) =>
      const DacsDropdownMenuThemeAdapter()
          .build(_sheet(this), _context(context));

  /// Builds [DatePickerThemeData] from this DACS class string.
  DatePickerThemeData dDatePicker(BuildContext context) =>
      const DacsDatePickerThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [TimePickerThemeData] from this DACS class string.
  TimePickerThemeData dTimePicker(BuildContext context) =>
      const DacsTimePickerThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [SliderThemeData] from this DACS class string.
  SliderThemeData dSlider(BuildContext context) =>
      const DacsSliderThemeAdapter().build(_sheet(this), _context(context));

  /// Builds [IconThemeData] from this DACS class string.
  IconThemeData dIcon(BuildContext context) {
    final s = _resolve(this, context);
    return IconThemeData(
      color: s.color,
      size: s.width,
      opacity: s.opacity ?? 1.0,
      shadows: s.boxShadow,
      fill: s.iconFill,
      weight: s.iconWeight,
      grade: s.iconGrade,
      opticalSize: s.iconOpticalSize,
    );
  }

  /// Builds a [ShapeDecoration] from this DACS class string.
  ShapeDecoration dShape(BuildContext context) {
    final s = _resolve(this, context);
    return ShapeDecoration(
      color: s.backgroundColor,
      image: s.decorationImage,
      gradient: s.toGradient(),
      shape: dacsShape(s) ?? RoundedRectangleBorder(),
      shadows: s.boxShadow,
    );
  }
}

Decoration? _shapeDecoration(DacsResolvedStyle style) {
  if (style.backgroundColor == null &&
      style.borderColor == null &&
      style.borderWidth == null &&
      style.borderRadius == null) {
    return null;
  }
  return ShapeDecoration(
    color: style.backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: style.borderRadius ?? BorderRadius.zero,
      side: dacsSide(style) ?? BorderSide.none,
    ),
  );
}
