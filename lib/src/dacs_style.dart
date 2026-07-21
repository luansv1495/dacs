import 'package:flutter/painting.dart';

/// Holds parsed Tailwind-like utility class values.
///
/// Use [toTextStyle], [toPadding], [toMargin], or [toBoxDecoration]
/// to convert to Flutter types.
class DacsStyle {
  double? fontSize;
  FontWeight? fontWeight;
  Color? color;
  Color? backgroundColor;
  Color? borderColor;
  double? borderWidth;
  EdgeInsets? padding;
  EdgeInsets? margin;
  BorderRadiusGeometry? borderRadius;
  double? width;
  double? height;
  double? opacity;
  FontStyle? fontStyle;
  TextDecoration? textDecoration;
  Color? textDecorationColor;
  double? letterSpacing;
  double? lineHeight;

  /// Converts parsed properties to a [TextStyle].
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      decoration: textDecoration,
      decorationColor: textDecorationColor,
      letterSpacing: letterSpacing,
      height: lineHeight,
    );
  }

  /// Converts parsed padding to [EdgeInsets]. Returns [EdgeInsets.zero] if no padding was set.
  EdgeInsets toPadding() {
    return padding ?? EdgeInsets.zero;
  }

  /// Converts parsed margin to [EdgeInsets]. Returns [EdgeInsets.zero] if no margin was set.
  EdgeInsets toMargin() {
    return margin ?? EdgeInsets.zero;
  }

  /// Converts parsed properties to a [BoxDecoration] (background color, border radius, border).
  BoxDecoration toBoxDecoration() {
    BoxBorder? border;
    if (borderColor != null || borderWidth != null) {
      border = Border.all(
        color: borderColor ?? const Color(0xFF000000),
        width: borderWidth ?? 1.0,
      );
    }

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: borderRadius,
      border: border,
    );
  }
}
