import 'package:flutter/painting.dart';
import '../dacs_style.dart';
import '../parsers/class_parser.dart';

/// Extension methods on [String] to parse Tailwind-like utility classes.
///
/// ```dart
/// 'text-2xl font-medium text-sky-500'.dacsText
/// 'px-4 py-2'.dacsPad
/// 'bg-blue-500 rounded-lg'.dacsBox
/// ```
extension DacsStringExtension on String {
  /// Parses the string and returns the raw [DacsStyle] object.
  DacsStyle get dacsStyle {
    final parser = ClassParser();
    return parser.parse(this);
  }

  /// Parses the string and converts to a [TextStyle].
  ///
  /// Supports: text-*, font-*, text-{color}-{shade}, leading-*, tracking-*,
  /// italic, underline, line-through.
  TextStyle get dacsText => dacsStyle.toTextStyle();

  /// Parses the string and converts to padding [EdgeInsets].
  ///
  /// Supports: p-*, px-*, py-*, pt-*, pr-*, pb-*, pl-*.
  EdgeInsets get dacsPad => dacsStyle.toPadding();

  /// Parses the string and converts to margin [EdgeInsets].
  ///
  /// Supports: m-*, mx-*, my-*, mt-*, mr-*, mb-*, ml-*.
  EdgeInsets get dacsMargin => dacsStyle.toMargin();

  /// Parses the string and converts to a [BoxDecoration].
  ///
  /// Supports: bg-{color}-{shade}, rounded-*, border-*, border-{color}-{shade}.
  BoxDecoration get dacsBox => dacsStyle.toBoxDecoration();
}
