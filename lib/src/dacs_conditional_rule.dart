import 'package:flutter/widgets.dart';
import 'dacs_condition.dart';
import 'dacs_style.dart';

/// A style rule that applies only when its [condition] matches.
class DacsConditionalRule {
  /// The condition required for this rule to apply.
  final DacsCondition condition;

  /// The style values contributed by this rule.
  final DacsStyle style;

  /// The position of this rule in the source class string.
  final int sourceOrder;

  /// Field names marked important for this rule, when applicable.
  final Set<String>? importantFields;

  /// Creates a conditional style rule.
  DacsConditionalRule({
    required this.condition,
    required this.style,
    required this.sourceOrder,
    this.importantFields,
  });

  /// The atomic conditions that make up [condition].
  List<DacsCondition> get conditions => condition.atomicConditions;

  /// Whether any field in this rule is marked important.
  bool get isImportant =>
      importantFields != null && importantFields!.isNotEmpty;

  /// Returns whether this rule matches the supplied brightness and width.
  bool matches({Brightness? brightness, double? screenWidth}) {
    return condition.matches(brightness: brightness, screenWidth: screenWidth);
  }

  /// Conditions that depend on [WidgetState].
  List<DacsCondition> get widgetStateConditions =>
      conditions.where((c) => c.isWidgetState).toList();

  /// Conditions that depend on environment rather than [WidgetState].
  List<DacsCondition> get nonWidgetStateConditions =>
      conditions.where((c) => !c.isWidgetState).toList();

  /// Whether every atomic condition is a widget state condition.
  bool get allWidgetState => conditions.every((c) => c.isWidgetState);

  @override
  String toString() => 'DacsConditionalRule(${condition.name})';
}
