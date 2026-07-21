import 'package:flutter/material.dart';
import '../adapters/button_style_adapter.dart';
import '../adapters/checkbox_theme_adapter.dart';
import '../adapters/chip_theme_adapter.dart';
import '../adapters/data_table_adapter.dart';
import '../adapters/input_decoration_adapter.dart';
import '../adapters/material_state.dart';
import '../adapters/menu_style_adapter.dart';
import '../adapters/navigation_bar_adapter.dart';
import '../adapters/scrollbar_theme_adapter.dart';
import '../adapters/search_bar_theme_adapter.dart';
import '../adapters/slider_theme_adapter.dart';
import '../adapters/switch_theme_adapter.dart';
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

  /// Builds an [AppBarTheme] from this DACS class string.
  AppBarTheme dAppBar(BuildContext context) {
    final s = _resolve(this, context);
    return AppBarTheme(
      backgroundColor: s.backgroundColor,
      foregroundColor: s.color,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      surfaceTintColor: s.backgroundColor,
    );
  }

  /// Builds a [CardTheme] from this DACS class string.
  CardTheme dCard(BuildContext context) {
    final s = _resolve(this, context);
    return CardTheme(
      color: s.backgroundColor,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: dacsShape(s),
      margin: s.margin,
    );
  }

  /// Builds [ListTileThemeData] from this DACS class string.
  ListTileThemeData dListTile(BuildContext context) {
    final s = _resolve(this, context);
    return ListTileThemeData(
      tileColor: s.backgroundColor,
      textColor: s.color,
      iconColor: s.color,
      selectedColor: s.color,
      shape: dacsShape(s),
      contentPadding: s.padding,
    );
  }

  /// Builds a [TabBarTheme] from this DACS class string.
  TabBarTheme dTabBar(BuildContext context) {
    final s = _resolve(this, context);
    return TabBarTheme(
      labelColor: s.color,
      unselectedLabelColor: s.color?.withAlpha(128),
      indicatorColor: s.color,
      labelStyle: s.toTextStyle(),
      unselectedLabelStyle: s.toTextStyle(),
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
      behavior: SnackBarBehavior.floating,
    );
  }

  /// Builds a [DialogTheme] from this DACS class string.
  DialogTheme dDialog(BuildContext context) {
    final s = _resolve(this, context);
    return DialogTheme(
      backgroundColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: dacsShape(s),
    );
  }

  /// Builds [BottomSheetThemeData] from this DACS class string.
  BottomSheetThemeData dBottomSheet(BuildContext context) {
    final s = _resolve(this, context);
    return BottomSheetThemeData(
      backgroundColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: dacsShape(s),
    );
  }

  /// Builds [ExpansionTileThemeData] from this DACS class string.
  ExpansionTileThemeData dExpansionTile(BuildContext context) {
    final s = _resolve(this, context);
    return ExpansionTileThemeData(
      backgroundColor: s.backgroundColor,
      collapsedBackgroundColor: s.backgroundColor?.withAlpha(128),
      iconColor: s.color,
      textColor: s.color,
      shape: dacsShape(s),
      collapsedShape: dacsShape(s),
    );
  }

  /// Builds [NavigationBarThemeData] from this DACS class string.
  NavigationBarThemeData dNavBar(BuildContext context) =>
      const DacsNavigationBarAdapter().build(_sheet(this), _context(context));

  /// Builds [FloatingActionButtonThemeData] from this DACS class string.
  FloatingActionButtonThemeData dFab(BuildContext context) {
    final s = _resolve(this, context);
    return FloatingActionButtonThemeData(
      backgroundColor: s.backgroundColor,
      foregroundColor: s.color,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: dacsShape(s),
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
    );
  }

  /// Builds a [ShapeDecoration] from this DACS class string.
  ShapeDecoration dShape(BuildContext context) {
    final s = _resolve(this, context);
    return ShapeDecoration(
      color: s.backgroundColor,
      gradient: s.toGradient(),
      shape: dacsShape(s) ?? RoundedRectangleBorder(),
      shadows: s.boxShadow,
    );
  }
}
