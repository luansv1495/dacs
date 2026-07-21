import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;
import '../dacs_style.dart';
import '../parsers/class_parser.dart';

/// Extension methods on [String] to parse Tailwind-like utility classes.
///
/// ```dart
/// 'text-2xl font-medium text-sky-500'.dText
/// 'px-4 py-2'.dPads
/// 'bg-blue-500 rounded-lg'.dBox
/// ```
extension DacsStringExtension on String {
  /// Parses the string and returns the raw [DacsStyle] object.
  DacsStyle get dStyle {
    final parser = ClassParser();
    return parser.parse(this);
  }

  /// Parses the string and converts to a [TextStyle].
  TextStyle get dText => dStyle.toTextStyle();

  /// Parses the string and converts to [EdgeInsets].
  EdgeInsets get dPads => dStyle.toEdgeInsets();

  /// Parses the string and converts to a [BoxDecoration].
  BoxDecoration get dBox => dStyle.toBoxDecoration();

  /// Parses the string and returns shadow [BoxShadow] list.
  List<BoxShadow> get dShadow => dStyle.boxShadow ?? [];

  /// Parses the string and returns a (width, height) record.
  (double?, double?) get dSize => (dStyle.width, dStyle.height);

  /// Parses the string and returns a (top, right, bottom, left) position tuple.
  (double?, double?, double?, double?) get dPosition => (
    dStyle.insetTop,
    dStyle.insetRight,
    dStyle.insetBottom,
    dStyle.insetLeft,
  );

  /// Parses the string and returns a [Matrix4] combining all transforms.
  vmath.Matrix4 get dTransform => dStyle.toMatrix4();

  /// Parses the string and returns a [LinearGradient].
  LinearGradient? get dGradient => dStyle.toGradient();
}

/// Context-aware extension methods on [String].
///
/// These methods resolve responsive and dark/light variants using [BuildContext].
extension DacsContextExtension on String {
  /// Parses the string and resolves variants into a [DacsStyle].
  DacsStyle dStyleOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context);

  /// Parses and resolves variants into a [TextStyle].
  TextStyle dTextOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toTextStyle();

  /// Parses and resolves variants into [EdgeInsets].
  EdgeInsets dPadsOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toEdgeInsets();

  /// Parses and resolves variants into a [BoxDecoration].
  BoxDecoration dBoxOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toBoxDecoration();

  /// Parses and resolves variants into a shadow list.
  List<BoxShadow> dShadowOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).boxShadow ?? [];

  /// Parses and resolves variants into a (width, height) record.
  (double?, double?) dSizeOf(BuildContext context) {
    final s = ClassParser().parse(this).resolveFor(context);
    return (s.width, s.height);
  }

  /// Parses and resolves variants into a position tuple.
  (double?, double?, double?, double?) dPositionOf(BuildContext context) {
    final s = ClassParser().parse(this).resolveFor(context);
    return (s.insetTop, s.insetRight, s.insetBottom, s.insetLeft);
  }

  /// Parses and resolves variants into a [Matrix4].
  vmath.Matrix4 dTransformOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toMatrix4();

  /// Parses and resolves variants into a [LinearGradient].
  LinearGradient? dGradientOf(BuildContext context) =>
      ClassParser().parse(this).resolveFor(context).toGradient();
}
