// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../dacs_resolve_context.dart';
import '../dacs_resolved_style.dart';
import '../dacs_style.dart';
import '../dacs_style_sheet.dart';

class DacsStateRule {
  final Set<WidgetState> requiredStates;
  final DacsStyle style;

  const DacsStateRule(this.requiredStates, this.style);
}

class DacsMaterialState {
  final DacsStyle base;
  final Map<String, DacsStyle> variants;
  final List<DacsStateRule> compoundVariants;

  const DacsMaterialState(this.base, this.variants, this.compoundVariants);
}

DacsMaterialState materialStateFor(
  DacsStyleSheet sheet,
  DacsResolveContext context,
) {
  final resolved = sheet.resolveWith(context);
  final base = resolved.toMutableStyle();
  final buildContext = context.buildContext;
  final variants = <String, DacsStyle>{};
  final compoundVariants = <DacsStateRule>[];

  if (resolved.variants != null) {
    for (final entry in resolved.variants!.entries) {
      final key = entry.key;
      final variantStyle = entry.value;
      final merged = resolved.toMutableStyle();

      if (variantStyle.bgThemeColor != null) merged.backgroundColor = null;
      if (variantStyle.textThemeColor != null) merged.color = null;
      if (variantStyle.borderThemeColor != null) merged.borderColor = null;
      if (variantStyle.decorationThemeColor != null) {
        merged.textDecorationColor = null;
      }
      if (variantStyle.gradientFromThemeColor != null) {
        merged.gradientFromColor = null;
      }
      if (variantStyle.gradientViaThemeColor != null) {
        merged.gradientViaColor = null;
      }
      if (variantStyle.gradientToThemeColor != null) {
        merged.gradientToColor = null;
      }

      merged.mergeFrom(variantStyle);
      if (buildContext != null) merged.resolveThemeColors(buildContext);

      final parts = key.split(':');
      if (parts.length > 1) {
        final states = parts.map(widgetStateForName).toSet();
        compoundVariants.add(DacsStateRule(states, merged));
      } else {
        variants[key] = merged;
      }
    }
  }

  return DacsMaterialState(base, variants, compoundVariants);
}

WidgetState widgetStateForName(String name) => switch (name) {
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

BorderSide? dacsSide(Object style) {
  final s = _asStyle(style);
  if (s.borderColor == null && s.borderWidth == null) return null;
  return BorderSide(
    color: s.borderColor ?? const Color(0xFF000000),
    width: s.borderWidth ?? 1.0,
  );
}

OutlinedBorder? dacsShape(Object style) {
  final s = _asStyle(style);
  if (s.borderRadius == null) return null;
  return RoundedRectangleBorder(borderRadius: s.borderRadius!);
}

OutlineInputBorder? dacsOutline(Object style) {
  final s = _asStyle(style);
  if (s.borderColor == null && s.borderWidth == null) return null;
  return OutlineInputBorder(
    borderSide: dacsSide(s) ?? BorderSide.none,
    borderRadius: s.borderRadius is BorderRadius
        ? (s.borderRadius as BorderRadius)
        : BorderRadius.zero,
  );
}

DacsStyle _asStyle(Object style) {
  return switch (style) {
    DacsStyle s => s,
    DacsResolvedStyle s => s.toMutableStyle(),
    _ => throw ArgumentError.value(style, 'style', 'Expected a DACS style'),
  };
}

WidgetStateProperty<T> dacsStateProp<T>(
  DacsMaterialState st,
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
