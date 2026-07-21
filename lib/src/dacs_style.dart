import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;
import 'tokens/variants.dart';

/// Direction for linear gradient.
enum DacsGradientDirection {
  toR,
  toL,
  toT,
  toB,
  toTR,
  toTL,
  toBR,
  toBL;

  Alignment get begin => switch (this) {
    toR => Alignment.centerLeft,
    toL => Alignment.centerRight,
    toT => Alignment.bottomCenter,
    toB => Alignment.topCenter,
    toTR => Alignment.bottomLeft,
    toTL => Alignment.bottomRight,
    toBR => Alignment.topLeft,
    toBL => Alignment.topRight,
  };

  Alignment get end => switch (this) {
    toR => Alignment.centerRight,
    toL => Alignment.centerLeft,
    toT => Alignment.topCenter,
    toB => Alignment.bottomCenter,
    toTR => Alignment.topRight,
    toTL => Alignment.topLeft,
    toBR => Alignment.bottomRight,
    toBL => Alignment.bottomLeft,
  };
}

/// Holds parsed Tailwind-like utility class values.
///
/// Use [toTextStyle], [toEdgeInsets], [toBoxDecoration] to convert to Flutter types.
class DacsStyle {
  /// Font size in logical pixels.
  double? fontSize;
  /// Font weight (e.g. bold, medium).
  FontWeight? fontWeight;
  /// Text or foreground color.
  Color? color;
  /// Background color.
  Color? backgroundColor;
  /// Border color.
  Color? borderColor;
  /// Border width in logical pixels.
  double? borderWidth;
  /// Padding or margin insets.
  EdgeInsets? edgeInsets;
  /// Border radius.
  BorderRadiusGeometry? borderRadius;
  /// Explicit width.
  double? width;
  /// Explicit height.
  double? height;
  /// Opacity from 0.0 to 1.0.
  double? opacity;
  /// Font style (normal or italic).
  FontStyle? fontStyle;
  /// Text decoration (underline, line-through, etc.).
  TextDecoration? textDecoration;
  /// Text decoration color.
  Color? textDecorationColor;
  /// Text decoration style (solid, double, dotted, dashed, wavy).
  TextDecorationStyle? textDecorationStyle;
  /// Text decoration thickness.
  double? textDecorationThickness;
  /// Letter spacing in logical pixels.
  double? letterSpacing;
  /// Line height (multiplier of font size).
  double? lineHeight;
  /// Shadow effects.
  List<BoxShadow>? boxShadow;
  /// Inset top position.
  double? insetTop;
  /// Inset right position.
  double? insetRight;
  /// Inset bottom position.
  double? insetBottom;
  /// Inset left position.
  double? insetLeft;
  /// Scale factor on X axis.
  double? scaleX;
  /// Scale factor on Y axis.
  double? scaleY;
  /// Rotation in degrees.
  double? rotateDegrees;
  /// Translation on X axis.
  double? translateX;
  /// Translation on Y axis.
  double? translateY;
  /// Skew angle on X axis in degrees.
  double? skewX;
  /// Skew angle on Y axis in degrees.
  double? skewY;
  /// Gradient direction.
  DacsGradientDirection? gradientDirection;
  /// Start color of the gradient.
  Color? gradientFromColor;
  /// Midpoint color of a three-stop gradient.
  Color? gradientViaColor;
  /// End color of the gradient.
  Color? gradientToColor;
  /// Responsive and dark/light variant overrides.
  Map<String, DacsStyle>? variants;

  /// Converts parsed transform properties to a [vmath.Matrix4].
  vmath.Matrix4 toMatrix4() {
    final m = vmath.Matrix4.identity();
    if (translateX != null || translateY != null) {
      m.translateByVector3(vmath.Vector3(translateX ?? 0, translateY ?? 0, 0));
    }
    if (rotateDegrees != null) {
      m.rotateZ(rotateDegrees! * (math.pi / 180));
    }
    if (scaleX != null || scaleY != null) {
      m.scaleByVector3(vmath.Vector3(scaleX ?? 1, scaleY ?? 1, 1));
    }
    if (skewX != null) {
      m.setEntry(0, 1, math.tan(skewX! * math.pi / 180));
    }
    if (skewY != null) {
      m.setEntry(1, 0, math.tan(skewY! * math.pi / 180));
    }
    return m;
  }

  /// Converts parsed properties to a [TextStyle].
  TextStyle toTextStyle() {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      fontStyle: fontStyle,
      decoration: textDecoration,
      decorationColor: textDecorationColor,
      decorationStyle: textDecorationStyle,
      decorationThickness: textDecorationThickness,
      letterSpacing: letterSpacing,
      height: lineHeight,
    );
  }

  /// Converts parsed edge insets to [EdgeInsets]. Returns [EdgeInsets.zero] if none set.
  EdgeInsets toEdgeInsets() {
    return edgeInsets ?? EdgeInsets.zero;
  }

  /// Builds a [LinearGradient] from parsed gradient properties, or null.
  LinearGradient? toGradient() {
    if (gradientDirection == null || gradientToColor == null) return null;
    final colors = <Color>[
      gradientFromColor ?? const Color(0x00000000),
      ?gradientViaColor,
      gradientToColor!,
    ];
    final stops = gradientViaColor != null ? [0.0, 0.5, 1.0] : [0.0, 1.0];
    return LinearGradient(
      begin: gradientDirection!.begin,
      end: gradientDirection!.end,
      colors: colors,
      stops: stops,
    );
  }

  /// Converts parsed properties to a [BoxDecoration].
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
      gradient: toGradient(),
      borderRadius: borderRadius,
      border: border,
      boxShadow: boxShadow,
    );
  }

  /// Resolves variants using [context] (brightness + screen width).
  DacsStyle resolveFor(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    final screenWidth = MediaQuery.of(context).size.width;
    return resolve(brightness: brightness, screenWidth: screenWidth);
  }

  /// Resolves variants with explicit [brightness] and [screenWidth] values.
  DacsStyle resolve({Brightness? brightness, double? screenWidth}) {
    if (variants == null || variants!.isEmpty) return this;
    final result = clone();

    if (screenWidth != null) {
      for (final bp in dacsBreakpointOrder) {
        final minWidth = dacsBreakpoints[bp] ?? double.infinity;
        if (screenWidth >= minWidth) {
          final variant = variants![bp];
          if (variant != null) result.mergeFrom(variant);
        }
      }
    }

    if (brightness != null) {
      final mode = brightness == Brightness.dark ? 'dark' : 'light';
      final variant = variants![mode];
      if (variant != null) result.mergeFrom(variant);
    }

    return result;
  }

  /// Returns a deep copy of this style.
  DacsStyle clone() {
    final target = DacsStyle();
    target.mergeFrom(this);
    return target;
  }

  /// Merges non-null properties from [source] into this style.
  void mergeFrom(DacsStyle source) {
    fontSize = source.fontSize ?? fontSize;
    fontWeight = source.fontWeight ?? fontWeight;
    color = source.color ?? color;
    backgroundColor = source.backgroundColor ?? backgroundColor;
    borderColor = source.borderColor ?? borderColor;
    borderWidth = source.borderWidth ?? borderWidth;
    edgeInsets = source.edgeInsets ?? edgeInsets;
    borderRadius = source.borderRadius ?? borderRadius;
    width = source.width ?? width;
    height = source.height ?? height;
    opacity = source.opacity ?? opacity;
    fontStyle = source.fontStyle ?? fontStyle;
    textDecoration = source.textDecoration ?? textDecoration;
    textDecorationColor = source.textDecorationColor ?? textDecorationColor;
    textDecorationStyle = source.textDecorationStyle ?? textDecorationStyle;
    textDecorationThickness =
        source.textDecorationThickness ?? textDecorationThickness;
    letterSpacing = source.letterSpacing ?? letterSpacing;
    lineHeight = source.lineHeight ?? lineHeight;
    boxShadow = source.boxShadow ?? boxShadow;
    insetTop = source.insetTop ?? insetTop;
    insetRight = source.insetRight ?? insetRight;
    insetBottom = source.insetBottom ?? insetBottom;
    insetLeft = source.insetLeft ?? insetLeft;
    scaleX = source.scaleX ?? scaleX;
    scaleY = source.scaleY ?? scaleY;
    rotateDegrees = source.rotateDegrees ?? rotateDegrees;
    translateX = source.translateX ?? translateX;
    translateY = source.translateY ?? translateY;
    skewX = source.skewX ?? skewX;
    skewY = source.skewY ?? skewY;
    gradientDirection = source.gradientDirection ?? gradientDirection;
    gradientFromColor = source.gradientFromColor ?? gradientFromColor;
    gradientViaColor = source.gradientViaColor ?? gradientViaColor;
    gradientToColor = source.gradientToColor ?? gradientToColor;
    if (source.variants != null) {
      variants ??= {};
      variants!.addAll(source.variants!);
    }
  }
}
