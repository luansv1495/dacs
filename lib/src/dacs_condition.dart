import 'package:flutter/material.dart';
import 'tokens/variants.dart' show dacsBreakpoints;

/// A parsed condition that controls when a DACS rule applies.
///
/// Conditions can represent brightness (`dark:`/`light:`), responsive
/// breakpoints (`md:`), widget states (`hover:`), or a compound combination
/// such as `dark:md:hover:`.
class DacsCondition {
  /// Required platform brightness, or `null` when brightness is not constrained.
  final Brightness? brightness;

  /// Minimum screen width for responsive variants, or `null`.
  final double? minWidth;

  /// Widget states required for this condition to match.
  final Set<WidgetState> requiredStates;

  /// Original variant names that produced this condition.
  final List<String> names;

  /// Creates a condition from a single variant [name].
  DacsCondition(
    String name, {
    Brightness? brightness,
    double? minWidth,
    Set<WidgetState> requiredStates = const {},
  }) : this.fromParts(
          [name],
          brightness: brightness,
          minWidth: minWidth,
          requiredStates: requiredStates,
        );

  /// Creates a condition from explicit parsed parts.
  DacsCondition.fromParts(
    this.names, {
    this.brightness,
    this.minWidth,
    this.requiredStates = const {},
  });

  /// Creates a condition from one DACS variant prefix.
  factory DacsCondition.fromPrefix(String prefix) {
    if (prefix == 'dark') {
      return DacsCondition(prefix, brightness: Brightness.dark);
    }
    if (prefix == 'light') {
      return DacsCondition(prefix, brightness: Brightness.light);
    }
    final breakpoint = dacsBreakpoints[prefix];
    if (breakpoint != null) {
      return DacsCondition(prefix, minWidth: breakpoint);
    }
    return DacsCondition(prefix, requiredStates: {_widgetState(prefix)});
  }

  /// Creates a compound condition from ordered DACS variant [prefixes].
  factory DacsCondition.fromPrefixes(List<String> prefixes) {
    Brightness? brightness;
    double? minWidth;
    final requiredStates = <WidgetState>{};

    for (final prefix in prefixes) {
      final condition = DacsCondition.fromPrefix(prefix);
      brightness ??= condition.brightness;
      if (condition.minWidth != null) {
        minWidth = minWidth == null
            ? condition.minWidth
            : (condition.minWidth! > minWidth ? condition.minWidth : minWidth);
      }
      requiredStates.addAll(condition.requiredStates);
    }

    return DacsCondition.fromParts(
      List.unmodifiable(prefixes),
      brightness: brightness,
      minWidth: minWidth,
      requiredStates: Set.unmodifiable(requiredStates),
    );
  }

  /// The original condition key, for example `dark:md:hover`.
  String get name => names.join(':');

  /// Returns whether this condition matches the supplied environment.
  bool matches({Brightness? brightness, double? screenWidth}) {
    return matchesEnvironment(brightness: brightness, screenWidth: screenWidth);
  }

  /// Returns whether brightness and width constraints match.
  bool matchesEnvironment({Brightness? brightness, double? screenWidth}) {
    if (this.brightness != null && brightness != this.brightness) return false;
    if (minWidth != null) {
      if (screenWidth == null) return false;
      if (screenWidth < minWidth!) return false;
    }
    return true;
  }

  /// Splits a compound condition into one condition per original prefix.
  List<DacsCondition> get atomicConditions =>
      names.map(DacsCondition.fromPrefix).toList(growable: false);

  /// Whether this condition is only a widget state condition.
  bool get isWidgetState =>
      brightness == null && minWidth == null && requiredStates.isNotEmpty;

  /// Whether this condition contains a responsive breakpoint.
  bool get isResponsive => minWidth != null;

  /// Whether this condition contains a brightness constraint.
  bool get isBrightnessCondition => brightness != null;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is DacsCondition && name == other.name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'DacsCondition($name)';
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
