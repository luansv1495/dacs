import 'package:flutter/material.dart';
import '../dacs_style.dart';
import '../parsers/class_parser.dart';
import '../tokens/variants.dart';

DacsStyle _resolve(String input, BuildContext context) =>
    ClassParser().parse(input).resolveFor(context);

_BState _state(String input, BuildContext context) {
  final parsed = ClassParser().parse(input);
  final brightness = MediaQuery.of(context).platformBrightness;
  final screenWidth = MediaQuery.of(context).size.width;
  final base = parsed.resolve(brightness: brightness, screenWidth: screenWidth);
  base.resolveThemeColors(context);
  final variants = <String, DacsStyle>{};
  final compoundVariants = <DacsStateRule>[];
  if (parsed.variants != null) {
    for (final k in parsed.variants!.keys) {
      final v = parsed.variants![k]!;
      if (k.contains(':')) {
        _addCompoundVariant(
          k,
          v,
          base,
          variants,
          compoundVariants,
          brightness,
          screenWidth,
          context,
        );
      } else {
        final merged = base.clone();
        merged.mergeFrom(v);
        merged.resolveThemeColors(context);
        variants[k] = merged;
      }
    }
  }
  return _BState(base, variants, compoundVariants);
}

class DacsStateRule {
  final Set<WidgetState> requiredStates;
  final DacsStyle style;
  const DacsStateRule(this.requiredStates, this.style);
}

void _addCompoundVariant(
  String key,
  DacsStyle v,
  DacsStyle base,
  Map<String, DacsStyle> variants,
  List<DacsStateRule> compoundVariants,
  Brightness brightness,
  double screenWidth,
  BuildContext context,
) {
  final conditions = splitVariantKey(key);
  bool allMatch = true;
  final stateParts = <String>[];
  for (final c in conditions) {
    if (c == 'dark') {
      if (brightness != Brightness.dark) allMatch = false;
    } else if (c == 'light') {
      if (brightness != Brightness.light) allMatch = false;
    } else if (dacsBreakpoints.containsKey(c)) {
      if (screenWidth < (dacsBreakpoints[c] ?? 0)) allMatch = false;
    } else {
      stateParts.add(c);
    }
  }
  if (!allMatch) return;
  if (stateParts.isEmpty) {
    base.mergeFrom(v);
    base.resolveThemeColors(context);
  } else {
    final merged = base.clone();
    merged.mergeFrom(v);
    if (v.bgThemeColor != null) merged.backgroundColor = null;
    if (v.textThemeColor != null) merged.color = null;
    if (v.borderThemeColor != null) merged.borderColor = null;
    if (v.decorationThemeColor != null) merged.textDecorationColor = null;
    if (v.gradientFromThemeColor != null) merged.gradientFromColor = null;
    if (v.gradientViaThemeColor != null) merged.gradientViaColor = null;
    if (v.gradientToThemeColor != null) merged.gradientToColor = null;
    merged.resolveThemeColors(context);
    if (stateParts.length == 1) {
      variants[stateParts.first] = merged;
    } else {
      final states = stateParts.map(_widgetState).toSet();
      compoundVariants.add(DacsStateRule(states, merged));
    }
  }
}

WidgetState _widgetState(String name) => switch (name) {
      'hover' => WidgetState.hovered,
      'focus' => WidgetState.focused,
      'active' || 'pressed' => WidgetState.pressed,
      'disabled' => WidgetState.disabled,
      'selected' => WidgetState.selected,
      'error' => WidgetState.error,
      'dragged' => WidgetState.dragged,
      'scrolledUnder' => WidgetState.scrolledUnder,
      _ => WidgetState.hovered,
    };

class _BState {
  final DacsStyle base;
  final Map<String, DacsStyle> variants;
  final List<DacsStateRule> compoundVariants;
  const _BState(this.base, this.variants, this.compoundVariants);
}

BorderSide? _side(DacsStyle s) => s.borderColor != null || s.borderWidth != null
    ? BorderSide(
        color: s.borderColor ?? const Color(0xFF000000),
        width: s.borderWidth ?? 1.0,
      )
    : null;

OutlinedBorder? _shape(DacsStyle s) => s.borderRadius != null
    ? RoundedRectangleBorder(borderRadius: s.borderRadius!)
    : null;

OutlineInputBorder? _outline(DacsStyle s) =>
    s.borderColor != null || s.borderWidth != null
        ? OutlineInputBorder(
            borderSide: _side(s) ?? BorderSide.none,
            borderRadius: s.borderRadius is BorderRadius
                ? (s.borderRadius as BorderRadius)
                : BorderRadius.zero,
          )
        : null;

WidgetStateProperty<T> _stateProp<T>(
  _BState st,
  T Function(DacsStyle) fallback, {
  T Function(DacsStyle)? hoverExtra,
  T Function(DacsStyle)? focusExtra,
  T Function(DacsStyle)? activeExtra,
  T Function(DacsStyle)? disabledExtra,
  T Function(DacsStyle)? selectedExtra,
  T Function(DacsStyle)? errorExtra,
  T Function(DacsStyle)? draggedExtra,
  T Function(DacsStyle)? scrolledUnderExtra,
}) {
  return WidgetStateProperty.resolveWith((states) {
    T? pick(String key, T Function(DacsStyle)? extra) {
      final v = st.variants[key];
      if (v == null) return null;
      final r = fallback(v);
      if (r != null) return r;
      return extra?.call(v);
    }

    T? fromRule(DacsStateRule rule, T Function(DacsStyle)? extra) {
      final r = fallback(rule.style);
      if (r != null) return r;
      return extra?.call(rule.style);
    }

    for (final rule in st.compoundVariants) {
      if (rule.requiredStates.every(states.contains)) {
        final r = fromRule(rule, null);
        if (r != null) return r;
      }
    }

    if (states.contains(WidgetState.disabled)) {
      final r = pick('disabled', disabledExtra);
      if (r != null) return r;
    }
    if (states.contains(WidgetState.selected)) {
      final r = pick('selected', selectedExtra);
      if (r != null) return r;
    }
    if (states.contains(WidgetState.error)) {
      final r = pick('error', errorExtra);
      if (r != null) return r;
    }
    if (states.contains(WidgetState.pressed)) {
      final r = pick('pressed', activeExtra) ?? pick('active', activeExtra);
      if (r != null) return r;
    }
    if (states.contains(WidgetState.dragged)) {
      final r = pick('dragged', draggedExtra);
      if (r != null) return r;
    }
    if (states.contains(WidgetState.hovered)) {
      final r = pick('hover', hoverExtra);
      if (r != null) return r;
    }
    if (states.contains(WidgetState.focused)) {
      final r = pick('focus', focusExtra);
      if (r != null) return r;
    }
    if (states.contains(WidgetState.scrolledUnder)) {
      final r = pick('scrolledUnder', scrolledUnderExtra);
      if (r != null) return r;
    }

    return fallback(st.base);
  });
}

/// Extension providing Material widget theme data constructors on [String].
///
/// Each method parses DACS utility classes into a Material theme data object
/// (e.g. [ButtonStyle], [CheckboxThemeData]) with full variant support
/// including dark/light mode, responsive breakpoints, WidgetState conditions,
/// and chained compound variants.
extension DacsWidgetExtensions on String {
  /// Parses this string into a [ButtonStyle] for use with
  /// [ElevatedButton], [TextButton], [OutlinedButton], etc.
  ///
  /// Supports all variant types including WidgetState conditions
  /// (hover, focus, active/disabled, pressed) and chained compound
  /// variants. Uses [WidgetStateProperty] for interactive properties
  /// (backgroundColor, foregroundColor, overlayColor, surfaceTintColor,
  /// iconColor, iconSize, shadowColor, minimumSize, fixedSize, maximumSize,
  /// padding, side, shape, elevation, mouseCursor).
  ButtonStyle dButton(BuildContext context) {
    final st = _state(this, context);
    return ButtonStyle(
      textStyle: _stateProp<TextStyle?>(st, (s) => s.toTextStyle()),
      backgroundColor: _stateProp<Color?>(st, (s) => s.backgroundColor),
      foregroundColor: _stateProp<Color?>(st, (s) => s.color),
      overlayColor: _stateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.backgroundColor?.withAlpha(26),
        focusExtra: (s) => s.backgroundColor?.withAlpha(26),
        activeExtra: (s) => s.backgroundColor?.withAlpha(52),
      ),
      shadowColor: _stateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.boxShadow?.firstOrNull?.color,
      ),
      surfaceTintColor: _stateProp<Color?>(st, (s) => s.backgroundColor),
      iconColor: _stateProp<Color?>(st, (s) => s.color),
      iconSize: _stateProp<double?>(st, (s) => s.fontSize),
      padding: _stateProp<EdgeInsets?>(st, (s) => s.padding),
      minimumSize: _stateProp<Size?>(
        st,
        (s) => s.width != null || s.height != null
            ? Size(s.width ?? 0, s.height ?? 0)
            : null,
      ),
      fixedSize: _stateProp<Size?>(
        st,
        (s) => s.width != null || s.height != null
            ? Size(s.width ?? 0, s.height ?? 0)
            : null,
      ),
      maximumSize: _stateProp<Size?>(
        st,
        (s) => s.width != null || s.height != null
            ? Size(s.width ?? double.infinity, s.height ?? double.infinity)
            : null,
      ),
      side: _stateProp<BorderSide?>(st, (s) => _side(s)),
      shape: _stateProp<OutlinedBorder?>(st, (s) => _shape(s)),
      elevation: _stateProp<double?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.boxShadow?.firstOrNull?.blurRadius,
      ),
      mouseCursor: _stateProp<MouseCursor?>(st, (_) => null),
    );
  }

  /// Parses this string into a [CheckboxThemeData].
  ///
  /// Supports WidgetState variants for fillColor, checkColor, overlayColor,
  /// and side.
  CheckboxThemeData dCheckbox(BuildContext context) {
    final st = _state(this, context);
    return CheckboxThemeData(
      fillColor: _stateProp<Color?>(
        st,
        (s) => s.backgroundColor,
        hoverExtra: (s) => s.backgroundColor?.withAlpha(26),
        focusExtra: (s) => s.backgroundColor?.withAlpha(26),
        activeExtra: (s) => s.backgroundColor?.withAlpha(52),
      ),
      checkColor: _stateProp<Color?>(st, (s) => s.color),
      overlayColor: _stateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.color?.withAlpha(26),
      ),
      side: _side(st.base),
      shape: _shape(st.base),
    );
  }

  /// Parses this string into a [SwitchThemeData].
  ///
  /// Supports WidgetState variants for thumbColor, trackColor,
  /// trackOutlineColor, and overlayColor.
  SwitchThemeData dSwitch(BuildContext context) {
    final st = _state(this, context);
    return SwitchThemeData(
      thumbColor: _stateProp<Color?>(
        st,
        (s) => s.backgroundColor,
        activeExtra: (s) => s.color,
      ),
      trackColor: _stateProp<Color?>(
        st,
        (s) => s.backgroundColor?.withAlpha(128),
      ),
      trackOutlineColor: _stateProp<Color?>(st, (s) => s.borderColor),
      overlayColor: _stateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.backgroundColor?.withAlpha(26),
      ),
    );
  }

  /// Parses this string into a [RadioThemeData].
  ///
  /// Supports WidgetState variants for fillColor and overlayColor.
  RadioThemeData dRadio(BuildContext context) {
    final st = _state(this, context);
    return RadioThemeData(
      fillColor: _stateProp<Color?>(
        st,
        (s) => s.backgroundColor,
        activeExtra: (s) => s.color,
      ),
      overlayColor: _stateProp<Color?>(
        st,
        (_) => null,
        hoverExtra: (s) => s.color?.withAlpha(26),
      ),
    );
  }

  /// Parses this string into a [ChipThemeData].
  ///
  /// Supports WidgetState variants for color (backgroundColor).
  ChipThemeData dChip(BuildContext context) {
    final st = _state(this, context);
    return ChipThemeData(
      color: _stateProp<WidgetStateColor?>(
        st,
        (s) => s.backgroundColor != null
            ? WidgetStateColor.resolveWith((_) => s.backgroundColor!)
            : null,
      ),
      shape: _shape(st.base),
      side: _side(st.base),
      padding: st.base.padding,
    );
  }

  /// Parses this string into an [AppBarTheme].
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

  /// Parses this string into a [CardTheme].
  CardTheme dCard(BuildContext context) {
    final s = _resolve(this, context);
    return CardTheme(
      color: s.backgroundColor,
      shadowColor: s.boxShadow?.firstOrNull?.color,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: _shape(s),
      margin: s.margin,
    );
  }

  /// Parses this string into a [ListTileThemeData].
  ListTileThemeData dListTile(BuildContext context) {
    final s = _resolve(this, context);
    return ListTileThemeData(
      tileColor: s.backgroundColor,
      textColor: s.color,
      iconColor: s.color,
      selectedColor: s.color,
      shape: _shape(s),
      contentPadding: s.padding,
    );
  }

  /// Parses this string into a [TabBarTheme].
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

  /// Parses this string into a [BottomNavigationBarThemeData].
  BottomNavigationBarThemeData dBottomNav(BuildContext context) {
    final s = _resolve(this, context);
    return BottomNavigationBarThemeData(
      backgroundColor: s.backgroundColor,
      selectedItemColor: s.color,
      unselectedItemColor: s.color?.withAlpha(128),
      selectedLabelStyle: s.toTextStyle(),
      unselectedLabelStyle: s.toTextStyle(),
    );
  }

  /// Parses this string into an [InputDecoration] for [TextField] /
  /// [TextFormField].
  ///
  /// Maps background color to `filled`/`fillColor`, border tokens to
  /// [OutlineInputBorder], and padding to `contentPadding`.
  InputDecoration dInput(BuildContext context) {
    final s = _resolve(this, context);
    return InputDecoration(
      filled: s.backgroundColor != null,
      fillColor: s.backgroundColor,
      border: _outline(s),
      enabledBorder: _outline(s),
      focusedBorder: s.borderColor != null || s.borderWidth != null
          ? OutlineInputBorder(
              borderSide: _side(s) ?? BorderSide.none,
              borderRadius: s.borderRadius is BorderRadius
                  ? (s.borderRadius as BorderRadius)
                  : BorderRadius.zero,
            )
          : null,
      contentPadding: s.padding,
    );
  }

  /// Parses this string into a [ProgressIndicatorThemeData].
  ProgressIndicatorThemeData dProgress(BuildContext context) {
    final s = _resolve(this, context);
    return ProgressIndicatorThemeData(
      color: s.color,
      linearTrackColor: s.backgroundColor,
      circularTrackColor: s.backgroundColor,
    );
  }

  /// Parses this string into a [TooltipThemeData].
  TooltipThemeData dTooltip(BuildContext context) {
    final s = _resolve(this, context);
    return TooltipThemeData(
      decoration: s.toBoxDecoration(),
      textStyle: s.toTextStyle(),
      padding: s.padding,
      margin: s.margin,
    );
  }

  /// Parses this string into a [DividerThemeData].
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

  /// Parses this string into a [ScrollbarThemeData].
  ///
  /// Supports WidgetState variants for thumbColor and trackColor.
  ScrollbarThemeData dScrollbar(BuildContext context) {
    final s = _resolve(this, context);
    return ScrollbarThemeData(
      thumbColor: _stateProp<Color?>(
        _state(this, context),
        (_) => null,
        hoverExtra: (s2) => s2.backgroundColor,
        activeExtra: (s2) => s2.color,
      ),
      trackColor: _stateProp<Color?>(
        _state(this, context),
        (_) => null,
        hoverExtra: (s2) => s2.backgroundColor?.withAlpha(51),
      ),
      radius: s.borderRadius is BorderRadius
          ? Radius.circular((s.borderRadius as BorderRadius).topLeft.x)
          : null,
      thickness:
          s.borderWidth != null ? WidgetStatePropertyAll(s.borderWidth) : null,
    );
  }

  /// Parses this string into a [SnackBarThemeData].
  SnackBarThemeData dSnackBar(BuildContext context) {
    final s = _resolve(this, context);
    return SnackBarThemeData(
      backgroundColor: s.backgroundColor,
      contentTextStyle: s.toTextStyle(),
      shape: _shape(s),
      behavior: SnackBarBehavior.floating,
    );
  }

  /// Parses this string into a [DialogTheme].
  DialogTheme dDialog(BuildContext context) {
    final s = _resolve(this, context);
    return DialogTheme(
      backgroundColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: _shape(s),
    );
  }

  /// Parses this string into a [BottomSheetThemeData].
  BottomSheetThemeData dBottomSheet(BuildContext context) {
    final s = _resolve(this, context);
    return BottomSheetThemeData(
      backgroundColor: s.backgroundColor,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: _shape(s),
    );
  }

  /// Parses this string into an [ExpansionTileThemeData].
  ExpansionTileThemeData dExpansionTile(BuildContext context) {
    final s = _resolve(this, context);
    return ExpansionTileThemeData(
      backgroundColor: s.backgroundColor,
      collapsedBackgroundColor: s.backgroundColor?.withAlpha(128),
      iconColor: s.color,
      textColor: s.color,
      shape: _shape(s),
      collapsedShape: _shape(s),
    );
  }

  /// Parses this string into a [NavigationBarThemeData].
  NavigationBarThemeData dNavBar(BuildContext context) {
    final s = _resolve(this, context);
    return NavigationBarThemeData(
      backgroundColor: s.backgroundColor,
      indicatorColor: s.color?.withAlpha(26),
      labelTextStyle: _stateProp<TextStyle?>(
        _state(this, context),
        (st) => st.toTextStyle(),
      ),
    );
  }

  /// Parses this string into a [FloatingActionButtonThemeData].
  FloatingActionButtonThemeData dFab(BuildContext context) {
    final s = _resolve(this, context);
    return FloatingActionButtonThemeData(
      backgroundColor: s.backgroundColor,
      foregroundColor: s.color,
      elevation: s.boxShadow?.firstOrNull?.blurRadius,
      shape: _shape(s),
    );
  }

  /// Parses this string into a [DataTableThemeData].
  ///
  /// Supports WidgetState variants for headingRowColor and dataRowColor.
  DataTableThemeData dDataTable(BuildContext context) {
    final s = _resolve(this, context);
    return DataTableThemeData(
      headingRowColor: _stateProp<Color?>(
        _state(this, context),
        (_) => null,
        hoverExtra: (s2) => s2.backgroundColor?.withAlpha(26),
      ),
      dataRowColor: _stateProp<Color?>(
        _state(this, context),
        (_) => null,
        hoverExtra: (s2) => s2.backgroundColor?.withAlpha(13),
      ),
      horizontalMargin: s.padding?.left,
      columnSpacing: s.padding?.right,
    );
  }

  /// Parses this string into a [SearchBarThemeData].
  ///
  /// Supports WidgetState variants for backgroundColor, elevation, textStyle,
  /// and hintStyle.
  SearchBarThemeData dSearchBar(BuildContext context) {
    final s = _resolve(this, context);
    return SearchBarThemeData(
      backgroundColor: _stateProp<Color?>(
        _state(this, context),
        (_) => null,
        hoverExtra: (s2) => s2.backgroundColor,
        focusExtra: (s2) => s2.backgroundColor,
      ),
      elevation: _stateProp<double?>(
        _state(this, context),
        (_) => null,
        hoverExtra: (s2) => s2.boxShadow?.firstOrNull?.blurRadius,
        focusExtra: (s2) => s2.boxShadow?.firstOrNull?.blurRadius,
      ),
      shape: _shape(s) != null ? WidgetStatePropertyAll(_shape(s)!) : null,
      textStyle: _stateProp<TextStyle?>(
        _state(this, context),
        (st) => st.toTextStyle(),
      ),
      hintStyle: _stateProp<TextStyle?>(
        _state(this, context),
        (st) => st.toTextStyle(),
      ),
    );
  }

  /// Parses this string into a [MenuStyle].
  ///
  /// Supports WidgetState variants for backgroundColor, elevation, and
  /// padding.
  MenuStyle dMenu(BuildContext context) {
    final s = _resolve(this, context);
    return MenuStyle(
      backgroundColor: _stateProp<Color?>(
        _state(this, context),
        (st) => st.backgroundColor,
      ),
      shape: _shape(s) != null ? WidgetStatePropertyAll(_shape(s)!) : null,
      elevation: _stateProp<double?>(
        _state(this, context),
        (_) => null,
        hoverExtra: (s2) => s2.boxShadow?.firstOrNull?.blurRadius,
      ),
      padding: _stateProp<EdgeInsets?>(
        _state(this, context),
        (st) => st.padding,
      ),
    );
  }

  /// Parses this string into an [IconThemeData].
  IconThemeData dIcon(BuildContext context) {
    final s = _resolve(this, context);
    return IconThemeData(
      color: s.color,
      size: s.width,
      opacity: s.opacity ?? 1.0,
    );
  }

  /// Parses this string into a [ShapeDecoration].
  ShapeDecoration dShape(BuildContext context) {
    final s = _resolve(this, context);
    return ShapeDecoration(
      color: s.backgroundColor,
      gradient: s.toGradient(),
      shape: _shape(s) ?? RoundedRectangleBorder(),
      shadows: s.boxShadow,
    );
  }
}
