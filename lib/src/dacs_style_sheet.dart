import 'package:flutter/material.dart';
import 'dacs_conditional_rule.dart';
import 'dacs_resolve_context.dart';
import 'dacs_resolved_style.dart';
import 'dacs_style.dart';

/// Parsed result of a DACS class string.
///
/// A stylesheet is context-free parser output. It keeps unconditional values in
/// [base] and conditional overrides in [rules]. Call [resolve], [resolveWith],
/// or [resolveFor] before adapting conditional values into Flutter objects.
class DacsStyleSheet {
  /// The style values that apply without conditions.
  final DacsStyle base;

  /// Conditional parser rules in original source order.
  final List<DacsConditionalRule> rules;

  /// Utility tokens that were not recognized during compilation.
  final List<String> unknownUtilities;

  /// Creates a stylesheet from a [base] style and conditional [rules].
  DacsStyleSheet(
    this.base, [
    Iterable<DacsConditionalRule> rules = const [],
    Iterable<String> unknownUtilities = const [],
  ])  : rules = List.unmodifiable(rules),
        unknownUtilities = List.unmodifiable(unknownUtilities);

  /// Resolves this stylesheet against [brightness] and [screenWidth].
  ///
  /// Unconditional values are cloned from [base]. Matching non-state rules are
  /// merged into the result in source order, preserving "last class wins".
  /// Matching compound rules that still contain widget-state conditions are
  /// remapped into [DacsStyle.variants] for Material state adapters.
  DacsResolvedStyle resolve({Brightness? brightness, double? screenWidth}) {
    if (rules.isEmpty) return DacsResolvedStyle(base);
    final result = base.clone();
    final orderedRules = [...rules]
      ..sort((a, b) => a.sourceOrder.compareTo(b.sourceOrder));

    for (final rule in orderedRules) {
      final wsConditions = rule.widgetStateConditions;
      final nonWsConditions = rule.nonWidgetStateConditions;
      final allNonWsMatch = nonWsConditions.every(
        (condition) => condition.matches(
          brightness: brightness,
          screenWidth: screenWidth,
        ),
      );

      if (!allNonWsMatch) continue;

      if (wsConditions.isEmpty) {
        _mergeRule(rule, result);
      } else {
        final key = wsConditions.map((condition) => condition.name).join(':');
        result.variants ??= {};
        result.variants!.putIfAbsent(key, DacsStyle.new).mergeFrom(rule.style);
      }
    }

    return DacsResolvedStyle(result);
  }

  /// Resolves using an explicit [DacsResolveContext].
  DacsResolvedStyle resolveWith(DacsResolveContext context) {
    final result = resolve(
      brightness: context.brightness,
      screenWidth: context.screenWidth,
    );
    final buildContext = context.buildContext;
    if (buildContext != null) {
      final themed = result.toMutableStyle()..resolveThemeColors(buildContext);
      return DacsResolvedStyle(themed);
    }
    return result;
  }

  /// Resolves using [MediaQuery] and [Theme] values from [context].
  DacsResolvedStyle resolveFor(BuildContext context) {
    return resolveWith(DacsResolveContext.fromBuildContext(context));
  }

  void _mergeRule(DacsConditionalRule rule, DacsStyle target) {
    if (target.isImportant) return;
    target.mergeFrom(rule.style);
  }
}

/// Splits a compound variant key into individual conditions.
List<String> splitVariantKey(String key) => key.split(':');
