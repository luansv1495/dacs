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
  final Map<String, DacsStyle> variantOverrides;
  final List<DacsStateRule> compoundVariants;
  final List<DacsStateRule> compoundVariantOverrides;

  const DacsMaterialState(
    this.base,
    this.variants,
    this.variantOverrides,
    this.compoundVariants,
    this.compoundVariantOverrides,
  );
}

DacsMaterialState materialStateFor(
  DacsStyleSheet sheet,
  DacsResolveContext context,
) {
  final resolved = sheet.resolveWith(context);
  final base = resolved.toMutableStyle();
  final buildContext = context.buildContext;
  final variants = <String, DacsStyle>{};
  final variantOverrides = <String, DacsStyle>{};
  final compoundVariants = <DacsStateRule>[];
  final compoundVariantOverrides = <DacsStateRule>[];

  if (resolved.variants != null) {
    for (final entry in resolved.variants!.entries) {
      final key = entry.key;
      final variantStyle = entry.value;
      final merged = resolved.toMutableStyle();
      final override = variantStyle.clone();

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
      if (variantStyle.overlayThemeColor != null) merged.overlayColor = null;
      if (variantStyle.indicatorThemeColor != null) {
        merged.indicatorColor = null;
      }
      if (variantStyle.barrierThemeColor != null) merged.barrierColor = null;
      if (variantStyle.unselectedThemeColor != null) {
        merged.unselectedColor = null;
      }
      if (variantStyle.disabledActionThemeColor != null) {
        merged.disabledActionColor = null;
      }

      merged.mergeFrom(variantStyle);
      if (buildContext != null) {
        merged.resolveThemeColors(buildContext);
        override.resolveThemeColors(buildContext);
      }

      final parts = key.split(':');
      if (parts.length > 1) {
        final states = parts.map(widgetStateForName).toSet();
        compoundVariants.add(DacsStateRule(states, merged));
        compoundVariantOverrides.add(DacsStateRule(states, override));
      } else {
        variants[key] = merged;
        variantOverrides[key] = override;
      }
    }
  }

  return DacsMaterialState(
    base,
    variants,
    variantOverrides,
    compoundVariants,
    compoundVariantOverrides,
  );
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
  T Function(DacsStyle) fallback,
) {
  return WidgetStateProperty.resolveWith((states) {
    T? pick(String key) {
      final v = st.variants[key];
      if (v == null) return null;
      return fallback(v);
    }

    T? fromRule(DacsStateRule rule) => fallback(rule.style);

    for (final rule in st.compoundVariants) {
      if (rule.requiredStates.every(states.contains)) {
        final r = fromRule(rule);
        if (r != null) return r;
      }
    }

    if (states.contains(WidgetState.disabled)) {
      final r = pick('disabled');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.selected)) {
      final r = pick('selected');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.error)) {
      final r = pick('error');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.pressed)) {
      final r = pick('pressed') ?? pick('active');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.dragged)) {
      final r = pick('dragged');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.hovered)) {
      final r = pick('hover');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.focused)) {
      final r = pick('focus');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.scrolledUnder)) {
      final r = pick('scrolledUnder');
      if (r != null) return r;
    }

    return fallback(st.base);
  });
}

WidgetStateProperty<T?> dacsStateOverrideProp<T>(
  DacsMaterialState st,
  T? Function(DacsStyle) getter,
) {
  return WidgetStateProperty.resolveWith((states) {
    T? pick(String key) {
      final v = st.variantOverrides[key];
      if (v == null) return null;
      return getter(v);
    }

    for (final rule in st.compoundVariantOverrides) {
      if (rule.requiredStates.every(states.contains)) {
        final r = getter(rule.style);
        if (r != null) return r;
      }
    }

    if (states.contains(WidgetState.disabled)) {
      final r = pick('disabled');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.selected)) {
      final r = pick('selected');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.error)) {
      final r = pick('error');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.pressed)) {
      final r = pick('pressed') ?? pick('active');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.dragged)) {
      final r = pick('dragged');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.hovered)) {
      final r = pick('hover');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.focused)) {
      final r = pick('focus');
      if (r != null) return r;
    }
    if (states.contains(WidgetState.scrolledUnder)) {
      final r = pick('scrolledUnder');
      if (r != null) return r;
    }

    return null;
  });
}

WidgetStateProperty<T?>? dacsStateOverrideOrBaseProp<T>(
  DacsMaterialState st,
  T? Function(DacsStyle) getter,
) {
  final hasValue = getter(st.base) != null ||
      st.variantOverrides.values.any((style) => getter(style) != null) ||
      st.compoundVariantOverrides.any((rule) => getter(rule.style) != null);
  if (!hasValue) return null;

  return WidgetStateProperty.resolveWith((states) {
    final explicit = dacsStateOverrideProp<T>(st, getter).resolve(states);
    return explicit ?? getter(st.base);
  });
}

DacsStyle dacsStyleForStates(DacsMaterialState st, Set<WidgetState> states) {
  for (final rule in st.compoundVariants) {
    if (rule.requiredStates.every(states.contains)) return rule.style;
  }
  if (states.contains(WidgetState.disabled) &&
      st.variants.containsKey('disabled')) {
    return st.variants['disabled']!;
  }
  if (states.contains(WidgetState.selected) &&
      st.variants.containsKey('selected')) {
    return st.variants['selected']!;
  }
  if (states.contains(WidgetState.error) && st.variants.containsKey('error')) {
    return st.variants['error']!;
  }
  if (states.contains(WidgetState.pressed)) {
    return st.variants['pressed'] ?? st.variants['active'] ?? st.base;
  }
  if (states.contains(WidgetState.dragged) &&
      st.variants.containsKey('dragged')) {
    return st.variants['dragged']!;
  }
  if (states.contains(WidgetState.hovered) &&
      st.variants.containsKey('hover')) {
    return st.variants['hover']!;
  }
  if (states.contains(WidgetState.focused) &&
      st.variants.containsKey('focus')) {
    return st.variants['focus']!;
  }
  if (states.contains(WidgetState.scrolledUnder) &&
      st.variants.containsKey('scrolledUnder')) {
    return st.variants['scrolledUnder']!;
  }
  return st.base;
}
