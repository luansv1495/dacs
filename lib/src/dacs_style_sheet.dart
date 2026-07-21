// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'dacs_style.dart';
import 'dacs_conditional_rule.dart';
import 'dacs_layout_style.dart';
import 'dacs_resolve_context.dart';

/// Parsed result of a DACS class string, separating the base style from
/// conditional rules (dark mode, responsive, widget state, etc.).
///
/// Forwards all style property access to [base] so it can be used
/// transparently in place of a [DacsStyle]. Conditional overrides are kept as
/// internal parser output and can be resolved via [resolve] or [resolveFor].
class DacsStyleSheet {
  /// The base style values (no conditions applied).
  final DacsStyle base;

  final List<DacsConditionalRule> _rules;

  /// Utility tokens that were not recognized during compilation.
  final List<String> unknownUtilities;

  /// Creates a stylesheet from an unconditional [base] style and conditional
  /// parser rules.
  DacsStyleSheet(
    this.base, [
    Iterable<Object> rules = const [],
    Iterable<String> unknownUtilities = const [],
  ])  : _rules = rules.cast<DacsConditionalRule>().toList(growable: false),
        unknownUtilities = List.unmodifiable(unknownUtilities);

  // ── Backward-compatible property forwarding ──

  double? get fontSize => base.fontSize;
  set fontSize(double? v) {
    base.fontSize = v;
  }

  FontWeight? get fontWeight => base.fontWeight;
  set fontWeight(FontWeight? v) {
    base.fontWeight = v;
  }

  Color? get color => base.color;
  set color(Color? v) {
    base.color = v;
  }

  Color? get backgroundColor => base.backgroundColor;
  set backgroundColor(Color? v) {
    base.backgroundColor = v;
  }

  Color? get borderColor => base.borderColor;
  set borderColor(Color? v) {
    base.borderColor = v;
  }

  double? get borderWidth => base.borderWidth;
  set borderWidth(double? v) {
    base.borderWidth = v;
  }

  EdgeInsets? get padding => base.padding;
  set padding(EdgeInsets? v) {
    base.padding = v;
  }

  EdgeInsets? get margin => base.margin;
  set margin(EdgeInsets? v) {
    base.margin = v;
  }

  BorderRadiusGeometry? get borderRadius => base.borderRadius;
  set borderRadius(BorderRadiusGeometry? v) {
    base.borderRadius = v;
  }

  double? get width => base.width;
  set width(double? v) {
    base.width = v;
  }

  double? get height => base.height;
  set height(double? v) {
    base.height = v;
  }

  double? get opacity => base.opacity;
  set opacity(double? v) {
    base.opacity = v;
  }

  FontStyle? get fontStyle => base.fontStyle;
  set fontStyle(FontStyle? v) {
    base.fontStyle = v;
  }

  TextDecoration? get textDecoration => base.textDecoration;
  set textDecoration(TextDecoration? v) {
    base.textDecoration = v;
  }

  Color? get textDecorationColor => base.textDecorationColor;
  set textDecorationColor(Color? v) {
    base.textDecorationColor = v;
  }

  TextDecorationStyle? get textDecorationStyle => base.textDecorationStyle;
  set textDecorationStyle(TextDecorationStyle? v) {
    base.textDecorationStyle = v;
  }

  double? get textDecorationThickness => base.textDecorationThickness;
  set textDecorationThickness(double? v) {
    base.textDecorationThickness = v;
  }

  double? get letterSpacing => base.letterSpacing;
  set letterSpacing(double? v) {
    base.letterSpacing = v;
  }

  double? get lineHeight => base.lineHeight;
  set lineHeight(double? v) {
    base.lineHeight = v;
  }

  List<BoxShadow>? get boxShadow => base.boxShadow;
  set boxShadow(List<BoxShadow>? v) {
    base.boxShadow = v;
  }

  double? get insetTop => base.insetTop;
  set insetTop(double? v) {
    base.insetTop = v;
  }

  double? get insetRight => base.insetRight;
  set insetRight(double? v) {
    base.insetRight = v;
  }

  double? get insetBottom => base.insetBottom;
  set insetBottom(double? v) {
    base.insetBottom = v;
  }

  double? get insetLeft => base.insetLeft;
  set insetLeft(double? v) {
    base.insetLeft = v;
  }

  double? get scaleX => base.scaleX;
  set scaleX(double? v) {
    base.scaleX = v;
  }

  double? get scaleY => base.scaleY;
  set scaleY(double? v) {
    base.scaleY = v;
  }

  double? get rotateDegrees => base.rotateDegrees;
  set rotateDegrees(double? v) {
    base.rotateDegrees = v;
  }

  double? get translateX => base.translateX;
  set translateX(double? v) {
    base.translateX = v;
  }

  double? get translateY => base.translateY;
  set translateY(double? v) {
    base.translateY = v;
  }

  double? get skewX => base.skewX;
  set skewX(double? v) {
    base.skewX = v;
  }

  double? get skewY => base.skewY;
  set skewY(double? v) {
    base.skewY = v;
  }

  DacsGradientDirection? get gradientDirection => base.gradientDirection;
  set gradientDirection(DacsGradientDirection? v) {
    base.gradientDirection = v;
  }

  Color? get gradientFromColor => base.gradientFromColor;
  set gradientFromColor(Color? v) {
    base.gradientFromColor = v;
  }

  Color? get gradientViaColor => base.gradientViaColor;
  set gradientViaColor(Color? v) {
    base.gradientViaColor = v;
  }

  Color? get gradientToColor => base.gradientToColor;
  set gradientToColor(Color? v) {
    base.gradientToColor = v;
  }

  String? get textThemeColor => base.textThemeColor;
  set textThemeColor(String? v) {
    base.textThemeColor = v;
  }

  String? get bgThemeColor => base.bgThemeColor;
  set bgThemeColor(String? v) {
    base.bgThemeColor = v;
  }

  String? get borderThemeColor => base.borderThemeColor;
  set borderThemeColor(String? v) {
    base.borderThemeColor = v;
  }

  String? get decorationThemeColor => base.decorationThemeColor;
  set decorationThemeColor(String? v) {
    base.decorationThemeColor = v;
  }

  String? get gradientFromThemeColor => base.gradientFromThemeColor;
  set gradientFromThemeColor(String? v) {
    base.gradientFromThemeColor = v;
  }

  String? get gradientViaThemeColor => base.gradientViaThemeColor;
  set gradientViaThemeColor(String? v) {
    base.gradientViaThemeColor = v;
  }

  String? get gradientToThemeColor => base.gradientToThemeColor;
  set gradientToThemeColor(String? v) {
    base.gradientToThemeColor = v;
  }

  double? get gap => base.gap;
  set gap(double? v) {
    base.gap = v;
  }

  int? get flex => base.flex;
  set flex(int? v) {
    base.flex = v;
  }

  Axis? get flexDirection => base.flexDirection;
  set flexDirection(Axis? v) {
    base.flexDirection = v;
  }

  bool? get flexWrap => base.flexWrap;
  set flexWrap(bool? v) {
    base.flexWrap = v;
  }

  CrossAxisAlignment? get alignItems => base.alignItems;
  set alignItems(CrossAxisAlignment? v) {
    base.alignItems = v;
  }

  MainAxisAlignment? get justifyContent => base.justifyContent;
  set justifyContent(MainAxisAlignment? v) {
    base.justifyContent = v;
  }

  double? get minWidth => base.minWidth;
  set minWidth(double? v) {
    base.minWidth = v;
  }

  double? get maxWidth => base.maxWidth;
  set maxWidth(double? v) {
    base.maxWidth = v;
  }

  double? get minHeight => base.minHeight;
  set minHeight(double? v) {
    base.minHeight = v;
  }

  double? get maxHeight => base.maxHeight;
  set maxHeight(double? v) {
    base.maxHeight = v;
  }

  double? get aspectRatio => base.aspectRatio;
  set aspectRatio(double? v) {
    base.aspectRatio = v;
  }

  BoxFit? get boxFit => base.boxFit;
  set boxFit(BoxFit? v) {
    base.boxFit = v;
  }

  AlignmentGeometry? get alignment => base.alignment;
  set alignment(AlignmentGeometry? v) {
    base.alignment = v;
  }

  Clip? get overflow => base.overflow;
  set overflow(Clip? v) {
    base.overflow = v;
  }

  String? get inputLabelText => base.inputLabelText;
  set inputLabelText(String? v) {
    base.inputLabelText = v;
  }

  String? get inputHintText => base.inputHintText;
  set inputHintText(String? v) {
    base.inputHintText = v;
  }

  String? get inputHelperText => base.inputHelperText;
  set inputHelperText(String? v) {
    base.inputHelperText = v;
  }

  String? get inputErrorText => base.inputErrorText;
  set inputErrorText(String? v) {
    base.inputErrorText = v;
  }

  String? get inputPrefixText => base.inputPrefixText;
  set inputPrefixText(String? v) {
    base.inputPrefixText = v;
  }

  String? get inputSuffixText => base.inputSuffixText;
  set inputSuffixText(String? v) {
    base.inputSuffixText = v;
  }

  bool? get inputFilled => base.inputFilled;
  set inputFilled(bool? v) {
    base.inputFilled = v;
  }

  bool? get inputDense => base.inputDense;
  set inputDense(bool? v) {
    base.inputDense = v;
  }

  bool get isImportant => base.isImportant;
  set isImportant(bool v) {
    base.isImportant = v;
  }

  /// Returns variant styles as a map built from conditional parser rules.
  /// Key is the joined condition name(s), value is the associated style.
  /// Returns `null` when there are no rules (backward-compatible with
  /// [DacsStyle.variants]).
  Map<String, DacsStyle>? get variants {
    if (_rules.isEmpty) return null;
    final map = <String, DacsStyle>{};
    for (final rule in _rules) {
      final key = rule.conditions.map((c) => c.name).join(':');
      map.putIfAbsent(key, DacsStyle.new).mergeFrom(rule.style);
    }
    return map;
  }

  // ── Forwarded methods ──

  DacsStyle clone() => base.clone();
  void mergeFrom(DacsStyle source) => base.mergeFrom(source);
  DacsStyle copyWith(DacsStyle? style) => base.copyWith(style);
  void resolveThemeColors(BuildContext context) =>
      base.resolveThemeColors(context);

  Matrix4 toMatrix4() => base.toMatrix4();
  TextStyle toTextStyle() => base.toTextStyle();
  EdgeInsets toPadding() => base.toPadding();
  EdgeInsets toMargin() => base.toMargin();
  LinearGradient? toGradient() => base.toGradient();
  BoxDecoration toBoxDecoration() => base.toBoxDecoration();
  BoxBorder? toBorder() => base.toBorder();
  BorderSide? toBorderSide() => base.toBorderSide();
  BorderRadiusGeometry? toRadius() => base.toRadius();
  BoxConstraints? toConstraints() => base.toConstraints();
  AlignmentGeometry? toAlignment() => base.toAlignment();
  ShapeBorder? toShapeBorder() => base.toShapeBorder();
  Size? toFixedSize() => base.toFixedSize();
  DacsLayoutStyle toLayoutStyle() => base.toLayoutStyle();

  // ── Sheet-specific API ──

  /// Backward-compatible access to variant styles as a map.
  Map<String, DacsStyle> get ruleVariants {
    if (_rules.isEmpty) return const {};
    final map = <String, DacsStyle>{};
    for (final rule in _rules) {
      final key = rule.conditions.map((c) => c.name).join(':');
      map.putIfAbsent(key, DacsStyle.new).mergeFrom(rule.style);
    }
    return map;
  }

  /// Resolves this stylesheet against the given [brightness] and
  /// [screenWidth], returning a resolved [DacsStyle].
  ///
  /// All original rules are preserved in the result's [DacsStyle.variants]
  /// map. Rules whose non-WidgetState conditions match are additionally
  /// merged into the base (if no WidgetState conditions) or remapped under
  /// the remaining WidgetState-only key.
  DacsStyle resolve({Brightness? brightness, double? screenWidth}) {
    if (_rules.isEmpty) return base.clone();
    final result = base.clone();
    final orderedRules = [..._rules]
      ..sort((a, b) => a.sourceOrder.compareTo(b.sourceOrder));

    // Preserve all original rules as variants (backward compat: unmatched
    // compound conditions remain in the variants map).
    for (final rule in orderedRules) {
      final key = rule.conditions.map((c) => c.name).join(':');
      result.variants ??= {};
      result.variants!.putIfAbsent(key, DacsStyle.new).mergeFrom(rule.style);
    }

    // Merge or remap rules whose non-WidgetState conditions match.
    for (final rule in orderedRules) {
      final wsConditions = rule.widgetStateConditions;
      final nonWsConditions = rule.nonWidgetStateConditions;
      final allNonWsMatch = nonWsConditions.every(
          (c) => c.matches(brightness: brightness, screenWidth: screenWidth));

      if (!allNonWsMatch) continue;

      if (wsConditions.isEmpty) {
        _mergeRule(rule, result);
      } else {
        final newKey = wsConditions.map((c) => c.name).join(':');
        result.variants ??= {};
        if (result.variants!.containsKey(newKey)) {
          if (newKey.contains(':')) {
            result.variants![newKey]!.mergeFrom(rule.style);
          }
        } else {
          result.variants![newKey] = DacsStyle()..mergeFrom(rule.style);
        }
      }
    }

    return result;
  }

  /// Resolves using an internal resolution context.
  DacsStyle resolveWith(Object context) {
    final resolveContext = context as DacsResolveContext;
    final result = resolve(
      brightness: resolveContext.brightness,
      screenWidth: resolveContext.screenWidth,
    );
    final buildContext = resolveContext.buildContext;
    if (buildContext != null) {
      result.resolveThemeColors(buildContext);
    }
    return result;
  }

  /// Resolves using [MediaQuery] from [context], then resolves theme colors.
  DacsStyle resolveFor(BuildContext context) {
    return resolveWith(DacsResolveContext.fromBuildContext(context));
  }

  void _mergeRule(DacsConditionalRule rule, DacsStyle target) {
    if (target.isImportant) return;
    target.mergeFrom(rule.style);
  }
}

/// Splits a compound variant key into individual conditions.
List<String> splitVariantKey(String key) => key.split(':');
