import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;
import '../dacs_compiler.dart';
import '../dacs_layout_style.dart';
import '../dacs_resolved_style.dart';
import '../dacs_style.dart';
import '../dacs_style_sheet.dart';

/// Extension providing simple getters on [String] that parse DACS classes
/// and return Flutter style objects directly (no context required, no
/// variant resolution).
extension DacsStringExtension on String {
  /// Parses this string into a [DacsStyleSheet] containing the base style and
  /// all conditional rules.
  DacsStyleSheet get dStyle => DacsCompiler.compile(this);

  /// Parses this string into a [DacsStyle] (base values only, no variants).
  DacsStyle get dBase => dStyle.base;

  /// Parses this string into a [TextStyle].
  TextStyle get dText => dBase.toTextStyle();

  /// Parses padding classes (p-*, px-*, py-*, pt-*, etc.) into [EdgeInsets].
  EdgeInsets get dPads => dBase.toPadding();

  /// Parses margin classes (m-*, mx-*, my-*, mt-*, etc.) into [EdgeInsets].
  EdgeInsets get dMargin => dBase.toMargin();

  /// Parses background, border, shadow, and gradient classes into a
  /// [BoxDecoration].
  BoxDecoration get dBox => dBase.toBoxDecoration();

  /// Parses shadow classes into a list of [BoxShadow].
  List<BoxShadow> get dShadow => dBase.boxShadow ?? [];

  /// Parses width and height classes into a `(width, height)` tuple.
  (double?, double?) get dSize => (dBase.width, dBase.height);

  /// Parses width and height classes into a [Size], or `null`.
  Size? get dFixedSize => dBase.toFixedSize();

  /// Parses layout-related classes into a [DacsLayoutStyle].
  DacsLayoutStyle get dLayout => dBase.toLayoutStyle();

  /// Parses inset classes into a `(top, right, bottom, left)` tuple for use
  /// with [Positioned].
  (double?, double?, double?, double?) get dPosition => (
        dBase.insetTop,
        dBase.insetRight,
        dBase.insetBottom,
        dBase.insetLeft,
      );

  /// Parses transform classes into a [Matrix4].
  vmath.Matrix4 get dTransform => dBase.toMatrix4();

  /// Parses gradient classes into a [LinearGradient], or `null` if no
  /// gradient is configured.
  LinearGradient? get dGradient => dBase.toGradient();

  /// Parses border classes into a [BoxBorder], or `null`.
  BoxBorder? get dBorder => dBase.toBorder();

  /// Parses border classes into a [BorderSide], or `null`.
  BorderSide? get dBorderSide => dBase.toBorderSide();

  /// Parses rounded classes into a [BorderRadiusGeometry], or `null`.
  BorderRadiusGeometry? get dRadius => dBase.toRadius();

  /// Parses width/height/min/max classes into [BoxConstraints], or `null`.
  BoxConstraints? get dConstraints => dBase.toConstraints();

  /// Parses alignment classes into an [AlignmentGeometry], or `null`.
  AlignmentGeometry? get dAlignment => dBase.toAlignment();

  /// Parses rounded classes into a [ShapeBorder], or `null`.
  ShapeBorder? get dShapeBorder => dBase.toShapeBorder();
}

/// Extension providing context-aware methods on [String] that parse DACS
/// classes, resolve variants (dark/light, responsive), and resolve theme
/// colors from the current [BuildContext].
extension DacsContextExtension on String {
  /// Parses this string into a [DacsResolvedStyle] with variants and theme colors
  /// resolved from [context].
  DacsResolvedStyle dStyleOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context);

  /// Parses this string into a [TextStyle] with variant and theme resolution.
  TextStyle dTextOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toTextStyle();

  /// Parses padding classes into [EdgeInsets] with variant resolution.
  EdgeInsets dPadsOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toPadding();

  /// Parses margin classes into [EdgeInsets] with variant resolution.
  EdgeInsets dMarginOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toMargin();

  /// Parses decoration classes into a [BoxDecoration] with variant resolution.
  BoxDecoration dBoxOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toBoxDecoration();

  /// Parses shadow classes into a list of [BoxShadow] with variant resolution.
  List<BoxShadow> dShadowOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).boxShadow ?? [];

  /// Parses width/height classes into a `(width, height)` tuple with variant
  /// resolution.
  (double?, double?) dSizeOf(BuildContext context) {
    final s = DacsCompiler.compile(this).resolveFor(context);
    return (s.width, s.height);
  }

  /// Parses width/height classes into a [Size] with variant resolution.
  Size? dFixedSizeOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toFixedSize();

  /// Parses layout classes into a [DacsLayoutStyle] with variant resolution.
  DacsLayoutStyle dLayoutOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toLayoutStyle();

  /// Parses inset classes into a `(top, right, bottom, left)` tuple with
  /// variant resolution.
  (double?, double?, double?, double?) dPositionOf(BuildContext context) {
    final s = DacsCompiler.compile(this).resolveFor(context);
    return (s.insetTop, s.insetRight, s.insetBottom, s.insetLeft);
  }

  /// Parses transform classes into a [Matrix4] with variant resolution.
  vmath.Matrix4 dTransformOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toMatrix4();

  /// Parses gradient classes into a [LinearGradient] with variant resolution.
  LinearGradient? dGradientOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toGradient();

  /// Parses border classes into a [BoxBorder] with variant resolution.
  BoxBorder? dBorderOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toBorder();

  /// Parses border classes into a [BorderSide] with variant resolution.
  BorderSide? dBorderSideOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toBorderSide();

  /// Parses rounded classes into a [BorderRadiusGeometry] with variant resolution.
  BorderRadiusGeometry? dRadiusOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toRadius();

  /// Parses constraint classes into [BoxConstraints] with variant resolution.
  BoxConstraints? dConstraintsOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toConstraints();

  /// Parses alignment classes into [AlignmentGeometry] with variant resolution.
  AlignmentGeometry? dAlignmentOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toAlignment();

  /// Parses rounded classes into a [ShapeBorder] with variant resolution.
  ShapeBorder? dShapeBorderOf(BuildContext context) =>
      DacsCompiler.compile(this).resolveFor(context).toShapeBorder();
}

/// A [Tween] subclass that interpolates between two [DacsStyle] values.
///
/// Numeric fields (fontSize, opacity, borderWidth, etc.) are linearly
/// interpolated. Non-numeric fields (color, fontWeight, padding, etc.) use
/// step interpolation at `t = 0.5`.
class DacsStyleTween extends Tween<DacsStyle> {
  /// Creates a tween between two [DacsStyle] values.
  DacsStyleTween({super.begin, super.end});

  @override
  DacsStyle lerp(double t) {
    final b = begin!;
    final e = end!;
    final result = DacsStyle();
    result.fontSize = _lerpDouble(b.fontSize, e.fontSize, t);
    result.opacity = _lerpDouble(b.opacity, e.opacity, t);
    result.borderWidth = _lerpDouble(b.borderWidth, e.borderWidth, t);
    result.letterSpacing = _lerpDouble(b.letterSpacing, e.letterSpacing, t);
    result.lineHeight = _lerpDouble(b.lineHeight, e.lineHeight, t);
    result.scaleX = _lerpDouble(b.scaleX, e.scaleX, t);
    result.scaleY = _lerpDouble(b.scaleY, e.scaleY, t);
    result.rotateDegrees = _lerpDouble(b.rotateDegrees, e.rotateDegrees, t);
    result.translateX = _lerpDouble(b.translateX, e.translateX, t);
    result.translateY = _lerpDouble(b.translateY, e.translateY, t);
    result.skewX = _lerpDouble(b.skewX, e.skewX, t);
    result.skewY = _lerpDouble(b.skewY, e.skewY, t);
    result.insetTop = _lerpDouble(b.insetTop, e.insetTop, t);
    result.insetRight = _lerpDouble(b.insetRight, e.insetRight, t);
    result.insetBottom = _lerpDouble(b.insetBottom, e.insetBottom, t);
    result.insetLeft = _lerpDouble(b.insetLeft, e.insetLeft, t);
    result.gap = _lerpDouble(b.gap, e.gap, t);
    result.width = _lerpDouble(b.width, e.width, t);
    result.height = _lerpDouble(b.height, e.height, t);
    result.minWidth = _lerpDouble(b.minWidth, e.minWidth, t);
    result.maxWidth = _lerpDouble(b.maxWidth, e.maxWidth, t);
    result.minHeight = _lerpDouble(b.minHeight, e.minHeight, t);
    result.maxHeight = _lerpDouble(b.maxHeight, e.maxHeight, t);
    result.aspectRatio = _lerpDouble(b.aspectRatio, e.aspectRatio, t);
    result.color = t < 0.5 ? b.color : e.color;
    result.backgroundColor = t < 0.5 ? b.backgroundColor : e.backgroundColor;
    result.borderColor = t < 0.5 ? b.borderColor : e.borderColor;
    result.fontWeight = t < 0.5 ? b.fontWeight : e.fontWeight;
    result.padding = t < 0.5 ? b.padding : e.padding;
    result.margin = t < 0.5 ? b.margin : e.margin;
    result.borderRadius = t < 0.5 ? b.borderRadius : e.borderRadius;
    result.boxShadow = t < 0.5 ? b.boxShadow : e.boxShadow;
    result.flex = t < 0.5 ? b.flex : e.flex;
    result.flexDirection = t < 0.5 ? b.flexDirection : e.flexDirection;
    result.flexWrap = t < 0.5 ? b.flexWrap : e.flexWrap;
    result.alignItems = t < 0.5 ? b.alignItems : e.alignItems;
    result.justifyContent = t < 0.5 ? b.justifyContent : e.justifyContent;
    result.boxFit = t < 0.5 ? b.boxFit : e.boxFit;
    result.alignment = t < 0.5 ? b.alignment : e.alignment;
    result.overflow = t < 0.5 ? b.overflow : e.overflow;
    return result;
  }

  double? _lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    a ??= 0;
    b ??= 0;
    return a + (b - a) * t;
  }
}

/// Extension on [Animation<double>] to produce an [Animation<DacsStyle>]
/// by interpolating between two [DacsStyle] values.
extension DacsAnimatedExtension on Animation<double> {
  /// Creates an [Animation<DacsStyle>] that interpolates between [begin]
  /// and [end] [DacsStyle] values as this animation progresses.
  Animation<DacsStyle> dAnimated(DacsStyle begin, DacsStyle end) {
    return DacsStyleTween(begin: begin, end: end).animate(this);
  }
}
