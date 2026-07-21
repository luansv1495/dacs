import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;
import '../dacs_style.dart';
import '../parsers/class_parser.dart';

/// Extension providing simple getters on [String] that parse DACS classes
/// and return Flutter style objects directly (no context required, no
/// variant resolution).
extension DacsStringExtension on String {
  /// Parses this string into a raw [DacsStyle] without variant resolution.
  DacsStyle get dStyle {
    final parser = ClassParser();
    return parser.parse(this);
  }

  /// Parses this string into a [TextStyle].
  TextStyle get dText => dStyle.toTextStyle();

  /// Parses padding classes (p-*, px-*, py-*, pt-*, etc.) into [EdgeInsets].
  EdgeInsets get dPads => dStyle.toPadding();

  /// Parses margin classes (m-*, mx-*, my-*, mt-*, etc.) into [EdgeInsets].
  EdgeInsets get dMargin => dStyle.toMargin();

  /// Parses background, border, shadow, and gradient classes into a
  /// [BoxDecoration].
  BoxDecoration get dBox => dStyle.toBoxDecoration();

  /// Parses shadow classes into a list of [BoxShadow].
  List<BoxShadow> get dShadow => dStyle.boxShadow ?? [];

  /// Parses width and height classes into a `(width, height)` tuple.
  (double?, double?) get dSize => (dStyle.width, dStyle.height);

  /// Parses inset classes into a `(top, right, bottom, left)` tuple for use
  /// with [Positioned].
  (double?, double?, double?, double?) get dPosition => (
    dStyle.insetTop,
    dStyle.insetRight,
    dStyle.insetBottom,
    dStyle.insetLeft,
  );

  /// Parses transform classes into a [Matrix4].
  vmath.Matrix4 get dTransform => dStyle.toMatrix4();

  /// Parses gradient classes into a [LinearGradient], or `null` if no
  /// gradient is configured.
  LinearGradient? get dGradient => dStyle.toGradient();
}

/// Extension providing context-aware methods on [String] that parse DACS
/// classes, resolve variants (dark/light, responsive), and resolve theme
/// colors from the current [BuildContext].
extension DacsContextExtension on String {
  /// Parses this string into a [DacsStyle] with variants and theme colors
  /// resolved from [context].
  DacsStyle dStyleOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context);

  /// Parses this string into a [TextStyle] with variant and theme resolution.
  TextStyle dTextOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toTextStyle();

  /// Parses padding classes into [EdgeInsets] with variant resolution.
  EdgeInsets dPadsOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toPadding();

  /// Parses margin classes into [EdgeInsets] with variant resolution.
  EdgeInsets dMarginOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toMargin();

  /// Parses decoration classes into a [BoxDecoration] with variant resolution.
  BoxDecoration dBoxOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toBoxDecoration();

  /// Parses shadow classes into a list of [BoxShadow] with variant resolution.
  List<BoxShadow> dShadowOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).boxShadow ?? [];

  /// Parses width/height classes into a `(width, height)` tuple with variant
  /// resolution.
  (double?, double?) dSizeOf(BuildContext context) {
    final s = ClassParser().parse(this).resolveFor(context);
    return (s.width, s.height);
  }

  /// Parses inset classes into a `(top, right, bottom, left)` tuple with
  /// variant resolution.
  (double?, double?, double?, double?) dPositionOf(BuildContext context) {
    final s = ClassParser().parse(this).resolveFor(context);
    return (s.insetTop, s.insetRight, s.insetBottom, s.insetLeft);
  }

  /// Parses transform classes into a [Matrix4] with variant resolution.
  vmath.Matrix4 dTransformOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toMatrix4();

  /// Parses gradient classes into a [LinearGradient] with variant resolution.
  LinearGradient? dGradientOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toGradient();
}
